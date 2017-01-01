(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

;;http://steve-yegge.blogspot.com/2008/03/js2-mode-new-javascript-mode-for-emacs.html
;; Now using fork from https://github.com/mooz/js2-mode
;; emacs --batch -f batch-byte-compile js2-mode.el
;;(setq js2-use-font-lock-faces t)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(setq js2-consistent-level-indent-inner-bracket-p t
      js2-pretty-multiline-decl-indentation-p t
      js2-cleanup-whitespace t
      js2-enter-indents-newline t
      js2-indent-on-enter-key nil
      js2-basic-offset 2
      js2-global-externs '("$" "Backbone" "_" "ko" "angular" "Ember" "require" "module" "exports" "define" "Promise")
      js2-idle-timer-delay 1)

(setq compilation-scroll-output t)
(defun test-js ()
  (interactive)
  (save-buffer)
  (recompile t))

;; jump to test file
(defun test-js ()
  (interactive)
  (save-buffer)
  (recompile t))

(defun trim-test-js (filename)
  (replace-regexp-in-string "\\(-test.js$\\)" ".js" filename)
)

(defun replace-test-with-app (filename)
  (replace-regexp-in-string "\\(tests/unit\\)" "app" filename)
)

(defun replace-app-with-test (filename)
  (replace-regexp-in-string "\\(/app/\\)" "/tests/unit/" filename)
)

(defun add-test-js (filename)
  (replace-regexp-in-string "\\(.js$\\)" "-test.js" filename)
)

(defun get-app-file (filename)
  (trim-test-js (replace-test-with-app filename))
)

(defun get-test-file (filename)
  (add-test-js (replace-app-with-test filename))
)

(defun toggle-test-file ()
  (interactive)
  (let ((filename buffer-file-name)
        (buffer-is-test-file (string/ends-with (buffer-file-name) "test.js")))
    (if buffer-is-test-file
        (find-file (get-app-file filename))
      (find-file (get-test-file filename))
      )
    )
  )

(defun toggle-test-file-other ()
  (interactive)
  (let ((filename buffer-file-name)
        (buffer-is-test-file (string/ends-with (buffer-file-name) "test.js")))
    (if buffer-is-test-file
        (find-file-other-window (get-app-file filename))
      (find-file-other-window (get-test-file filename))
      )
    )
  )

(defun string/ends-with (string suffix)
      "Return t if STRING ends with SUFFIX."
      (and (string-match (rx-to-string `(: ,suffix eos) t)
                         string)
           t))

;; run test for file

;; Use lambda for anonymous functions
(add-hook 'js2-mode-hook
          (lambda ()
            ;;(define-key js2-mode-map "\C-c\C-c" 'test-js)
            ;;(define-key js2-mode-map "\C-cc" 'test-js)
            (define-key js2-mode-map "\C-ct" 'mocha-test-file)
            ;;(define-key js2-mode-map "\C-cr" 'toggle-test-file-other)
            (define-key js2-mode-map (kbd "RET") 'newline-and-indent)
            (define-key js2-mode-map "\C-c/" 'sgml-close-tag)
            (define-key js2-mode-map "\C-d/" 'duplicate-line)
            (define-key rjsx-mode-map "<" 'insert-char)
            (define-key rjsx-mode-map (kbd "C-d") 'duplicate-line)

            (pabbrev-mode)
            (font-lock-add-keywords
             nil `(("\\(function\\)"
                          (0 (progn (compose-region (match-beginning 1)
                                                    (match-end 1) "\u0192")
                                    nil)))))))

(add-hook 'rjsx-mode-hook
          (lambda ()
            (define-key rjsx-mode-map "<" 'self-insert-command)
            (define-key rjsx-mode-map (kbd "C-d") 'duplicate-line)
            )
          )
