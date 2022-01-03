##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

CP = $(shell cp -r liber/ ~/)

PULL = $(shell git pull)

# ---------------------------------------------------------------------

all : update bashrc

bashrc:
	$(shell echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.bashrc)
	@printf "\033[1;91m[ \033[0m\033[1;37mInit of repo with bashrc rule done \033[0;36m✔\033[0m\033[1;37m\033[1;91m ]\033[0m\n"

zshrc:
	$(shell echo 'alias liber="bash ~/liber/init_repo.sh"' >> ~/.zshrc)
	@printf "\033[1;91m[ \033[0m\033[1;37mInit of repo with zshrc rule done \033[1;95m✔\033[0m\033[1;37m\033[1;91m ]\033[0m\n"

update:
	# $(PULL)
	@printf "\033[1;91m----------Updated Successfully----------\033[0m\n"
