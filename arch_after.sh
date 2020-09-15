#!/bin/bash

source ./utility.sh

function install_everything(){
    count=$(cat pacmanlist | sed '/^\s*#/d;/^\s*$/d' | wc -l)
    n=0
    messout "Install needed applications" header

    while IFS=, read -r program aur comment
    do
        n=$((n+1))
        if [ ! -z $aur ]
        then
            messout "${n}/${count}. ${program} (Install from AUR)" package
            yay  --noconfirm --color always -q --noprogressbar --logfile paclog -S $program
        else
            messout "${n}/${count}. ${program}" package
            sudo pacman --noconfirm --color always -q --noprogressbar --logfile paclog --needed -S $program
        fi
    done < <(grep -v -e '^$' ./pacmanlist)

    messout "Finish installing app" success
}


function make_pacman_look_good() {
    # Make pacman and yay colorful and adds eye candy on the progress bar because why not.
    grep "^Color" /etc/pacman.conf >/dev/null || sed -i "s/^#Color$/Color/" /etc/pacman.conf
    grep "ILoveCandy" /etc/pacman.conf >/dev/null || sed -i "/#VerbosePkgLists/a ILoveCandy" /etc/pacman.conf
}

# For 32bit things
function add_multilib() {
    # Uncomment multilib in pacman.conf
    grep "^\[multilib\]" /etc/pacman.conf >/dev/null || sed -i "s/^#\[multilib\]$/\[multilib\]/" /etc/pacman.conf
    grep "^Include = \/etc\/pacman.d\/mirrorlist" /etc/pacman.conf >/dev/null || sed -i "s/^#Include = \/etc\/pacman.d\/mirrorlist$/Include = \/etc\/pacman.d\/mirrorlist/" /etc/pacman.conf

    sudo pacman -Sy
}

function install_yay() {
    sudo pacman --noconfirm --needed -S git
    git clone https://aur.archlinux.org/yay-git.git
    cd yay-git
    makepkg -si --noconfirm
    cd ..
    sudo rm yay-git* -R
}

function main() {
    make_pacman_look_good
    add_multilib
    install_yay
    install_everything 
    sudo systemctl enable lightdm
}

main
