c_run() {
    POSITIONAL=()
    ARGS=()
    FILENAME="./a.out";
    while [[ $# -gt 0 ]] do
        key="$1"

        case $key in
            -o)
                FILENAME="$2"
                POSITIONAL+=("$1")
                POSITIONAL+=("$2")
                shift # past argument
                shift # past value
            ;;
            --args)
                shift # past argument
                while [[ $# -gt 0 ]] do
                    ARGS+=("$1")
                    shift
                done
            ;;
            *)    
                POSITIONAL+=("$1") # save it in an array for later
                shift # past argument
            ;;
        esac
    done

    gcc ${POSITIONAL}
    [ $? -ne 1 ] && ./$FILENAME $ARGS
}

run+() {
    if [[ -z "$1" ]] then
        echo "File name needed" > /dev/stderr
    else 
        name=${1:0:${#1}-2}
        g++ -o $name $1
        [ $? -ne 1 ] && ./$name ${@:2}
    fi
}

asm_compile(){
    if [[ -z "$1" ]] then
        echo "File name needed" > /dev/stderr
    else 
        name=${1:0:${#1}-2}
        gcc -c "${name}.s" -o "${name}.o"
        gcc "${name}.o" -o "${name}"
        ./${name}
    fi
}

asm(){
    if [[ -z "$1" ]] then
        echo "File name needed" > /dev/stderr
    else 
        name=${1:0:${#1}-2}
        gcc -S -Og "${name}.c"
        bat "${name}.s"
    fi
}
