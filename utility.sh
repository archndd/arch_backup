#!/bin/bash

# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BRED='\033[1;31m'
BORANGE='\033[1;33m'
BBLUE='\033[1;34m'
DGREEN='\033[2;32m'
IPURPLE='\033[3;35m'
IRED='\033[3;31m'
# ----------------------------------
# Print line and headline
# ----------------------------------
function messout(){
    # $1: Message
    # $2: Type of message
    case $2 in
        "header")
            echo -e "${BORANGE}${1}${NOCOLOR}";;
        "success")
            echo -e "${BBLUE}${1}${NOCOLOR}";;
        "info")
            echo -e "${CYAN}${1}${NOCOLOR}";;
        "package")
            echo -e "${GREEN}${1}${NOCOLOR}";;
        "ppa")
            echo -e "${DGREEN}${1}${NOCOLOR}";;
        "error")
            echo -e "${BRED}${1}${NOCOLOR}";;
        "question")
            echo -e "${IPURPLE}${1}${NOCOLOR}";;
        "caution")
            echo -e "${IRED}${1}${NOCOLOR}";;
        *)
            echo -e "${NOCOLOR}${1}";;
    esac
}

function add_string_to_file(){
    string="$1"
    file_name="$2"
    if less "$file_name" | sed ':a;N;$!ba;s/\n/ /g' | grep -Fq "$(sed 's/\\n/ /g' <<< "$string" | sed 's/\\t/\t/g')"; then
        return 1
    else
        echo -e "$string" | sudo tee -a $file_name
    fi
}

function confirm(){
    read -p "Are you sure (y/n): " choice
    while [ -z "$choice" ] || { [ $choice != "y" ] && [ $choice != "n" ]; }
    do
        read -p "Are you sure (y/n): " choice
    done
}
