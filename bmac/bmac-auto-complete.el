(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/dict")
(ac-config-default)

(require 'jquery-doc)

;; adds ac-source-jquery to the ac-sources list
(add-hook 'js2-mode-hook 'jquery-doc-setup)

;; (require 'auto-complete)
;; ;; (require 'auto-complete-yasnippet)
;; ;; (require 'auto-complete-ruby)
;; ;;(require 'auto-complete-css)
;; ;;(require 'auto-complete-cpp)
;; (require 'auto-complete-python)
;; ;; (require 'auto-complete-emacs-lisp)

;; (global-auto-complete-mode t)
;; ;; (set-face-background 'ac-menu-face "lightgray")
;; ;; (set-face-underline 'ac-menu-face "darkgray")
;; ;; (set-face-background 'ac-selection-face "
;; (define-key ac-complete-mode-map "\t" 'ac-expand)
;; (define-key ac-complete-mode-map "\r" 'ac-complete)
;; (define-key ac-complete-mode-map "\M-n" 'ac-next)
;; (define-key ac-complete-mode-map "\M-p" 'ac-previous)
;; ;;(setq ac-auto-start 3)
;; (setq ac-dwim t)
;; (set-default 'ac-sources '(;; ac-source-yasnippet
;;                            ac-source-abbrev
;;                            ac-source-words-in-buffer
;;                            ;; ac-source-files-in-current-dir
;;                            ;; ac-source-symbols
;;                            ;; ac-source-filename
;;                            ))


;; (setq ac-modes
;;       (append ac-modes
;;               '(emacs-lisp-mode 
;; 		lisp-interaction-mode lisp-mode
;; 		c-mode java-mode php-mode ruby-mode
;; 		css-mode sh-mode nxml-mode makefile-mode
;; 		sql-mode cperl-mode
;; 		eshell-mode org-mode
;; 		text-mode html-mode django-html-mode
;;                 )))
;; (add-to-list 'ac-trigger-commands 'org-self-insert-command)

;; ;; (add-hook 'emacs-lisp-mode-hook
;; ;;           (lambda ()
;; ;;             (setq ac-sources '(ac-source-abbrev ac-source-words-in-buffer ac-source-symbols))))

;; ;; (add-hook 'eshell-mode-hook
;; ;;           (lambda ()
;; ;;             (setq ac-sources '(ac-source-abbrev ac-source-files-in-current-dir ac-source-words-in-buffer))))

;; ;; (add-hook 'ruby-mode-hook
;; ;;           (lambda ()
;; ;;             (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools)))))

;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (ac-ropemacs-setup)
;;             (setq ac-omni-completion-sources '(("\\." ac-source-ropemacs)))))

