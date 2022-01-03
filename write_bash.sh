#!/bin/bash
##
## EPITECH PROJECT, 2021
## bashfunc
## File description:
## init_repo
##

if [ -f ~/.zshrc ]; then
    echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.zshrc
else
    echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.bashrc
fi

cp -r liber/ ~/
