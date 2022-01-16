##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

COMPILATION = $NAME

SRC 	=	src/main.c

SRC_TEST	=	$(filter-out main.c,$(SRC))

TEST	=	tests/tests.c

CFLAGS	=	-Wall -Wextra -Wpedantic -I./include/

CSFML	=	-lcsfml-graphics -lcsfml-system -lcsfml-audio -lcsfml-window

CC = gcc

# ------------------------------------------------------------------

OBJ = $(SRC:.c=.o)

%.o:		%.c
	@$(CC) -c -o $@ $< $(CFLAGS)
	@printf "[\033[0;32mcompiled\033[0m] % 29s\n" $< |  tr ' ' '.'

EXECUTABLE: $(OBJ)
	@$(CC) $(OBJ) -o $(COMPILATION) $(CSFML) $(CFLAGS)
	@printf "[\033[0;36mbuilt\033[0m] % 32s\n" $(OBJ) | tr ' ' '.'

all : EXECUTABLE

fclean : clean
	rm -f $(OBJ) $(COMPILATION)

clean:
	rm -f *~
	rm -f $(OBJ)
	rm -f 'a.out'
	rm -f *.gcno
	rm -f *.gcda
	rm -f *.swn
	rm -f *.swo
	rm -f *.c.swp
	rm -f 'unit_tests'

re: fclean all

noice: re
	$(MAKE) clean

debug: CFLAGS += -g3
debug:	fclean $(OBJ)
	gcc -o $(COMPILATION) $(OBJ) $(INCLUDE) $(CFLAGS)