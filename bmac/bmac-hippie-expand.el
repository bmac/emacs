;; Hippie expand ordering 
(load "complete-with-calc-result.el")
(setq completion-ignore-case t)

(global-set-key [(meta ?/)] 'hippie-expand)
(global-set-key (kbd "M-RET") 'hippie-expand)

(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
	try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-all-abbrevs
	try-expand-list
	try-expand-line
	try-complete-lisp-symbol-partially
	try-complete-lisp-symbol
	my-try-complete-with-calc-result))

