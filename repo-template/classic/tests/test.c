/*
** EPITECH PROJECT, 2022
** okey
** File description:
** $DESCRIPTION
*/

#include <criterion/criterion.h>
#include "../include/okey.h"
#include <criterion/redirect.h>

Test(funcname, name, .init = cr_redirect_stdout)
{
    char *av[] = {"./okey", ""};
    int ac = 2;
    char *res = "";

    cr_assert_stdout_eq_str(res);
}
