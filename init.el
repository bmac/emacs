;; Set the load path
(setq load-path (cons "~/.emacs.d/" load-path))
(setq load-path (cons "~/.emacs.d/vendor/" load-path))
(setq load-path (cons "~/.emacs.d/vendor/emacs-color-theme-solarized/" load-path))
(setq load-path (cons "~/.emacs.d/bmac/" load-path))
;; Include subdirectories
;(normal-top-level-add-subdirs-to-load-path)

;;Make sure .emacs file is edited in lisp mode
(setq auto-mode-alist (cons '("\.emacs" . lisp-mode) auto-mode-alist))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit (shadow default) :foreground "goldenrod2")))))

;;django templateing stuffs
(load "django-html-mode.el")

;;bmac.el stuff is custom setting of 
;;various libs 

;; one off settings and key assignments
(load "bmac-settings.el")

;;color-theme and fontlock
(load "bmac-font-lock.el")

;;functions I find useful
(load "bmac-functions.el")

;;use hippie expand instead of debbrev
(load "bmac-hippie-expand.el")

(load "bmac-saveplace.el")

;(load "bmac-term.el")

(load "bmac-text-mode.el")

(load "bmac-uniquify.el")

(load "bmac-yasnippet.el")

(load "bmac-ibuffer.el")

;;programing specific stuff
;;(load "bmac-python2.el")

(load "bmac-javascript.el")

(load "starter-kit-lisp.el")

(when (>= emacs-major-version 23)
  (load "bmac-emacs23.el"))

;;use Ctrl tab to switch buffers cleanly
;;(load "crs-bury-buffer.el")

(require 'browse-kill-ring)

;;(load "light-symbol.el")

(require 'anything)
(global-set-key (kbd "M-n") 'anything) 

(load "paren-experiment.el")

(load "bmac-auto-complete.el")

(load "bmac-abbrev-table.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-modules (quote (autojoin button completion fill irccontrols log match menu netsplit noncommands readonly ring scrolltobottom stamp spelling track)))
 '(minimap-width-fraction 0.4)
 '(ns-pop-up-frames nil)
 '(py-cleanup-temporary t)
 '(py-imenu-show-method-args-p t)
 '(py-jython-command-args (quote ("-i" "--no-color-info")))
 '(py-temp-directory "/tmp/emacspython/")
 '(python-mode-hook (quote (turn-on-eldoc-mode py-end-of-defun-function py-beg-of-defun-function)) t)
 '(python-python-command "ipython")
 '(python-remove-cwd-from-path nil))

