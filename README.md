# LIBER Project

Liber create your epitech repository according to your wishes.

This is a simple, efficient and fast program that allows you to be more productive by skipping the repository initialization step.

Yes! liber takes care of that.
If you don't like it, well find yourself on [raphaelMrci's project link](https://github.com/raphaelMrci/Epigen): :


Just enter this line in your terminal to init Liber :

```
sudo bash -c "$(curl fsSL https://raw.githubusercontent.com/romainpanno/liber/master/init.sh)"
```

Liber can crate a project for a classic project & a graphic project (not for python because huntears once said "it's just a shebang and a contition":

You can also choose whether or not you want to add your library to the project with `-wl` or `--without-lib` flag. 

You can combine `-csfml` & `-wl` of course.

## Here are some examples
```
liber
```
This command will create your repository with :
  - Makefile, (my own make file with colors, a gift from me if you haven't already)
  - src/      :
                - main.c
  - include/  :
                - my.h
  - tests/    :
                - tests.c
  - lib/

```
liber -g
```
This command will create your repository with :
  - Makefile, (with CSFML flags : Window, System, Graphics & Audio)
  - src/      :
                - main.c
  - include/  :
                - my.h (with CSFML includes
  - lib/

Here there is no test file but if you want it to be the case, don't hesitate to talk to me by sending me a pm or a pr!


```
liber -wl
```
This command will create your repository with :
  - Makefile,
  - src/      :
                - main.c
  - include/  :
                - my.h
  - tests/    :
                - tests.c


```
liber -g -wl
```
This command will create your repository with :
  - Makefile, (with CSFML flags : Window, System, Graphics & Audio)
  - src/      :
                - main.c
  - include/  :
                - my.h (with CSFML includes


## For UPDATE
```
liber -u
```
or
```
liber --update
```
