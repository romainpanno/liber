##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

COMPILATION = $(shell bash write_bash.sh)

# ---------------------------------------------------------------------

all :
	$(COMPILATION)
	@echo "\e[6mInit of repo done ✔\e0"
