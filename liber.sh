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
IS_NOLIB="NO"

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
    echo -en "for help\n\n\t$BIWhite-g$Color_Off or $BIWhite--csfml$Color_Off for csfml repo\n\n\t"
    echo -e "$BIWhite-w$Color_Off or $BIWhite--without-lib$Color_Off for repo without your lib\n\n"
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
            -g|--csfml)
                RESULT=$RESULT"g"
                ;;
            -w|--without-lib)
                RESULT=$RESULT"w"
                ;;
            -l|--lib)
                RESULT=$RESULT"l"
                ;;
            -u|--update)
                RESULT=$RESULT"u"
                ;;
            --test)
                RESULT=$RESULT"t"
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
    if [[ $LIB == "NOLIB" ]] || [[ ! -d $LIB ]] ; then
        IS_NOLIB="yes"
    fi
    FLAGS=$(get_flags "$@")
fi

if [ $3 ]; then
    print_error
    exit 84
fi


FLAG_h="no"
FLAG_g="no"
FLAG_w="no"
FLAG_l="no"
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
            g)
                if [[ $FLAG_g == "no" ]]; then
                    FLAG_g="yes"
                else
                    FLAG_g=$FLAG_g"yes"
                fi
                ;;
            w)
                if [[ $FLAG_w == "no" ]]; then
                    FLAG_w="yes"
                else
                    FLAG_w=$FLAG_w"yes"
                fi
                ;;
            l)
                if [[ $FLAG_l == "no" ]]; then
                    FLAG_l="yes"
                else
                    FLAG_l=$FLAG_l"yes"
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
                exit 84
                ;;
        esac
    done
fi

if [[ $FLAG_h != "yes" ]] && [[ $FLAG_h != "no" ]] && [[ $FLAG_g != "yes" ]] && [[ $FLAG_g != "no" ]] && [[ $FLAG_w != "yes" ]] && [[ $FLAG_w != "no" ]] && [[ $FLAG_l != "yes" ]] && [[ $FLAG_l != "no" ]] && [[ $FLAG_u != "yes" ]] && [[ $FLAG_u != "no" ]] && [[ $FLAG_t != "yes" ]] && [[ $FLAG_t != "no" ]] && [[ $FLAG_n != "yes" ]] && [[ $FLAG_n != "no" ]]; then
    print_error
    exit 84
fi

if [[ $FLAG_h == "yes" ]] ; then
    print_help
    print_check_verion
    exit 0
fi

if [[ $FLAG_l == "yes" ]] ; then
    echo -en "\n$BIBlue"
    echo -e "Current path for lib:$Color_Off$BOLD $LIB\n$UNBOLD"
    update_lib
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
    bash -c "/usr/share/liber/create_file.sh -c"
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

if [[ $FLAG_w == "yes" ]] || [[ $IS_NOLIB == "yes" ]] ; then
    if [[ $IS_NOLIB == "yes" ]] ; then
        echo -e "$BIRed--------- Can't find libray, repo set without ---------$Color_Off"
    fi
    if [[ $FLAG_g == "yes" ]]; then
        copy_repo_csfml_withou_lib
    fi
    else
        copy_repo_classic_without_lib
fi

#modif files & print end
rewrite_files
print_init_success
print_check_verion
exit 1