#!/bin/bash

VERSION=$(grep -e 'VERSION=' /usr/share/liber/init.sh | cut -d= -f2 | head -qn1)

#export lib path variable
source /etc/environment

#-----------------------------Variables----------------------------

#check version
GitVersion=$(curl -fsSL https://raw.githubusercontent.com/romainpanno/liber/master/init.sh | grep -e 'VERSION=' | cut -d= -f2 | head -qn1)

#Variables needed to edit template files
NAME="project"
DESCRIPTION="descriptio"
HEADER_NAME=$NAME

#PWD
BASEDIR=$(pwd)
LIB=$PATH_LIBER

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
Check_symbol="\e[5m✔\e[25m"

#------------------- Init files to the repository -------------------

#copy repo
copy_repo_classic() {
    NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
    cp -r /usr/share/liber/repo-template/classic/* $BASEDIR
    cp /usr/share/liber/repo-template/classic/.gitignore $BASEDIR
    mv include/project.h include/$NAME.h
    cp -r $LIB $BASEDIR
}

copy_repo_csfml() {
    NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
    cp -r /usr/share/liber/repo-template/csfml/* $BASEDIR
    cp /usr/share/liber/repo-template/csfml/.gitignore $BASEDIR
    mv include/project.h include/$NAME.h
    cp -r $LIB $BASEDIR
}

copy_repo_csfml_withou_lib() {
    NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
    cp -r /usr/share/liber/repo-template/csfml-without-lib/* $BASEDIR
    cp /usr/share/liber/repo-template/csfml-without-lib/.gitignore $BASEDIR
    mv include/project.h include/$NAME.h
}

copy_repo_classic_without_lib() {
    NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
    cp -r /usr/share/liber/repo-template/without-lib/* $BASEDIR
    cp /usr/share/liber/repo-template/without-lib/.gitignore $BASEDIR
    mv include/project.h include/$NAME.h
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
    echo -e "$On_IWhite$BIBlue"
    echo -en "Repository created"
    echo -en "$On_IBlack$Color_Off $Check_symbol"
    echo -e "$Color_Off"
}

#--------------------------- Check Version ---------------------------

print_check_verion() {
    echo -e "\n-----------------$Yellow Checking version$Color_Off -----------------"
    if [[ $VERSION != $GitVersion ]]; then
        echo -e "New update available : $BIGreen$GitVersion$Color_Off"
    else
        echo -e "Liber is up to date $BIGreen!$Color_Off\n"
    fi
}

#--------------------------- Help message ---------------------------

print_help() {
    echo -en "$BIGrenn"
    echo -e "[ Help ]$Color_Off"
    echo -en "Use flag :\n\t$BIWhite-h$Color_Off or $BIWhite--help$Color_Off "
    echo -en "for help\n\n\t$BIWhite-g$Color_Off or $BIWhite--csfml$Color_Off for csfml repo\n\n\t"
    echo -e "$BIWhite-wl$Color_Off or $BIWhite--without-lib$Color_Off for repo without your lib\n\n"
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

if [ $3 ]; then
    print_error
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
        copy_repo_csfml_withou_lib
        rewrite_files
        print_init_success
        print_check_verion
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
        copy_repo_csfml_withou_lib
        rewrite_files
        print_init_success
        print_check_verion
    else
        print_error
    fi
elif [ $1 ]; then
    if [ $1 == "-u" ]; then
        update
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
        copy_repo_classic_without_lib
        rewrite_files
        print_init_success
        print_check_verion
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
            copy_repo_csfml
        else
            echo -e "$BIRed--------- Can't find libray, repo set without ---------$Color_Off"
            copy_repo_csfml_withou_lib
        fi
        rewrite_files
        print_init_success
        print_check_verion
    elif [[ $1 == '-l' || $1 == "--lib" ]]; then
        echo -en "\n$BIBlue"
        echo -e "Current path for lib:$Color_Off$BOLD $LIB\n$UNBOLD"
        update_lib
    elif [[ $1 == "-h" || $1 == "--help" ]]; then
        print_help
        print_check_verion
    else
        print_error
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
        copy_repo_classic
    else
        echo -e "$BIRed--------- Can't find libray, repo set without ---------$Color_Off"
        copy_repo_classic_without_lib
    fi
    rewrite_files
    print_init_success
    print_check_verion
fi
