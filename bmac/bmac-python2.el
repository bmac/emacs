(require 'comint)

(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(require 'ipython)


(define-key comint-mode-map (kbd "M-") 'comint-next-input)
(define-key comint-mode-map (kbd "M-") 'comint-previous-input)
(define-key comint-mode-map [down] 'comint-next-matching-input-from-input)
(define-key comint-mode-map [up] 'comint-previous-matching-input-from-input)


(defun dss-ipython-completion-candidate ()
  (let* ((ugly-return nil)
         (sep ";")
         (python-process (or (get-buffer-process (current-buffer))
                                        ;XXX hack for .py buffers
                             (get-process py-which-bufname)))
         (beg (save-excursion (skip-chars-backward "a-z0-9A-Z_." (point-at-bol))
                               (point)))
         (end (point))
         (pattern (buffer-substring-no-properties beg end))

         (completions nil)
         (completion nil)
         (comint-preoutput-filter-functions
          (append comint-preoutput-filter-functions
                  '(ansi-color-filter-apply
                    (lambda (string)
                      (setq ugly-return (concat ugly-return string))
                      "")))))

    (message pattern)
    (process-send-string python-process
                         (format ipython-completion-command-string pattern))
    (accept-process-output python-process)
    (setq completions
          (split-string (substring ugly-return 0 (position ?\n ugly-return)) sep))

    (setq completions (if (string-match "\\." pattern)
                          (mapcar
                             (lambda (completion)
                               (car (last (cdr (split-string completion "\\.")))))
                             completions)
                        completions))))


;; (require 'anything)
;; (require 'anything-ipython)
;; (when (require 'anything-show-completion nil t)
;;    (use-anything-show-completion 'anything-ipython-complete
;;                                  '(length initial-pattern)))
