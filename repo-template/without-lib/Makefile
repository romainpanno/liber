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

CFLAGS	=	-Wall -Wextra -pedantic -I./include

RULE = $(filter-out $@,$(MAKECMDGOALS))

# ------------------------------------------------------------------

OBJ = $(SRC:.c=.o)

%.o:		%.c
	@$(CC) -c -o $@ $< $(CFLAGS)
	@printf "[\033[0;32mcompiled\033[0m] % 29s\n" $< |  tr ' ' '.'

all: make_lib $(COMPILATION)

$(COMPILATION): $(OBJ)
	@$(CC) $(OBJ) -o $(COMPILATION)
	@printf "[\033[0;36mbuilt\033[0m] % 32s\n" $(OBJ) | tr ' ' '.'
	@printf "[\033[1;93mBinary created\033[0m] % 23s\n" $(COMPILATION) | tr ' ' '.'

make_lib:
	@make $(RULE) -s -C ./lib/my
	@printf "[\033[1;36mLib created\033[0m]\n"

clean:
	@$(RM) -f *~ *.gcno *.gcda *.gcda *.swn *.swo *.c.swp
	@$(RM) -f $(OBJ)
	@$(RM) -f 'a.out'
	@$(RM) -f 'unit_tests'
	@printf "[\033[0;36mDeleted\033[0m] % 32s\n" $(OBJ) | tr ' ' '.'

fclean : make_lib clean
	@rm -f $(COMPILATION)
	@printf "[\033[1;93mBinary deleted\033[0m] % 25s\n" $(COMPILATION) | tr ' ' '.'

re: fclean all

debug: CFLAGS += -g3
debug: RULE = re
debug:	re

noice: RULE = re
noice: re
	$(MAKE) clean

tests_run:	fclean
	gcc -o unit_tests $(SRC_TEST) $(TEST) --coverage -lcriterion $(CFLAGS)
	./unit_tests
gcovr:
	gcovr --exclude tests --branch
