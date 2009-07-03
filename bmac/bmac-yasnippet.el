
;;yasnippet http://code.google.com/p/yasnippet/
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
;;(define-key yas/keymap [tab] 'yas/expand) 
;;map to something useless its in hippie expand
(setq yas/trigger-key (kbd "C-c <kp-multiply>"))