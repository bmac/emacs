;; Set the load path
;;(setq load-path (cons "~/.emacs.d/" load-path))
(setq load-path (cons "~/.emacs.d/vendor/" load-path))
(setq load-path (cons "~/.emacs.d/bmac/" load-path))

;; use a package manager
(setq prelude-packages '(cl-lib browse-kill-ring find-file-in-repository git-gutter git-gutter-fringe js2-mode markdown-mode stylus-mode rust-mode neotree flx-ido color-theme-solarized))
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
