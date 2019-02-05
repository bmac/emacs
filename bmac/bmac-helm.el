(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil)))

(defun search-project ()
  (interactive)
  (helm-ag (projectile-root-bottom-up default-directory '("package.json"))))

(defun search-parent-project ()
  (interactive)
  (helm-ag (projectile-root-bottom-up default-directory '("lerna.json"))))

(use-package helm-config
  :bind (
         ("M-x" . helm-M-x)
         ("M-i" . helm-imenu)
         ("C-c h" . helm-ag)
         ("C-c y" . helm-resume)
         )
  :init (setq helm-prevent-escaping-from-minibuffer t
        helm-bookmark-show-location t
        helm-display-header-line nil
        helm-split-window-in-side-p t
        helm-always-two-windows t
        helm-echo-input-in-header-line t
        helm-imenu-execute-action-at-once-if-one nil
        helm-org-format-outline-path t
        helm-M-x-fuzzy-match t
        helm-autoresize-min-height 10
        )
  :config
  (helm-autoresize-mode 1)
  (add-hook 'helm-minibuffer-set-up-hook
            'spacemacs//helm-hide-minibuffer-maybe)
  )


(use-package projectile
  :diminish projectile-mode
  :bind (
         ("C-c g" . search-project)
         ("C-c f" . search-parent-project)
         )
  :init (require 'projectile)
  :config
  (setq
   projectile-use-git-grep t)
  (projectile-register-project-type 'webkit-py '("Tools" "LayoutTests")
                                  ;; :compile "cmake"
                                  :test "PYTHONPATH=./Tools/Scripts/ python -m unittest discover"
                                  :test-suffix "_unittest")
  )

(use-package helm-projectile
  :bind (
         ("C-x f" . helm-projectile-find-file)
         )
  :config
  (setq
   helm-projectile-fuzzy-match t
   projectile-enable-caching t
   )
  (projectile-mode)
  (helm-projectile-on)
  )
