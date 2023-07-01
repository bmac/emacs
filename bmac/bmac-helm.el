(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil)))

(defun locate-dominating-file (file name)
  "Look up the directory hierarchy from FILE for a directory containing NAME.
Stop at the first parent directory containing a file NAME,
and return the directory.  Return nil if not found.
Instead of a string, NAME can also be a predicate taking one argument
\(a directory) and returning a non-nil value if that directory is the one for
which we're looking."
  ;; copied from files.el (stripped comments) emacs-24 bzr branch 2014-03-28 10:20
  (setq file (abbreviate-file-name file))
  (let ((root nil)
        try)
    (while (not (or root
                    (null file)
                    (string-match locate-dominating-stop-dir-regexp file)))
      (setq try (if (stringp name)
                    (file-exists-p (expand-file-name name file))
                  (funcall name file)))
      (cond (try (setq root file))
            ((equal file (setq file (file-name-directory
                                     (directory-file-name file))))
             (setq file nil))))
    (and root (expand-file-name (file-name-as-directory root)))))

(require 'cl-lib)
(defun search-root-bottom-up (dir &optional list)
  "Identify a project root in DIR by bottom-up search for files in LIST.
If LIST is nil, use '.git' instead.
Return the first (bottommost) matched directory or nil if not found."
  (locate-dominating-file
   dir
   (lambda (directory)
     (let ((files (mapcar (lambda (file) (expand-file-name file directory))
                          (or list '(".git")))))
       (cl-some (lambda (file) (and file (file-exists-p file))) files)))))

(defun search-project ()
  (interactive)
  (helm-ag (search-root-bottom-up default-directory '("package.json"))))

(defun search-parent-project ()
  (interactive)
  (helm-ag (search-root-bottom-up default-directory '("lerna.json"))))

(use-package helm
  :bind (
         ("M-x" . helm-M-x)
         ("M-i" . helm-imenu)
         ("C-c h" . helm-ag)
         ("C-c y" . helm-resume)
         ("C-c g" . search-project)
         ("C-c f" . search-parent-project)
         ("C-x f" . project-find-file)
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

