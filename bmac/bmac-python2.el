(require 'pycomplete)
(load-library "python")

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
interpreter-mode-alist)
      python-mode-hook
      '(lambda () (progn
(set-variable 'py-indent-offset 4)
(set-variable 'py-smart-indentation nil)
(set-variable 'indent-tabs-mode nil)
;;(highlight-beyond-fill-column)
                    (define-key python-mode-map "\C-m" 'newline-and-indent)
;(pabbrev-mode)
;(abbrev-mode)
)
      )
)

(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(setq interpreter-mode-alist(cons '("python" . python-mode)
                             interpreter-mode-alist))


(setq longlines-show-hard-newlines t) ; displays "\" at the end of lines that wrap past the window's edge

                                        ; camel case word navigation
(when (boundp 'subword-mode)
  (add-hook 'after-change-major-mode-hook '(lambda () (subword-mode 1))))

                                        ; Bindings
(defun delete-backward-indent (&optional arg)
  "Erase a level of indentation, or 1 character"
  (interactive "*P")
  (if (= (current-column) 0)
      (delete-backward-char 1)
    (let ((n (mod (current-column) standard-indent)))
      (if (looking-back (concat "^\s*" (make-string n 32)))
          (if (= n 0)
              (delete-backward-char standard-indent)
            (delete-backward-char n))
        (delete-backward-char 1)))))

(defun newline-maybe-indent ()
  "Like newline-and-indent, but doesn't indent if the previous line is blank"
  (interactive "*")
  (if (= (line-beginning-position) (line-end-position))
      (newline)
    (newline-and-indent)))

(add-hook 'python-mode-hook
          '(lambda ()
             (hs-minor-mode 1) ; code folding
             (define-key python-mode-map (kbd "RET") 'newline-maybe-indent)
             (define-key python-mode-map (kbd "DEL") 'delete-backward-indent)
	     (define-key python-mode-map "\t" 'py-complete)
	     (define-key python-mode-map [f1] 'py-complete-help-thing-at-point)
	     (define-key python-mode-map "(" 'py-complete-electric-lparen)
	     (define-key python-mode-map "," 'py-complete-electric-comma)
	     (define-key python-mode-map [f2] 'py-complete-signature-expr)
	     (define-key python-mode-map [f3] 'py-complete-help)
))

                                        ; On-the-fly spell checking
(add-hook 'python-mode-hook '(lambda () (flyspell-prog-mode)))

; On-the-fly pyflakes checking
(require 'flymake-point) ; shows errors in the minibuffer when highlighted (http://bitbucket.org/brodie/dotfiles/src/tip/.emacs.d/plugins/flymake-point.el)
;; requires pyflakes to be installed change next string to be pyflakes command
(setq python-check-command "pyflakes-2.4")
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes-2.4" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
(add-hook 'python-mode-hook '(lambda () (flymake-mode 1)))





