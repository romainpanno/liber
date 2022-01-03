##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

COMPILATION = navy

SRC 	=	src/check_touch.c					\
			src/communication.c					\
			src/handling_sigaction.c			\
			src/init_users.c					\
			src/manage_settings.c				\
			src/manage_sigaction.c				\
			src/navy_main.c						\
			src/boats/config_boat.c				\
			src/boats/detect_error_functions.c	\
			src/boats/free_functions.c			\
			src/boats/functions_create.c		\
			src/boats/init_map.c				\
			src/boats/print_map_functions.c		\
			src/lib/get_line.c					\
			src/lib/my_atoi.c					\
			src/lib/my_put_nbr.c				\
			src/lib/my_putchar.c				\
			src/lib/my_strlen.c

SRC_TEST	=	$(filter-out main.c,$(SRC))

RETRY	=	retry.c

TEST	=	tests/tests.c

CFLAGS	=	-Wall -Wextra -Wpedantic -I./include/

CC = gcc

# ---------------------------------------------------------------------

OBJ = $(SRC:.c=.o)

%.o:		%.c
	@$(CC) -c -o $@ $< $(CFLAGS)
	@printf "[\033[0;32mcompiled\033[0m] % 29s\n" $< |  tr ' ' '.'

EXECUTABLE: $(OBJ)
	@$(CC) $(SRC) -o $(COMPILATION) $(CFLAGS)
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

debug:	fclean $(OBJ)
	gcc -o $(COMPILATION) $(OBJ) $(INCLUDE) -g3

tests_run:	fclean
	gcc -o unit_tests $(SRC_TEST) $(TEST) --coverage -lcriterion $(CFLAGS)
	./unit_tests
gcovr:
	gcovr --exclude tests --branch
