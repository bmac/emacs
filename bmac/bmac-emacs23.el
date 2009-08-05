;; Use system trash (for emacs 23)
(setq delete-by-moving-to-trash t)

(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(defun bmac-set-transparency (n)
  "Sets the transparency of the current buffer. 100 for solid 0 for near see though."
  (interactive "nAlpha (100 for a solid background):")
  (modify-frame-parameters nil (list (cons 'alpha n))))