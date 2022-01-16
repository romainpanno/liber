#!/bin/bash

VERSION=V1.2

#export lib path variable
source /etc/environment

#----------------------------Variables-----------------------------

#check version
GitVersion=$(curl -fsSL https://raw.githubusercontent.com/romainpanno/liber/master/init.sh | grep -e 'VERSION=' | cut -d= -f2 | head -qn1)

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
▄ ██╗▄    ██║         ██║    ██╔══██╗    ██╔════╝    ██╔══██╗    ▄ ██╗▄
 ████╗    ██║         ██║    ██████╔╝    █████╗      ██████╔╝     ████╗
▀╚██╔▀    ██║         ██║    ██╔══██╗    ██╔══╝      ██╔══██╗    ▀╚██╔▀
  ╚═╝     ███████╗    ██║    ██████╔╝    ███████╗    ██║  ██║      ╚═╝
          ╚══════╝    ╚═╝    ╚═════╝     ╚══════╝    ╚═╝  ╚═╝
                                                        By Romain Panno
$BIGreen$VERSION"
    echo -e "$Color_Off"
}

#------------------------- Init library path ------------------------
Init_LibPath() {
    echo -en "$BIBlue"
    echo -en "Enter your library path: "
    echo -en "$Color_Off$BIWhite"
    read PATH_LIB
    echo -en "$Color_Off"
    if [ -d "$PATH_LIB" ]; then
        echo -en "$BIBlue"
        echo -en "are you shure ? y/n: "
        echo -en "$Color_Off$BIWhite"
        read ARE_SHURE
        echo -en "$Color_Off"
    fi

    while [[ ! -d "$PATH_LIB" ]] || [[ -z "$PATH_LIB" ]] || [[ $ARE_SHURE == "n" ]]
    do
        if [[ -z "$PATH_LIB" || ! -d "$PATH_LIB" ]]; then
            echo -en "$BIRed"
            echo -en "Wrong path retry: "
            echo -en "$Color_Off"
            read PATH_LIB
        else
            echo -en "$BIBlue"
            echo -en "Enter your library path: "
            echo -en "$Color_Off$BIWhite"
            read PATH_LIB
            echo -en "$Color_Off"
        fi
        if [ -d "$PATH_LIB" ]; then
            echo -en "$BIBlue"
            echo -en "are you shure ? y/n: "
            echo -en "$Color_Off$BIWhite"
            read ARE_SHURE
            echo -en "$Color_Off"
        fi
    done

    GREP_PATH=$(grep -e 'PATH_LIBER=' /etc/environment)

    if [ -z $GREP_PATH ]; then
        sudo echo "PATH_LIBER=$PATH_LIB" >> /etc/environment
    else
        if [ -f /tmp/tmp_liber ]; then
            sudo rm /tmp/tmp_liber
        fi
        sudo grep -v -e 'PATH_LIBER=' /etc/environment > /tmp/tmp_liber
        if [ -f /tmp/tmp_liber ]; then
            sudo rm /etc/environment
            sudo mv /tmp/tmp_liber /etc/
            sudo mv /etc/tmp_liber /etc/environment
            sudo echo "PATH_LIBER=$PATH_LIB" >> /etc/environment
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
        sudo rm -r /usr/local/bin/liber
    fi
    sudo cp -r liber/ /usr/share/
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
    echo -e "[ Help ]"
    echo -e "$Color_Off"
    echo -e "Use flag :\n\t- '-h' or '--help' for help\n\n\t- 'u' or '--update' for update\n\n\t- 'l' or '--lib' for change your lib pth"
    GREP_PATH=$(grep -e 'PATH_LIBER=' /etc/environment)
    if [ $GREP_PATH ]; then
        echo -en "\nYou have already set your library path: "
        echo -en "$BIWhite"
        echo -e "$GREP_PATH$Color_Off"
        echo -e "If you want to change it use '-l' or '--lib' flag\n"
    fi
    echo -en "$BIBlue"
    echo -e "eZ by romain$Color_Off"
}

Print_error() {
    echo -en "$BIRed"
    echo -en "\nBad input retry with '-h' for help"
    echo -e "$Color_Off"
}

Print_check_verion() {
    if [[ $VERSION != $GitVersion ]]; then
        echo -e "New update available : $BIGreen$GitVersion$Color_off"
    else
        echo -e "Liber is up to date !"
    fi
}

#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- Main -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

if [[ $EUID -ne 0 ]]; then
    echo -en "$BIRed"
    echo -e "Password needed$Color_Off"
    echo -e "The installation must be run as root."
    sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/romainpanno/liber/master/init.sh)"
    exit $?
elif [ $2 ]; then
    Display_title
    Print_error
elif [[ $1 == "-u" || $1 == "--update" ]]; then
        Display_title
        Place_repository
        Print_update_success
elif [[ $1 == "-l" || $1 == "--lib" ]]; then
        Display_title
        Init_LibPath
elif [[ $1 == "-h" || $1 == "--help" ]]; then
    Display_title
    Print_help
    Print_check_verion
elif [[ $1 ]]; then
    Display_title
    Print_error
else
    Display_title
    Init_LibPath
    Place_repository
    Print_init_success
    Print_check_verion
fi
