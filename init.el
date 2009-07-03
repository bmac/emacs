;; Set the load path
(setq load-path (cons "~/.emacs.d/" load-path))
(setq load-path (cons "~/.emacs.d/vendor/" load-path))
(setq load-path (cons "~/.emacs.d/bmac/" load-path))
;; Include subdirectories
(normal-top-level-add-subdirs-to-load-path)

;;Make sure .emacs file is edited in lisp mode
(setq auto-mode-alist (cons '("\.emacs" . lisp-mode) auto-mode-alist))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "white"))))
 '(linum ((t (:inherit (shadow default) :background "color-239" :foreground "goldenrod2")))))

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

(load "bmac-term.el")

(load "bmac-text-mode.el")

(load "bmac-uniquify.el")

(load "bmac-yasnippet.el")

;;programing specific stuff
(load "bmac-python.el")

(load "bmac-javascript.el")

(when (>= emacs-major-version 23)
  (load "bmac-emacs23.el")
  )

;;(global-hl-line-mode 1)
 
;; To customize the background color
;;(set-face-background 'hl-line "color-235")  
;;(set-face-foreground 'highlight nil) 
;;(set-face-foreground 'hl-line nil)

;;use Ctrl tab to switch buffers cleanly
(load "crs-bury-buffer.el")

(require 'browse-kill-ring)

(load "light-symbol.el")

