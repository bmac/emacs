;; use UTF-8
(prefer-coding-system 'utf-8)

(setq create-lockfiles nil)

;; Don't make me type out 'yes' and 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;;suppress startup screen
(setq inhibit-splash-screen t)

;;remove menu bar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;allows m-x to be invoked using ctrl-x ctrl-m
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; Prefer vertical split when possible
(setq split-width-threshold 120)

;;over ride ctrl z
;; (global-set-key "\C-z" nil)

;;change Backspace to remove both () when point is in the middle
(global-set-key (kbd "<DEL>") 'backward-delete-char-untabify)

;; use 4 spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq sgml-basic-offset 4)

;; Don't jump half a page when scrolling
(setq scroll-conservatively 10000
      scroll-preserve-screen-position t)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-cr" 'async-shell-command)
(global-set-key "\C-cl" 'eslint-disable-macro)

;; reopen all files when the change on disk
(global-auto-revert-mode t)

(setq confirm-kill-emacs
      (lambda (e)
        (y-or-n-p-with-timeout
         "Really exit Emacs (automatically exits in 3 secs)? " 3 t)))
(setq x-select-enable-clipboard t)

;;set text-mode as the default major mode
;;fundamental is kinda useless imo
(setq default-major-mode 'text-mode)

;; Transparently open compressed files
(auto-compression-mode t)

;; Highlight matching parentheses when the point is on them
(show-paren-mode 1)

;;backup files in .emacs.d/backups
;;when useing tramp store backups there as well
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs.d/backups/"))
(setq tramp-backup-directory-alist backup-directory-alist)

;;Settings for backup files
(setq delete-old-versions t
      kept-new-versions 100
      kept-old-versions 100
      version-control t)

;; Window switching.
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;;back one
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; foward two

;; highlight the current line
(global-hl-line-mode 1)

;; Use system trash (for emacs 23)
(setq delete-by-moving-to-trash t)

(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;; allow use of narrow to region without a warning
(put 'narrow-to-region 'disabled nil)

;; uniquify!
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'reverse)
  (setq uniquify-separator "|")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*")
  (setq uniquify-buffer-name-style 'forward))

(setq global-linum-mode nil)
(use-package git-gutter
  :diminish git-gutter-mode
  ;; :demand t
  :defer 1
  :bind (("C-x v n" . git-gutter:next-hunk)
         ("C-x v p" . git-gutter:previous-hunk)
         ("C-x v r" . git-gutter:revert-hunk))
  :config
  (progn
    (global-git-gutter-mode t)))

(use-package github-browse-file
  :bind (("C-x g h" . github-browse-file))
  :config
  (setq github-browse-file-show-line-at-point t))

(use-package ido
  :bind (
         ("C-x C-f" . ido-find-file)
         ("C-x b" . ido-switch-buffer)
         ("C-x d" . ido-dired)
         ("C-x k" . ido-kill-buffer)
         )
  :config (progn
            (ido-mode 1)))

(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.ftl\\'" . web-mode))


(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)


(electric-indent-mode -1)
(global-set-key (kbd "RET") 'newline-and-indent)


(use-package renpy-mode
  :mode "\\.rpy\\'"
  :bind (("C-c C-c" . recompile)
         ("C-c c" . recompile)))

(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.1 nil 'invert-face 'mode-line)))

;; Display line numbers in emacs 26
(if (boundp 'global-display-line-numbers-mode)
    (global-display-line-numbers-mode)
  nil)


(use-package powerline
  :defer 0
  :config
  (setq powerline-display-mule-info nil)
  (powerline-default-theme)
  )


(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package drag-stuff
  :bind (
         ("M-n" . drag-stuff-down)
         ("M-p" . drag-stuff-up)
         ))


(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))
(global-set-key (kbd "C-c d") 'duplicate-line)
