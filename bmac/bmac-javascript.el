;;http://steve-yegge.blogspot.com/2008/03/js2-mode-new-javascript-mode-for-emacs.html
;;emacs --batch --eval '(byte-compile-file "js2-20090723b.el")'

(load "js2-20090723b")
(setq js2-use-font-lock-faces t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq 
 js2-auto-indent-p t
 js2-basic-offset 2
 js2-bounce-indent-p t
 js2-cleanup-whitespace t
 js2-enter-indents-newline t
 js2-highlight-level 3
 js2-indent-on-enter-key t
 js2-mirror-mode nil
 js2-mode-escape-quotes nil
 js2-enter-indents-newline t
 js2-indent-on-enter-key nil)

