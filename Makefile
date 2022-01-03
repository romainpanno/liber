##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

TARGET = ~/.liber/

PULL = $(shell git pull)

CURR_SHELL := bashrc

SH_INIT_REPO := $(TARGET)init_repo.sh

# ---------------------------------------------------------------------

all : update bashrc

bashrc: CURR_SHELL = bashrc
bashrc: copy_src
	@echo 'alias liber="bash $(SH_INIT_REPO)"' >> ~/.$(CURR_SHELL)
	@$(MAKE) print_shell_init CURR_SHELL=$(CURR_SHELL) -s

zshrc: CURR_SHELL = zshrc
zshrc: copy_src
	@shell echo 'alias liber="bash $(SH_INIT_REPO)"' >> ~/.$(CURR_SHELL)
	@$(MAKE) print_shell_init CURR_SHELL=$(CURR_SHELL) -s

print_shell_init:
	@printf "\033[1;91m[ \033[0m\033[1;37mInit of repo with $(CURR_SHELL) rule done \033[1;95m✔\033[0m\033[1;37m\033[1;91m ]\033[0m\n"

copy_src:
	@cp -r liber/ $(TARGET)

update:
	# $(PULL)
	@printf "\033[1;91m----------Updated Successfully----------\033[0m\n"
