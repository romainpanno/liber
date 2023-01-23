#!/bin/bash

VERSION=$(grep -e 'VERSION=' /usr/share/liber/init.sh | cut -d= -f2 | head -qn1)

#export lib path variable
source /etc/environment

#-----------------------------Variables----------------------------

#check version
GitVersion=$(curl -fsSL https://raw.githubusercontent.com/romainpanno/liber/master/init.sh | grep -e 'VERSION=' | cut -d= -f2 | head -qn1)

#Variables needed to edit template files
NAME="project"
DESCRIPTION="description"
HEADER_NAME=$NAME

#PWD
BASEDIR=$(pwd)

#Colors:
Color_Off='\033[0m'

Yellow='\033[0;33m'

BBlue='\033[1;34m'
BIGreen='\033[1;92m'
BIRed='\033[1;91m'
BIWhite='\033[1;97m'
BIBlue='\033[1;94m'

UCyan='\033[4;36m'

BOLD="\033[1m"
UNBOLD="\033[0m"

On_IWhite='\033[0;107m'
On_IBlack='\033[0;100m'

On_Black='\033[40m'

#Check symbol
Check_symbol="\033[5m✔\033[0m"

#------------------- Init files to the repository -------------------

#copy repo
copy_repo_classic() {
    NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
    cp -r /usr/share/liber/repo-template-cpp/classic/* $BASEDIR
    cp /usr/share/liber/repo-template-cpp/classic/.gitignore $BASEDIR
    mv project.hpp $NAME.hpp
    mv file.cpp $NAME.cpp
}

copy_repo_complete() {
    NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
    cp -r /usr/share/liber/repo-template-cpp/classic-shit/* $BASEDIR
    cp /usr/share/liber/repo-template-cpp/classic-shit/.gitignore $BASEDIR
    mv ./src/project.hpp ./src/$NAME.hpp
    mv ./src/file.cpp ./src/$NAME.cpp
}

#--------------------------- Rewrite files --------------------------

rewrite_files() {
    NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
    DESCRIPTION=$(echo "$DESCRIPTION" |  tr '[:upper:]' '[:lower:]' )
    HEADER_NAME=$(echo "$NAME" |  tr '[:lower:]' '[:upper:]' )

    find . -type f -exec sed -i "s/\$NAME/$NAME/g" {} \;

    find . -type f -exec sed -i "s/\$DESCRIPTION/$DESCRIPTION/g" {} \;

    find . -type f -exec sed -i "s/\$HEADER_NAME/$HEADER_NAME/g" {} \;
}

#------------------------- Init successfull -------------------------

print_init_success() {
    echo -en "\n----------------"
    echo -e "$On_IWhite$BIBlue Repository created $Color_Off----------------"
    echo -e "\t\t________  $BIGreen$Check_symbol  _______"
}

#--------------------------- Check Version ---------------------------

print_check_verion() {
    echo -e "\n-----------------$Yellow Checking version$Color_Off -----------------\n"
    if [[ $VERSION != $GitVersion ]]; then
        echo -e "New update available : $BIGreen$GitVersion$Color_Off"
    else
        echo -e "\t\tLiber is up to date $BIGreen!$Color_Off\n"
    fi
}

#--------------------------- Help message ---------------------------

print_help() {
    echo -en "$BIGrenn"
    echo -e "[ Help ]$Color_Off"
    echo -en "Use flag :\n\t$BIWhite-h$Color_Off or $BIWhite--help$Color_Off "
    echo -e "\t$BIWhite-n$Color_Off to create a new file and add it to the Makefile\n\n"
    echo -e  "\t$UCyan--------- You can combine flags if you want ---------$Color_Off"
}

#-------------------------- Error message ---------------------------

print_error() {
    echo -en "$BIRed"
    echo -en "\nBad input retry with '-h' for help"
    echo -e "$Color_Off"
}


#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- Root -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

update() {
    if [[ $EUID -ne 0 ]]; then
        echo -en "$BIRed"
        echo -e "Password needed$Color_Off"
        echo -e "The installation must be run as root."
    fi
    sudo bash /usr/share/liber/init.sh -u
}

update_lib() {
    if [[ $EUID -ne 0 ]]; then
        echo -en "$BIRed"
        echo -e "Password needed$Color_Off"
        echo -e "The installation must be run as root."
    fi
    sudo bash /usr/share/liber/init.sh -l
}

#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-Main-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

echo -e "\t\033[1;91mL\t\033[1;92mI\t\033[1;93mB\t\033[1;94mE\t\033[1;95mR$Color_Off\n"

FLAGS=""

get_flags() {
    RESULT=""
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                RESULT=$RESULT"h"
                ;;
            -B|--complet)
                RESULT=$RESULT"B"
                ;;
            -u|--update)
                RESULT=$RESULT"u"
                ;;
            --test)
                RESULT=$RESULT"t"
                ;;
            -n)
                RESULT=$RESULT"n"
                ;;
            *)
                print_error
                exit 84
                ;;
        esac
        shift
    done
    echo $RESULT
}

if [ $1 ];then
    FLAGS=$(get_flags "$@")
fi

if [ $2 ]; then
    print_error
    exit 84
fi


FLAG_h="no"
FLAG_B="no"
FLAG_u="no"
FLAG_t="no"
FLAG_n="no"

if [[ $1 ]]; then
    for L in $(seq 1 ${#FLAGS}); do
        TMP=$(echo $FLAGS | cut -c$L)
        case $TMP in
            h)
                if [[ $FLAG_h == "no" ]]; then
                    FLAG_h="yes"
                else
                    FLAG_h=$FLAG_h"yes"
                fi
                ;;
            B)
                if [[ $FLAG_B == "no" ]]; then
                    FLAG_B="yes"
                else
                    FLAG_h=$FLAG_h"yes"
                fi
                ;;
            u)
                if [[ $FLAG_u == "no" ]]; then
                    FLAG_u="yes"
                else
                    FLAG_u=$FLAG_u"yes"
                fi
                ;;
            t)
                if [[ $FLAG_t == "no" ]]; then
                    FLAG_t="yes"
                else
                    FLAG_t=$FLAG_t"yes"
                fi
                ;;
            n)
                if [[ $FLAG_n == "no" ]]; then
                    FLAG_n="yes"
                else
                    FLAG_n=$FLAG_n"yes"
                fi
                ;;
            *)
                print_error
                exit 84
                ;;
        esac
    done
fi

if [[ $FLAG_h == "yes" ]] ; then
    print_help
    print_check_verion
    exit 0
fi

if [[ $FLAG_t == "yes" ]]; then
    sudo docker run -it --rm --name epitest -v $HOME:/tmp epitechcontent/epitest-docker:latest /bin/bash -c "cd /tmp && /bin/bash"
    exit 0
fi

if [[ $FLAG_u == "yes" ]]; then
    update
    exit 0
fi

if [[ $FLAG_n == "yes" ]]; then
    /usr/share/liber/create_file.sh -c
    exit 0
fi

#user input
echo -en "Enter your project name: $BBlue"
read NAME
echo -en "$Color_Off"
echo -en "Project desciption (press$BOLD ENTER$UNBOLD"
echo -en "to use project name): $BBlue"
read DESCRIPTION
echo -en "$Color_Off"

if [ -z "$DESCRIPTION" ]; then
        DESCRIPTION=$NAME
fi

if [[ $FLAG_B == "yes" ]]; then
    copy_repo_complete
else
    copy_repo_classic
fi

#modif files & print end
rewrite_files
print_init_success
print_check_verion
exit 1