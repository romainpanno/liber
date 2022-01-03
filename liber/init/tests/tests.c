#include <criterion/criterion.h>
#include "../include/my.h"
#include <criterion/redirect.h>

Test(funcname, name, .init = cr_redirect_stdout)
{
    char *av[] = {"./project_name", ""};
    int ac = 2;
    char *res = "";

    cr_assert_stdout_eq_str(res);
}
