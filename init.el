;; Set the load path
;;(setq load-path (cons "~/.emacs.d/" load-path))
(setq load-path (cons "~/.emacs.d/vendor/" load-path))
(setq load-path (cons "~/.emacs.d/bmac/" load-path))

;; use a package manager
(setq prelude-packages '(cl-lib browse-kill-ring find-file-in-repository git-gutter-fringe js2-mode markdown-mode stylus-mode rust-mode neotree))
(require 'prelude-packages)

;;Make sure .emacs file is edited in lisp mode
(setq auto-mode-alist (cons '("\.emacs" . lisp-mode) auto-mode-alist))


;;bmac.el stuff is custom setting of
;;various libs

;;one off settings and key assignments
(load "bmac-settings.el")

;; modified solarized theme to work in osx terminal app
(load "bmac-theme.el")

;;functions I find useful
(load "bmac-functions.el")

;;use hippie expand instead of debbrev
(load "bmac-hippie-expand.el")

(load "bmac-javascript.el")

(require 'browse-kill-ring)

(load "bmac-abbrev-table.el")




(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
