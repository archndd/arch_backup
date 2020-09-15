source ./utility.sh
function get_partition(){
    read -e -p "${1} partition: " pt

    read -p "Are you sure (y/n): " choice
    while [ -z "$choice" ] || { [ $choice != "y" ] && [ $choice != "n" ]; }
    do
        read -p "Are you sure (y/n): " choice
    done

    case $choice in
        n ) get_partition $1;;
        y ) 
            partprobe -d -s ${pt} >/dev/null 2>&1
            if [ $? -ne 0 ]; then
                messout "Not a valid partition" error >&2
                get_partition $1
            fi
            echo $pt
            ;;
    esac
}
main_part=$(get_partition "/")
home_part=$(get_partition "/home")
boot_part=$(get_partition "/boot")
echo $main_part $?
