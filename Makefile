##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

TARGET = ~/.liber/

PULL = $(shell git pull)

SH_INIT_REPO := $(TARGET)init_repo.sh

THIS_SHELL := $(notdir $(shell env | grep SHELL | cut -d= -f2))

# ---------------------------------------------------------------------

ifndef CURR_SHELL
ifeq ($(THIS_SHELL), zsh)
	CURR_SHELL := zshrc
else ifeq ($(THIS_SHELL), bashrc)
	CURR_SHELL := bashrc
else
	CURR_SHELL := bashrc
endif
endif

# ---------------------------------------------------------------------

all : update copy_src
	@grep -e 'alias liber="bash $(SH_INIT_REPO)"' -q ~/.$(CURR_SHELL) || \
		$(MAKE) $(CURR_SHELL) CURR_SHELL=$(CURR_SHELL) -s

bashrc:
	@echo 'alias liber="bash $(SH_INIT_REPO)"' >> ~/.$(CURR_SHELL)
	@$(MAKE) print_shell_init CURR_SHELL=$(CURR_SHELL) -s

zshrc:
	@echo 'alias liber="bash $(SH_INIT_REPO)"' >> ~/.$(CURR_SHELL)
	@$(MAKE) print_shell_init CURR_SHELL=$(CURR_SHELL) -s

print_shell_init:
	@printf "\033[1;91m[ \033[0m\033[1;37mInit of repo with $(CURR_SHELL) rule done \033[1;95m✔\033[0m\033[1;37m\033[1;91m ]\033[0m\n"

copy_src:
	@cp -r liber/ $(TARGET)

update:
	# $(PULL)
	@printf "\033[1;91m----------Updated Successfully----------\033[0m\n"
