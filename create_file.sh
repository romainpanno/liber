#!/bin/bash

Color_Off='\033[0m'

BBlue='\033[1;34m'
BOLD="\033[1m"
UNBOLD="\033[0m"


BASEDIR=$(pwd)

PROJECTNAME="projectname"
LINE="1"
CONTENT="ok"

NAME="project"
DESCRIPTION="description"

print_error() {
    echo -en "$BIRed"
    echo -en "\nBad input retry with or bad file '-h' for help"
    echo -e "$Color_Off"
}

create_file() {
        NAME=$1
        DESCRIPTION=$2
        cp /home/romain/bashfunc/liber_project/liber/file/file.c $BASEDIR
        NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
        mv file.c $NAME.c
        if [[ -d "$BASEDIR/src" ]]; then
            mv $NAME.c src/$NAME.c
        fi
        find . -name $NAME.c -type f -exec sed -i "s/\$NAME/$NAME/g" {} \;
        find . -name $NAME.c -type f -exec sed -i "s/\$DESCRIPTION/$DESCRIPTION/g" {} \;

        #find last line for SRC
        LINE=$(grep -a -e '^SRC_TEST' -n Makefile)
        LINE=$(echo -e $LINE | cut -d ':' -f 1)
        LINE=$(($LINE-3))
        CONTENT=$(sed -e "$LINE!d" Makefile)
        CONTENT_FOR_SED=$(printf "$CONTENT" | sed -e 's/\//\\\//g')

        TAB=$'\t\t\t'

        # REPLACE FIRST LINE
        sed -i "/${CONTENT_FOR_SED}/c \\${CONTENT}\\\\" ./Makefile



        #create line to insert
        LINE_INSERT=$(printf "\\$TAB$NAME.c")
        SED_CONDITION="$LINE a $LINE_INSERT"

        #create new file
        NEW_FILE="$(sed "$SED_CONDITION" Makefile)"
        echo "$NEW_FILE" > tmp

        #replace old file
        rm Makefile.bak
        mv Makefile Makefile.bak
        mv tmp Makefile
    else
        print_error
    fi
}

if [[ -f "./Makefile" ]] && [[ -d "./src/" ]] && [[ ! -z "$(grep -e "^SRC 	:=" Makefile)" ]] && [[ ! -z "$(grep -e "^SRC_TEST" Makefile)" ]]; then
    create_file "$1" "$2"
else
    print_error
    exit 84
fi
