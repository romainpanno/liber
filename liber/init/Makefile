##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

COMPILATION = project_name

SRC 	=	src/main.c

SRC_TEST	=	

TEST	=	tests/tests.c

CFLAGS	=	-Wall -Wextra -Wpedantic -I./include/

# ---------------------------------------------------------------------

OBJ = $(SRC:.c=.o)

$(COMPILATION): $(OBJ)
	gcc -o $(COMPILATION) $(OBJ)

all : $(COMPILATION)

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
