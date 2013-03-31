;; use UTF-8
(prefer-coding-system 'utf-8)

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

;;over ride ctrl z
(global-set-key "\C-z" nil)

;;change Backspace to remove both () when point is in the middle
(global-set-key (kbd "<DEL>") 'backward-delete-char-untabify)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;lium.el from http://stud4.tuwien.ac.at/~e0225855/linum/linum.html
(require 'linum)
(global-linum-mode t)

;;ido mode
(ido-mode t)

;; use shift alt arrow keys to move in split screen
(windmove-default-keybindings 'meta)

(setq confirm-kill-emacs
      (lambda (e)
        (y-or-n-p-with-timeout
         "Really exit Emacs (automatically exits in 3 secs)? " 3 t)))
(setq x-select-enable-clipboard t)

;;set text-mode as the default major mode
;;fundamental is kinda useless imo
(setq default-major-mode 'text-mode)

;; spelling helpers for text mode
(add-hook 'text-mode-hook 'turn-on-flyspell)
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

;; uniquify!
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

;; color theme solarized dark
(load-theme 'solarized-dark t)

(require 'yasnippet)
(yas/global-mode 1)

;; (autoload 'find-file-in-project "find-file-in-project" "Find file in project." t)

;; http://cx4a.org/software/auto-complete/index.html#Latest_Stable
;; http://cx4a.org/software/auto-complete/manual.html
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/ac-dict")
(ac-config-default)

;; mac stuff
(if (eq 'darwin system-type)
    (progn
      (menu-bar-mode 1)
      (setq exec-path
            '(
	      "/opt/local/bin"
	      "/opt/local/sbin"
	      "/usr/bin"
	      "/bin"
	      "/usr/sbin"
	      "/sbin"
	      "/usr/local/bin"
	      "/usr/local/git/bin"
	      "/usr/X11/bin"
	      )
            )))
