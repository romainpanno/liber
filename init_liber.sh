#!/bin/bash

#----------------------------Variables-----------------------------

#variable for lib path
PATH_LIB=""
ARE_SHURE="n"

#PWD
BASEDIR="$(pwd)/liber"

#Colors:
Color_Off='\033[0m'
BIGreen='\033[1;92m'
BIBlue='\033[1;94m'
BIWhite='\033[1;97m'
BIRed='\033[1;91m'

#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-Init liber-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

#------------------------------Title-------------------------------
Display_title() {
    echo -en "$BIBlue"
    echo -e "
                ██╗         ██╗    ██████╗     ███████╗    ██████╗
▄ ██╗▄▄ ██╗▄    ██║         ██║    ██╔══██╗    ██╔════╝    ██╔══██╗    ▄ ██╗▄▄ ██╗▄
 ████╗ ████╗    ██║         ██║    ██████╔╝    █████╗      ██████╔╝     ████╗ ████╗
▀╚██╔▀▀╚██╔▀    ██║         ██║    ██╔══██╗    ██╔══╝      ██╔══██╗    ▀╚██╔▀▀╚██╔▀
  ╚═╝   ╚═╝     ███████╗    ██║    ██████╔╝    ███████╗    ██║  ██║      ╚═╝   ╚═╝
                ╚══════╝    ╚═╝    ╚═════╝     ╚══════╝    ╚═╝  ╚═╝
                                                                    By Romain Panno"
    echo "$Color_Off"
}

#-------------------------Init library path------------------------
Init_LibPath() {
    echo -en "Enter your library path: "
    echo -en "$BIWhite"
    read PATH_LIB
    echo -en "$Color_Off"
    if [ -n "$PATH_LIB" ]; then
        echo -en "$BIBlue"
        echo -en "are you shure ? y/n: "
        echo -en "$Color_Off$BIWhite"
        read ARE_SHURE
        echo -en "$Color_Off"
    fi

    while [[ -z "$PATH_LIB" ]] || [[ $ARE_SHURE == "n" ]]
    do
        if [ -z "$PATH_LIB" ]; then
            echo -en "BAD input, retry: "
            read PATH_LIB
            echo -en "$BIBlue"
            echo -en "are you shure ? y/n: "
            echo -en "$Color_Off$BIWhite"
            read ARE_SHURE
            echo -en "$Color_Off"
        else
            echo -en "$BIBlue"
            echo -en "Enter your library path: "
            echo -en "$Color_Off$BIWhite"
            read PATH_LIB
            echo -en "$Color_Off"
            if [ -n "$PATH_LIB" ]; then
                echo -en "$BIBlue"
                echo -en "are you shure ? y/n: "
                echo -en "$Color_Off$BIWhite"
                read ARE_SHURE
                echo -en "$Color_Off"
            fi
        fi
    done

    GREP_PATH=$(grep -e 'PATH_LIBER=' /etc/environment)

    if [ -z $GREP_PATH ]; then
        sudo echo "PATH_LIBER=$PATH_LIB" >> /etc/environment
    else
        if [ -f tmp_liber ]; then
            rm tmp_liber
        fi
        grep -v -e 'PATH_LIBER=' /etc/environment > tmp_liber
        if [ -f tmp_liber ]; then
            sudo rm /etc/environment
            sudo mv tmp_liber /etc/
            sudo mv /etc/tmp_liber /etc/environment
            sudo echo "PATH_LIBER=$PATH_LIB" >> /etc/environment
        else
            echo -en "$BIRed"
            echo -en "ERROR DURING INITIALISATION, please retry command in an other repository"
            echo -e "$Color_Off"
        fi
    fi
}
#------------------------Replace repository------------------------
Place_repository() {
    source /etc/environment
    if [ -d /usr/share/liber ]; then
        sudo rm -r /usr/share/liber
    fi
    sudo cp -r $BASEDIR /usr/share/
    source /etc/environment
}

#-------------------------Init successfull-------------------------
Print_init_success() {
    echo -en "$BIGreen"
    echo -en "Initialised successfully"
    echo -e "$Color_Off"
}

Print_update_success() {
    echo -en "$BIGreen"
    echo -en "Updated successfully"
    echo -e "$Color_Off"
}

#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- Root -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
Must_root() {
    if [[ $EUID -ne 0 ]]; then
    echo "\033[0;31mThe installation must be run as root."
    echo "\033[0;31mPlease enter your password:\033[0m"
    sudo "$0" "sudo sh -c \"$(curl -fsSL https://raw.githubusercontent.com/aureliancnx/Bubulle-Norminette/master/install_bubulle.sh)\""
    exit $?
    fi
}

#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-Main-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
main() {
    Display_title
    Init_LibPath
    Place_repository
    if [ $3 ]; then
        Print_error
    else if [ $1 ] && [[ $1 -eq "-u" ]] || [ $1 ] && [[ $1 -eq "--update" ]]; then
        Print_update_success
    else
        Print_init_success
    fi
}

main