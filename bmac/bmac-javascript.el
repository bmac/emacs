;(require 'mocha)
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
      jsx-indent-level 2
      js2-indent-switch-body t
      js2-idle-timer-delay 0.2)


(setq mocha-command "time node_modules/.bin/mocha"
 mocha-environment-variables "BUILD_ENV=qa NODE_ENV=test"
 mocha-options "--colors --compilers js:babel-core/register --require tests/utils/jsdom-setup.js --require tests/utils/shim-webpack-require.js --watch"
 mocha-reporter "spec"
 mocha-which-node ""
 sgml-basic-offset 2
 css-indent-offset 2)

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

;; (defun mocha-test-file ()
;;   "Test the current file."
;;   (interactive)
;;   (setq last-buffer-name (buffer-file-name))
;;   (mocha-run (buffer-file-name)))


;; (defun mocha-redo-last-command ()
;;   "Test the current file."
;;   (interactive)
;;   (mocha-run last-buffer-name))

;; Do not pompt before killing process buffers
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

(defun mocha-run-or-reveal (buffer-file-name reveal)
  (unless (get-buffer-window "*mocha tests*")
    (window-configuration-to-register ?p)
    )
  (if (and reveal (get-buffer "*mocha tests*"))
      (display-buffer "*mocha tests*" 'display-buffer-pop-up-frame)
    (mocha-run buffer-file-name)
    )
  )

(setq last-buffer-name nil)
(defun save-and-test-file ()
  "Test the current file."
  (interactive)  
  (let ((old-buffer-name last-buffer-name))
    (setq last-buffer-name (buffer-file-name))
  
    (mocha-run-or-reveal (buffer-file-name) (string= old-buffer-name (buffer-file-name)))
    )
  )


(defun test-last-file ()
  "Test the current file."
  (interactive)
  (mocha-run-or-reveal last-buffer-name t))

(defun smart-test-file ()
  (interactive)
  (let ((buffer-is-test-file (string/ends-with (buffer-file-name) "test.js")))
    (if buffer-is-test-file
        (save-and-test-file)
        (test-last-file)
      )
    )
  )

(defun bmac-test-dismiss ()
  (interactive)
  (jump-to-register ?p)
  )

;; Use lambda for anonymous functions
(add-hook 'js2-mode-hook
          (lambda ()
            (require 'mocha)

            ;;(define-key js2-mode-map "\C-c\C-c" 'test-js)
            ;;(define-key js2-mode-map "\C-cc" 'test-js)
            (define-key js2-mode-map "\C-ct" 'smart-test-file)
            (define-key js2-mode-map "\C-cd" 'bmac-test-dismiss)
            ;;(define-key js2-mode-map "\C-cr" 'toggle-test-file-other)
            (define-key js2-mode-map (kbd "RET") 'newline-and-indent)
            (define-key js2-mode-map "\C-c/" 'sgml-close-tag)
            (define-key js2-mode-map "\C-d/" 'duplicate-line)
            (define-key js2-mode-map "\C-cg" 'projectile-grep)
            (define-key js2-mode-map (kbd "M-.") 'dumb-jump-go)
            (define-key js2-mode-map (kbd "M-,") 'dumb-jump-back)
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



;; (defadvice js-jsx-indent-line (after js-jsx-indent-line-after-hack activate)
;;   "Workaround sgml-mode and follow airbnb component style."
;;   (let* ((cur-line (buffer-substring-no-properties
;;                     (line-beginning-position)
;;                     (line-end-position))))
;;     (if (string-match "^\\( +\\)\/?> *$" cur-line)
;;       (let* ((empty-spaces (match-string 1 cur-line)))
;;         (replace-regexp empty-spaces
;;                         (make-string (- (length empty-spaces) sgml-basic-offset) 32)
;;                         nil
;;                         (line-beginning-position) (line-end-position))))))
