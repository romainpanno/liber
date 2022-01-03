# LIBER

Just enter Make to build the liber and write this to create your lib base :

**For bashrc use 'bashrc' rule** :
```
make bashrc
```

**For zshrc use 'zshrc' rule** :
```
make zshrc
```

Or you to add this alias line to your bashrc / zshrc:

```
alias liber="bash /home/romain/bashfunc/init_repo/init_repo.sh"
```

This function will create your repository with :
  - Makefile,
  - src/      :
                - main.c
  - include/  :
                - my.h
  - tests/    :
                - tests.c
  
**For UPDATE**
```
make udpate
```
