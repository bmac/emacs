
;;yasnippet http://code.google.com/p/yasnippet/

(require 'yasnippet)
(require 'dropdown-list)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
;;(define-key yas/keymap [tab] 'yas/expand) 
(setp yas/prompt-functions '(yas/ido-prompt 
			     yas/dropdown-prompt 
			     yas/no-prompt))

(setp yas/trigger-key '("TAB" "SPC"))