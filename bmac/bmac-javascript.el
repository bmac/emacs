(require 'coffee-mode)

;;http://steve-yegge.blogspot.com/2008/03/js2-mode-new-javascript-mode-for-emacs.html
;; Now using fork from https://github.com/mooz/js2-mode
;; emacs --batch -f batch-byte-compile js2-mode.el
;;(setq js2-use-font-lock-faces t)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-consistent-level-indent-inner-bracket-p t
      js2-pretty-multiline-decl-indentation-p t
      js2-cleanup-whitespace t
      js2-enter-indents-newline t
      js2-indent-on-enter-key nil
      js2-global-externs '("$" "Backbone" "_" "ko" "angular" "require" "exports")
      js2-idle-timer-delay 1)

;; Use lambda for anonymous functions
(add-hook 'js2-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil `(("\\(function\\)"
                          (0 (progn (compose-region (match-beginning 1)
                                                    (match-end 1) "\u0192")
                                    nil)))))))
