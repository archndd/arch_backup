#!/bin/bash

source ./utility.sh

function check_internet() {
    messout "Checking Internet" header
    ping -c 2 archlinux.org
    [[ $? != 0 ]] && messout "No internet" error && messout "Aborting" error && exit 1
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
            if [[ $? != 0 ]]; then
                messout "Not a valid partition" error >&2
                get_part_name $1
            fi
            echo $pt
            ;;
    esac
}

function check_mount(){
    # Get / partition and mount only not mounted or umount
    if [[ $(grep -qs "/dev/.* /mnt ext4" /proc/mounts) ]]; then
        messout "Some partition is mounted in /mnt" warning
        confirm_messsage "Unmount"
        if [[ $choice == "y" ]]; then
            umount -R /mnt
            [[ $? != 0 ]] && messout "Umount unsuccessfully. Aborting" error && exit 1

            main_part=$(get_part_name "/root")
            confirm_messsage "Do you want to format /root" 
            if [[ $choice == "y" ]]; then
                mkfs.ext4 $main_part
            fi
        fi
    else
        main_part=$(get_part_name "/root")
        confirm_messsage "Do you want to format /root" 
        if [[ $choice == "y" ]]; then
            mkfs.ext4 $main_part
        fi
    fi 

    mkdir -pv /mnt/home /mnt/boot
    # If /home or /boot not monut then get partition and mount
    [[ $(grep -qs "/dev/.* /mnt/home ext4" /proc/mounts) ]] || home_part=$(get_part_name "/home") && mount $home_part /mnt/home
    [[ $(grep -qs "/dev/.* /mnt/boot ext4" /proc/mounts) ]] || boot_part=$(get_part_name "/boot") && mount $boot_part /mnt/boot
    # Get swap partition if not on
    [[ $(swapon -s | grep -qs "/dev/.* ") ]] || swap_part=$(get_part_name "Swap") && mkswap $swap_part && swapon $swap_part 
}

function install_arch(){
    messout "Installing arch" header
    pacstrap /mnt base base-devel linux-lts linux-firmware
    [[ $? != 0 ]] && messout "Pacstrap failed. Aborting" error && exit 1
}

function gen_fstab(){
    messout "Creating fstab" header
    genfstab -U /mnt >> /mnt/etc/fstab
}

function main() {
    check_internet
    check_sys_time
    check_mount
    install_arch
    gen_fstab
}

main
