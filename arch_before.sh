#!/bin/bash

source ./utility.sh

function check_internet() {
    messout "Checking Internet" header
    ping -c 1 archlinux.org
    [[ $? != 0 ]] || messout "No internet" error; messout "Aborting" error; exit 1
}

function check_sys_time() {
    timedatectl set-ntp true
}

# Get install partition for / /home/ boot swap
function get_part_name(){
    read -e -p "${1} partition: " pt

    confirm

    case $choice in
        n ) get_part_name $1;;
        y ) 
            partprobe -d -s ${pt} >/dev/null 2>&1
            if [ $? -ne 0 ]; then
                messout "Not a valid partition" error >&2
                get_part_name $1
            fi
            echo $pt
            ;;
    esac
}

function get_and_mount_part(){
    fdisk -l
    main_part=$(get_part_name "/root")
    home_part=$(get_part_name "/home")
    boot_part=$(get_part_name "/boot")
    swap_part=$(get_part_name "Swap")

    # Ensure format
    messout "Do you want to format /root" question
    confirm
    if [ $choice == "yes" ]; then
        mkfs.ext4 $main_part
    fi

    # Mount all partitions
    mount $main_part /mnt
    mkdir -pv /mnt/home /mnt/boot
    mount $home_part /mnt/home
    mount $boot_part /mnt/home
    mkswap $swap_part
    swapon $swap_part
}

function update_mirror_list() {
    grep -A 1 "Vietnam" /etc/pacman.d/mirrorlist | grep -v '\-\-' > /etc/pacman.d/mirror.temp
    cat /etc/pacman.d/mirrorlist >> /etc/pacman.d/mirror.temp
    mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    mv /etc/pacman.d/mirror.temp /etc/pacman.d/mirrorlist
}

function install_arch(){
    messout "Installing arch" header
    pacstrap /mnt base base-devel linux-lts linux-firmware
    cp /etc/pacman.d/mirrorlist /mnt/etc/pacman.d
}

function gen_fstab(){
    messout "Creating fstab" header
    genfstab -U /mnt >> /mnt/etc/fstab
}

function main() {
    check_internet
    check_sys_time
    get_and_mount_part
    update_mirror_list
    install_arch
    gen_fstab
}

main
