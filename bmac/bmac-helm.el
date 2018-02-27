(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil)))


(setq helm-prevent-escaping-from-minibuffer t
      helm-bookmark-show-location t
      helm-display-header-line nil
      helm-split-window-in-side-p t
      helm-always-two-windows t
      helm-echo-input-in-header-line t
      helm-imenu-execute-action-at-once-if-one nil
      helm-org-format-outline-path t
      )

(with-eval-after-load 'helm
  (setq helm-autoresize-min-height 10)
  (helm-autoresize-mode 1)
  (add-hook 'helm-minibuffer-set-up-hook
            'spacemacs//helm-hide-minibuffer-maybe)
  )

;; (with-eval-after-load 'helm
;;   (defvar helm-source-header-default-background
;;     (face-attribute 'helm-source-header :background))
;;   (defvar helm-source-header-default-foreground
;;     (face-attribute 'helm-source-header :foreground))
;;   (defvar helm-source-header-default-box
;;     (face-attribute 'helm-source-header :box))
;;   (defvar helm-source-header-default-height
;;     (face-attribute 'helm-source-header :height) ))


(setq helm-M-x-fuzzy-match t)
(setq helm-projectile-fuzzy-match t)
(require 'helm-config)
(require 'helm-projectile)
(helm-projectile-on)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x f") 'helm-projectile-find-file)
(global-set-key (kbd "C-c g") 'projectile-grep)
