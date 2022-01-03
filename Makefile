##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

COMPILATION = $(shell bash write_bash.sh && cp -r liber/ ~/)

# ---------------------------------------------------------------------

all :
	$(COMPILATION)
	@echo "Init of repo done ✔"
