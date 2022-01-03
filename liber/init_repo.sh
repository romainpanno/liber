#! usr/bin/bash
##
## EPITECH PROJECT, 2021
## bashfunc
## File description:
## init_repo
##

GREEN="\x1b[32;01m["
UNGREEN="]\x1b[0m"

RED="\x1b[31;01m["
UNRED="]\x1b[0m"

DIM="\e[2m"
UNDIM="\e[22m"

MAGENTA="\e[35m"
UNMAGENTA="\e[35m"

FLASHING="\e[6m"
UNFLASHING="\e0"

BOLD="\033[1m"
UNBOLD="\033[0m"

echo -e "$GREEN Copy starting $UNGREEN"
echo -e "$RED Pending $UNRED$MAGENTA$DIM"
cp -vr ~/.liber/init/* $(pwd)
cp -v ~/.liber/init/.gitignore $(pwd)
echo -e "$FLASHING$UNMAGENTA$UNDIM$BOLD$GREEN Copy finish ! $UNGREEN$UNBOLD$UNFLASHING"
