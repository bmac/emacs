;;http://steve-yegge.blogspot.com/2008/03/js2-mode-new-javascript-mode-for-emacs.html
(load "js2-20090723b")
(setq js2-use-font-lock-faces t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
