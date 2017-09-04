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

(global-set-key (kbd "s-t") 'find-file-in-repository)
(global-set-key (kbd "C-x f") 'find-file-in-repository)


;; reopen all files when the change on disk
(global-auto-revert-mode t)

;;lium.el from http://stud4.tuwien.ac.at/~e0225855/linum/linum.html
(require 'linum)
(global-linum-mode t)

;; use shift alt arrow keys to move in split screen
(windmove-default-keybindings 'meta)

(setq confirm-kill-emacs
      (lambda (e)
        (y-or-n-p-with-timeout
         "Really exit Emacs (automatically exits in 3 secs)? " 3 t)))
(setq x-select-enable-clipboard t)
(setq require-final-newline t)

;;set text-mode as the default major mode
;;fundamental is kinda useless imo
(setq default-major-mode 'text-mode)

;; spelling helpers for text mode
;; (add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'text-mode-hook 'abbrev-mode)

;; Transparently open compressed files
(auto-compression-mode t)

;; Save a list of recent files visited
(recentf-mode 1)

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
(windmove-default-keybindings) ;; Shift+direction
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
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")


(if (display-graphic-p)
    (progn
      ;; if graphic
      (require 'git-gutter-fringe)
      (setq-default left-fringe-width  10))
  ;; else terminal
  (progn
    (require 'git-gutter)
    (git-gutter:linum-setup)
    ))
(global-git-gutter-mode t)

;; Jump to next/previous hunk
(global-set-key (kbd "C-x v p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x v n") 'git-gutter:next-hunk)

;; Stage current hunk
;; (global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)


(setq github-browse-file-show-line-at-point t)
(global-set-key (kbd "C-x g h") 'github-browse-file)

;; (when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize))


(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)


(add-to-list 'auto-mode-alist '("\\.hbs\\'" . html-mode))


(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)
