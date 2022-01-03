#! usr/bin/bash
##
## EPITECH PROJECT, 2021
## bashfunc
## File description:
## init_repo
##

echo 'cp liber/ ~/'

if [ -f ~/.zshrc]; then
    echo 'alias liber="bash ~/liber/liber/init_repo.sh"' >> ~/.zshrc
else
    echo 'alias liber="bash ~/liber/liber/init_repo.sh"' >> ~/.bashrc
fi