#!/bin/bash
##
## EPITECH PROJECT, 2021
## bashfunc
## File description:
## init_repo
##

GREEN="\x1b[32;01m["
UNGREEN="]\x1b[0m"

FLASHING="\e[6m"
UNFLASHING="\e0"

if [ -f ~/.zshrc ]; then
    echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.zshrc
else
    echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.bashrc
fi

cp -r liber/ ~/
