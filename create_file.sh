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
    if [[ $1 == "--cpp" ]]; then
        echo -en "Enter your file name: $BBlue"
        read NAME
        echo -en "$Color_Off"
        echo -en "Project desciption (press$BOLD ENTER$UNBOLD"
        echo -en "to use project name): $BBlue"
        read DESCRIPTION
        echo -en "$Color_Off"

        if [ -z "$DESCRIPTION" ]; then
                DESCRIPTION=$NAME
        fi

        cp /usr/share/liber/file/cpp/* $BASEDIR/src/
        if [[ ! -f $BASEDIR/file.cpp || ! -f $BASEDIR/file.hpp ]]; then
            echo -en "$BIRed"
            echo -en "\nBad input retry with or bad file '-h' for help"
            echo -e "$Color_Off"
            exit 84
        fi
        NAME=$(echo "$NAME" |  tr '[:upper:]' '[:lower:]' )
        mv file.cpp $NAME.cpp
        if [[ -d "$BASEDIR/src" ]]; then
            mv $NAME.cpp src/$NAME.cpp
            mv $NAME.hpp src/$NAME.hpp
        fi
        find . -name $NAME.cpp -type f -exec sed -i "s/\$NAME/$NAME/g" {} \;
        find . -name $NAME.cpp -type f -exec sed -i "s/\$DESCRIPTION/$DESCRIPTION/g" {} \;
        find . -name $NAME.hpp -type f -exec sed -i "s/\$NAME/$NAME/g" {} \;
        find . -name $NAME.hpp -type f -exec sed -i "s/\$DESCRIPTION/$DESCRIPTION/g" {} \;

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
        LINE_INSERT=$(printf "\\$TAB$NAME.cpp")
        SED_CONDITION="$LINE a $LINE_INSERT"

        #create new file
        NEW_FILE="$(sed "$SED_CONDITION" Makefile)"
        echo "$NEW_FILE" > tmp

        #replace old file
        if [[ -f .Makefile.bak ]]; then
            rm .Makefile.bak
        fi
        mv Makefile .Makefile.bak
        mv tmp Makefile
    elif [[ $1 == "-c" ]]; then
        echo -en "Enter your file name: $BBlue"
        read NAME
        echo -en "$Color_Off"
        echo -en "Project desciption (press$BOLD ENTER$UNBOLD"
        echo -en "to use project name): $BBlue"
        read DESCRIPTION
        echo -en "$Color_Off"

        if [ -z "$DESCRIPTION" ]; then
                DESCRIPTION=$NAME
        fi

        cp /usr/share/liber/file/file.c $BASEDIR
        if [[ ! -f $BASEDIR/file.c ]]; then
            echo -en "$BIRed"
            echo -en "\nBad input retry with or bad file '-h' for help"
            echo -e "$Color_Off"
            exit 84
        fi
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
        if [[ -f .Makefile.bak ]]; then
            rm .Makefile.bak
        fi
        mv Makefile .Makefile.bak
        mv tmp Makefile
    else
        print_error
    fi
}
if [[ -f "./Makefile" ]] && [[ -d "./src/" ]] && [[ ! -z "$(grep -e "^SRC	:=" Makefile)" ]]; then
    echo "je passs"
    create_file "$1"
else
    print_error
    exit 84
fi
