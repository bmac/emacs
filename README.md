emacs
=====

My dot emacs file 

Installation instructions:
```bash
$ git clone git@github.com:bmac/emacs.git ~/.emacs.d
```

Dependenecies should be fetched when emacs is opened.



#### Using Jedi Mode
If jedi mode is throwing errors you may need to install some a python module to make it work.
```bash
$ git clone git@github.com:bmac/emacs.git ~/.emacs.d
$ cd ~/.emacs.d/elpa/jedi-20140131.1756/
$ make requirements
$ pip install -r requirements.txt
```
