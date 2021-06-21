#!/bin/bash

# TODO Make some flag to add a user or not
source ./utility.sh
function check_internet() {
    messout "Checking Internet" header
    ping -c 2 archlinux.org
    [[ $? != 0 ]] && messout "No internet" error && messout "Aborting" error && exit 1
}

function update_timezone() {
    messout "Time zone" info
    ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
    hwclock --systohc
}

function update_keyboard_layout() {
    messout "Keyboard layout" info
    add_string_to_file 'LANG="en_US.UTF-8"' >> /etc/locale.conf
    sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
    # add_string_to_file "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
}

function update_mirror_list() {
    pacman --noconfirm --needed -S pacman-contrib
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    rankmirrors -n 10 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
}

function get_root_password() {
    messout "Root password" header
    count=0
    passwd
    while [ $? -ne 0 ]
    do
        count=$((count+1))
        [[ count == 3 ]] && messout "Wrong root password 3 times. Aborting" error && exit 1
        messout "Please enter right root password" caution
        passwd
    done
}

function ask_username(){
    read -p "Username: " username

    confirm
    case $choice in
        n ) ask_username;;
    esac
}

function add_new_user() {
    messout "Adding user" header
    ask_username
    confirm_messsage "Add user"
    case $choice in
        y ) 
            flag=""
            [[ ! -d /home/$username ]] && flag="-m"
            useradd $flag -G wheel -s /bin/bash $username;;
    esac

    messout "Add password" header
    confirm
    case $choice in
        y ) passwd $username
            count=0
            while [[ $? -ne 0 && $count -lt 2 ]]
            do
                messout "Please enter right password" caution
                passwd $username
                count=$((count+1))
            done
            [[ $count == 2 ]] && messout "Wrong password more than 3 times" warning
            ;;
    esac
}

function network_config() {
    add_string_to_file $username /etc/hostname
    add_string_to_file "127.0.0.1 localhost\n::1\tlocalhost\n127.0.1.1 ${username}.localdomain ${username}" /etc/hosts
}

function intel_ucode() {
    pacman --noconfirm --needed -S intel-ucode
}

function install_grub() {
    messout "Install grub" header
    pacman --noconfirm --needed -S grub efibootmgr
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg

    pacman --noconfirm --needed -S dhcpcd
    pacman --noconfirm --needed -S vi
    systemctl enable dhcpcd
}

function allow_user_to_run_sudo() {
    export EDITOR=nvim
    add_string_to_file "%wheel ALL=(ALL) ALL\n%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/systemctl restart NetworkManager,/usr/bin/rc-service NetworkManager restart,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/yay,/usr/bin/pacman -Syyuw --noconfirm,/usr/bin/xbacklight -inc 5,/usr/bin/xbacklight -dec 5" /etc/sudoers
}

function main() {
    check_internet
    update_timezone
    update_keyboard_layout
    update_mirror_list
    get_root_password
    add_new_user
    network_config
    intel_ucode
    install_grub
    allow_user_to_run_sudo
}

main
exit 0
