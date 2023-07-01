;; Hippie expand ordering 
(load "complete-with-calc-result.el")
(setq completion-ignore-case t)

(global-set-key [(meta ?/)] 'hippie-expand)
(global-set-key (kbd "M-RET") 'hippie-expand)

(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-complete-file-name-partially
	try-complete-file-name
	try-expand-list
	try-expand-line
	my-try-complete-with-calc-result))

