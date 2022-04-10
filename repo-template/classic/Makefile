##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## makefile that gcc
##

COMPILATION = $NAME

SRC 	:=	main.c
SRC		:= $(addprefix src/, $(SRC))

SRC_TEST	=	$(filter-out main.c,$(SRC))

TEST	=	tests/tests.c

CFLAGS	=	-Wall -Wextra -pedantic -I./include -I./lib/my

LDFLAGS	=	-L ./lib/my/ -lmy

RULE = $(filter-out $@,$(MAKECMDGOALS))

# ------------------------------------------------------------------

OBJ = $(SRC:.c=.o)

%.o:		%.c
	@$(CC) -c -o $@ $< $(CFLAGS)
	@printf "[\033[0;32mcompiled\033[0m] % 29s\n" $< |  tr ' ' '.'

all: make_lib $(COMPILATION)
ifneq (,$(wildcard $(COMPILATION)))
ifneq ($(RULE), re)
	@printf "[\033[1;32mAlready up to date\033[0m]\n"
endif
endif

$(COMPILATION): $(OBJ)
	@$(CC) $(OBJ) -o $(COMPILATION) $(LDFLAGS)
	@printf "[\033[0;36mbuilt\033[0m] % 32s\n" $(OBJ) | tr ' ' '.'
	@printf "[\033[1;93mBinary \033[1;32mcreated\
	\033[0m] % 23s\n" $(COMPILATION) | tr ' ' '.'

make_lib:
	@make $(RULE) -s -C ./lib/my
ifneq (,$(RULE))
	@printf "[\033[1;35mrule : $(RULE)\033[0m]\n"
endif
ifeq (,$(wildcard ./lib/my/*my.a))
ifeq (, $(RULE))
	@printf "[\033[1;35mLib rule : all\033[0m]\n"
endif
endif

clean:
	@$(RM) -f *~ *.gcno *.gcda *.gcda *.swn *.swo *.c.swp
	@$(RM) -f 'a.out'
	@$(RM) -f 'unit_tests'
ifneq (,$(wildcard ./$(OBJ)))
	@$(RM) -f $(OBJ)
	@printf "[\033[1;31mDeleted\033[0m] % 32s\n" $(OBJ) | tr ' ' '.'
else
	@printf "[\033[1;36mOBJ \033[1;32malready deleted\033[0m]\n"
endif

fclean : make_lib clean
ifneq (,$(wildcard ./$(COMPILATION)))
	@rm -f $(COMPILATION)
	@printf "[\033[1;93mBinary \033[1;31mdeleted\
	\033[0m] % 25s\n" $(COMPILATION) | tr ' ' '.'
else
	@printf "[\033[1;93mBinary \033[1;32malready deleted\033[0m]\n"
endif

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
