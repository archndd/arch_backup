#!/bin/bash

# TODO Make some flag to add a user or not
source ./utility.sh

function update_timezone() {
    messout "Time zone" info
    ln -sf /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime
    hwclock --systohc
}

function update_keyboard_layout() {
    messout "Keyboard layout" info
    echo 'LANG="en_US.UTF-8"' >> /etc/locale.conf
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
}

function get_root_password() {
    messout "Root password" header
    passwd
    while [ $? -ne 0 ]
    do
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
    messout "Add user: " header
    confirm
    case $choice in
        y ) useradd -G wheel -s /bin/bash $username;;
    esac

    messout "Add password" header
    confirm
    case $choice in
        y ) passwd $username
            while [ $? -ne 0 ]
            do
                messout "Please enter right password" caution
                passwd $username
            done
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
    add_string_to_file "%wheel ALL=(ALL) ALL\n%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/packer -Syu,/usr/bin/packer -Syyu,/usr/bin/systemctl restart NetworkManager,/usr/bin/rc-service NetworkManager restart,/usr/bin/pacman -Syyu --noconfirm,/usr/bin/loadkeys,/usr/bin/yay,/usr/bin/pacman -Syyuw --noconfirm,/usr/bin/xbacklight -inc 5,/usr/bin/xbacklight -dec 5" /etc/sudoers
}

function main() {
    update_timezone
    update_keyboard_layout
    get_root_password
    add_new_user
    network_config
    intel_ucode
    install_grub
    allow_user_to_run_sudo
}

main
exit 0
