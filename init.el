;; Run vanilla emacs in the terminal
(when (display-graphic-p)

  ;; Set the load path
  (setq load-path (cons "~/.emacs.d/" load-path))
  (setq load-path (cons "~/.emacs.d/vendor/" load-path))
  (setq load-path (cons "~/.emacs.d/bmac/" load-path))
  
  ;; use a package manager
  (require 'package)
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize)

  ;;Make sure .emacs file is edited in lisp mode
  (setq auto-mode-alist (cons '("\.emacs" . lisp-mode) auto-mode-alist))


  ;;bmac.el stuff is custom setting of
  ;;various libs

  ;; one off settings and key assignments
  (load "bmac-settings.el")

  ;;functions I find useful
  (load "bmac-functions.el")

  ;;use hippie expand instead of debbrev
  (load "bmac-hippie-expand.el")

  (load "bmac-javascript.el")

  (require 'browse-kill-ring)

  (load "bmac-abbrev-table.el")

  ;;(load-file "~/.emacs.d/vendor/emacs-for-python/epy-init.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe-mode 0 nil (fringe))
 '(ns-pop-up-frames nil))
