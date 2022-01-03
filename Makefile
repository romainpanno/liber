##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

BASHRC = $(shell bash write_bash.sh && cp -r liber/ ~/)

ZSHRC = $(shell bash write_zsh.sh && cp -r liber/ ~/)

# ---------------------------------------------------------------------

bashrc:
	$(BASHRC)
	@echo "Init of repo done ✔"

zshrc:
	$(ZSHRC)
	@echo "Init of repo done ✔"

all : bashrc
