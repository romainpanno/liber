/*
** EPITECH PROJECT, 2022
** $NAME
** File description:
** $DESCRIPTION
*/

#include <criterion/criterion.h>
#include "../include/$NAME.h"
#include <criterion/redirect.h>

Test(funcname, name, .init = cr_redirect_stdout)
{
    char *av[] = {"./$NAME", ""};
    int ac = 2;
    char *res = "";

    cr_assert_stdout_eq_str(res);
}
