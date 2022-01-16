#!/bin/bash

#export lib path variable
source /etc/environment

#----------------------------Variables-----------------------------

#variable for lib path
PATH_LIB=""
ARE_SHURE="n"

#PWD
BASEDIR="$(pwd)"

#Colors:
Color_Off='\033[0m'
BIGreen='\033[1;92m'
BIBlue='\033[1;94m'
BIWhite='\033[1;97m'
BIRed='\033[1;91m'

#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- Init liber -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

#------------------------------ Title -------------------------------
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
    echo -e "$Color_Off"
}

#------------------------- Init library path ------------------------
Init_LibPath() {
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
        sudo grep -v -e 'PATH_LIBER=' /etc/environment > /tmp/tmp_liber
        if [ -f /tmp/tmp_liber ]; then
            sudo rm /etc/environment
            sudo mv /tmp/tmp_liber /etc/
            sudo mv /etc/tmp_liber /etc/environment
            sudo echo "PATH_LIBER=$PATH_LIB" >> /etc/environment
            sudo rm /tmp/tmp_liber
        else
            echo -en "$BIRed"
            echo -en "ERROR DURING INITIALISATION, please retry command in an other repository"
            echo -e "$Color_Off"
        fi
    fi
}

#------------------------ Replace repository ------------------------
Place_repository() {
    cd /tmp/
    git clone "https://github.com/romainpanno/liber"
    if [ -d /usr/share/liber ]; then
        sudo rm -r /usr/share/liber
    fi
    if [ -f /usr/local/bin/liber ]; then
        sudo rm -r /usr/share/liber
    fi
    sudo cp -r liber /usr/share/
    sudo mv /usr/share/liber/liber.sh /usr/local/bin/
    sudo mv /usr/local/bin/liber.sh /usr/local/bin/liber
    sudo chmod +x /usr/local/bin/liber
    sudo rm -r /tmp/liber
}

#------------------------- Print func -------------------------
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

Print_help() {
    echo -en "$BIGrenn"
    echo -en "[ Help ]"
    echo -e "$Color_Off"
    echo -e "Use flag :\n\t- '-h' or '--help' for help\n\n\t- 'u' or '--update' for update\n"
}

Print_error() {
    echo -en "$BIRed"
    echo -en "\nBad input retry with '-h' for help"
    echo -e "$Color_Off"
}

#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- Root -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
Must_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "\033[0;31mThe installation must be run as root."
        echo -e "\033[0;31mPlease enter your password:\033[0m"
        sudo "$0" "sudo sh -c \"$(curl -fsSL https://raw.githubusercontent.com/aureliancnx/Bubulle-Norminette/master/install_bubulle.sh)\""
        exit $?
    fi
}

#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- Main -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
# Must_root
Display_title
if [ $2 ]; then
    Print_error
elif [[ $1 == "-u" || $1 == "--update" ]]; then
        Init_LibPath
        Place_repository
        Print_update_success
elif [[ $1 == "-h" || $1 == "--help" ]]; then
    Print_help
elif [[ $1 ]]; then
    Print_error
else
    Init_LibPath
    Place_repository
    Print_init_success
fi
