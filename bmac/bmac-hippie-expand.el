(load "complete-with-calc-result.el")

(global-set-key [(meta ?/)] 'hippie-expand)

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

