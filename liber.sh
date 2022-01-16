#!/bin/bash

#export lib path variable
source /etc/environment

#-----------------------------Variables----------------------------

#Variables needed to edit template files
NAME="project"
DESCRIPTION="descriptio"
HEADER_NAME=$NAME

#PWD
BASEDIR=$(pwd)
LIB=$PATH_LIBER

#Colors:
Color_Off='\033[0m'

BBlue='\033[1;34m'
BIGreen='\033[1;92m'
BIRed='\033[1;91m'
BIWhite='\033[1;97m'
BIBlue='\033[1;94m'

UCyan='\033[4;36m'

BOLD="\033[1m"
UNBOLD="\033[0m"

On_IWhite='\033[0;107m'

#Check symbol
Check_symbol="\e[5m✔\e[25m"

#-------------------Init files to the repository-------------------

#copy repo
Copy_repo_classic() {
    cp -r /usr/share/liber/repo-template/classic/* $BASEDIR
    cp /usr/share/liber/repo-template/classic/.gitignore $BASEDIR
    mv include/project.h include/$NAME.h
    cp -r $LIB $BASEDIR
}

Copy_repo_csfml() {
    cp -r /usr/share/liber/repo-template/csfml/* $BASEDIR
    cp /usr/share/liber/repo-template/csfml/.gitignore $BASEDIR
    mv include/project.h include/$NAME.h
    cp -r $LIB $BASEDIR
}

Copy_repo_csfml_withou_lib() {
    cp -r /usr/share/liber/repo-template/csfml-without-lib/* $BASEDIR
    cp /usr/share/liber/repo-template/csfml-without-lib/.gitignore $BASEDIR
    mv include/project.h include/$NAME.h
}

Copy_repo_classic_without_lib() {
    cp -r /usr/share/liber/repo-template/without-lib/* $BASEDIR
    cp /usr/share/liber/repo-template/without-lib/.gitignore $BASEDIR
    mv include/project.h include/$NAME.h
}

#---------------------------Rewrite files--------------------------

Rewrite_files() {
    NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
    DESCRIPTION=$(echo "$DESCRIPTION" |  tr '[:upper:]' '[:lower:]' )
    HEADER_NAME=$(echo "$NAME" |  tr '[:lower:]' '[:upper:]' )

    find . -type f -exec sed -i "s/\$NAME/$NAME/g" {} \;

    find . -type f -exec sed -i "s/\$DESCRIPTION/$DESCRIPTION/g" {} \;

    find . -type f -exec sed -i "s/\$HEADER_NAME/$HEADER_NAME/g" {} \;
}

#-------------------------Init successfull-------------------------

Print_init_success() {
    echo -en "$On_IWhite$BIBlue"
    echo -en "Repository created"
    echo -en "$Color_Off"
    echo -e " $Check_symbol"
}

#---------------------------Help message---------------------------

Print_help() {
    echo -en "$BIGrenn"
    echo -e "[ Help ]$Color_Off"
    echo -en "Use flag :\n\t$BIWhite-h$Color_Off or $BIWhite--help$Color_Off "
    echo -en "for help\n\n\t$BIWhite-g$Color_Off or $BIWhite--csfml$Color_Off for csfml repo\n\n\t"
    echo -e "$BIWhite-wl$Color_Off or $BIWhite--without-lib$Color_Off for repo without your lib\n\n"
    echo -e  "\t$UCyan--------- You can combine flags if you want ---------$Color_Off"
}

#--------------------------Error message---------------------------

Print_error() {
    echo -en "$BIRed"
    echo -en "\nBad input retry with '-h' for help"
    echo -e "$Color_Off"
}


#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- Root -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

Update() {
    if [[ $EUID -ne 0 ]]; then
        echo -en "$BIRed"
        echo -e "Password needed$Color_Off"
        echo -e "The installation must be run as root."
    fi
    sudo bash /usr/share/liber/init.sh -u
}

Update_lib() {
    if [[ $EUID -ne 0 ]]; then
        echo -en "$BIRed"
        echo -e "Password needed$Color_Off"
        echo -e "The installation must be run as root."
    fi
    sudo bash /usr/share/liber/init.sh -l
}

#-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-Main-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

if [ $3 ]; then
    Print_error
elif [[ $1 ]] && [[ $2 ]]; then
    if [[ $1 == "-wl" || $1 == "--without-lib" ]] && [[ $2 == "-g" || $2 == "--csfml" ]]; then
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
        #end user input
        Copy_repo_csfml_withou_lib
        Rewrite_files
        Print_init_success
    elif [[ $1 == "-g" || $1 == "--csfml" ]] && [[ $2 == "-wl" || $2 == "--without-lib" ]]; then
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
        #end user input
        Copy_repo_csfml_withou_lib
        Rewrite_files
        Print_init_success
    else
        Print_error
    fi
elif [ $1 ]; then
    if [ $1 == "-u" ]; then
        Update
    elif [[ $1 == "-wl" || $1 == "--without-lib" ]]; then
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
        #end user input
        Copy_repo_classic_without_lib
        Rewrite_files
        Print_init_success
    elif [[ $1 == "-g" || $1 == "--csfml" ]]; then
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
        #end user input
        if [ -d $LIB ]; then
            Copy_repo_csfml
        else
            echo -e "$BIRed--------- Can't find libray, repo set without ---------$Color_Off"
            Copy_repo_csfml_withou_lib
        fi
        Rewrite_files
        Print_init_success
    elif [[ $1 == '-l' || $1 == "--lib" ]]; then
        echo -en "\n$BIBlue"
        echo -e "Current path for lib:$Color_Off$BOLD $LIB\n$UNBOLD"
        Update_lib
    elif [[ $1 == "-h" || $1 == "--help" ]]; then
        Print_help
    else
        Print_error
    fi
else
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
    #end user input
    if [ -d $LIB ]; then
        Copy_repo_classic
    else
        echo -e "$BIRed--------- Can't find libray, repo set without ---------$Color_Off"
        Copy_repo_classic_without_lib
    fi
    Rewrite_files
    Print_init_success
fi
