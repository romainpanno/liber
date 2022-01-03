##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

CP = $(shell cp -r liber/ ~/)

BASHRC = $(shell echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.bashrc)

ZSHRC = $(shell echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.zshrc)

PULL = $(shell git pull)

# ---------------------------------------------------------------------

bashrc:
	$(BASHRC)
	$(CP)
	@printf "\033[1;91m[ \033[0m\033[1;37mInit of repo with bashrc rule done \033[0;36m✔\033[0m\033[1;37m\033[1;91m ]\033[0m\n"

zshrc:
	$(ZSHRC)
	$(CP)
	@printf "\033[1;91m[ \033[0m\033[1;37mInit of repo with zshrc rule done \033[1;95m✔\033[0m\033[1;37m\033[1;91m ]\033[0m\n"

update:
	# $(PULL)
	@printf "\033[1;91mUpdated Successfully\033[0m\n"

all : bashrc
