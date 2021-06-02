java_new_project(){
    PROJECTNAME="$1"
    PACKAGE=""
    OTHER=()
    while [[ $# -gt 0 ]] do
        key="$1"
        case $key in
            -n|--name)
                PROJECTNAME="$2"
                shift # past argument
                shift # past value
            ;;
            -p|--package)
                PACKAGE="$2"
                shift # past argument
                shift
            ;;
            *)    
                OTHER+=("$1") # save it in an array for later
                shift # past argument
            ;;
        esac
    done
    mkdir -p $PROJECTNAME/src
    mkdir -p $PROJECTNAME/build/classes
    IFS=, read -rA PACK <<< ${PACKAGE}
    cd $PROJECTNAME
    java_new_package ${PACK[@]}
}

java_new_package(){
    while [[ $# -gt 0 ]] do
        mkdir -p src/$1
        shift
    done
}

java_new_class(){
    FOLDERNAME=${PWD##*/}
    FILENAME=$(basename "${1}")
    PACKAGEPATH=$(dirname "${1}")
    JAVAPACK=${PACKAGEPATH//\//.}

    if [[ ! -d src/$PACKAGEPATH ]]; then
        echo "Package not existed"
        choice=""
        vared -p "Create new one (y/n): " choice
        if [[ -z $choice ]] || [[ $choice == "n" ]]; then
            return 0
        fi
    fi
    mkdir -p src/$PACKAGEPATH
    if [[ -f src/$PACKAGEPATH/$FILENAME.java ]]; then
        echo "Java file existed"
        return 1
    fi
    echo "package ${JAVAPACK};\n\npublic class ${FILENAME}{\n\t\n}" > src/$PACKAGEPATH/$FILENAME.java
    nv -c "4" src/$PACKAGEPATH/$FILENAME.java
}

java_com() {
    SOURCEPATH="src"
    BUILDCLASS="./build/classes"
    OTHER=()
    while [[ $# -gt 0 ]] do
        key="$1"

        case $key in
            --source-path)
                SOURCEPATH="$2"
                shift # past argument
                shift # past value
            ;;
            -d)
                BUILDCLASS="$2"
                shift
                shift
            ;;
            *)    
                OTHER+=("$1") # save it in an array for later
                shift # past argument
            ;;
        esac
    done

    javac --source-path $SOURCEPATH -d $BUILDCLASS $OTHER
}

java_compile_all(){
    for f in $(find . -type f -name "*.java" -print); do
        java_com $f
    done
}
java_run(){
    java -cp build/classes $1
}
