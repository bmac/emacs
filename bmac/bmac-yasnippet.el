
;;yasnippet http://code.google.com/p/yasnippet/

(require 'yasnippet)
(require 'dropdown-list)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
;;(define-key yas/keymap [tab] 'yas/expand) 
(setq yas/prompt-functions '(yas/ido-prompt 
			     yas/dropdown-prompt 
			     yas/no-prompt)
      yas/also-auto-indent-first-line nil
      yas/indent-line (quote fixed))
