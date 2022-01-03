##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

BASHRC = $(shell bash write_bash.sh && cp -r liber/ ~/ && echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.zshrc)

ZSHRC = $(shell bash write_zsh.sh && cp -r liber/ ~/ && echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.bashrc)

# ---------------------------------------------------------------------

bashrc:
	$(BASHRC)
	@echo "Init of repo with bashrc rule done ✔"

zshrc:
	$(ZSHRC)
	@echo "Init of repo with zshrcrule done ✔"

all : bashrc
