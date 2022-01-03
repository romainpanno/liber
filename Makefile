##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

CP = $(shell cp -r liber/ ~/)

BASHRC = $(shell echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.bashrc)

ZSHRC = $(shell echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.zshrc)

# ---------------------------------------------------------------------

bashrc:
	$(BASHRC)
	$(CP)
	@echo "Init of repo with bashrc rule done ✔"

zshrc:
	$(ZSHRC)
	$(CP)
	@echo "Init of repo with zshrcrule done ✔"

all : bashrc
