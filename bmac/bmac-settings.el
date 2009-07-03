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
         "Really exit Emacs (automatically exits in 5 secs)? " 5 t)))
(setq x-select-enable-clipboard t)