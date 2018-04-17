(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook (lambda ()
                             ;; restore after startup
                             (setq gc-cons-threshold 800000)))

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq-default use-package-always-defer t
              use-package-always-ensure nil)

(setq load-path (cons "~/.emacs.d/vendor/" load-path))
(setq load-path (cons "~/.emacs.d/bmac/" load-path))

;;bmac.el stuff is custom setting of
;;various libs

;;one off settings and key assignments
(load "bmac-settings.el")

;; Eshell config
(load "bmac-eshell.el")

;; modified solarized theme to work in osx terminal app
(load "bmac-theme.el")

;;functions I find useful
(load "bmac-functions.el")

;;use hippie expand instead of debbrev
(load "bmac-hippie-expand.el")

;(load "bmac-javascript.el")

(load "bmac-helm.el")

(custom-set-faces
 '(header-line ((t (:foreground "#8a8a8a" :inverse-video nil))))
 '(helm-candidate-number-suspended ((t nil)))
 '(helm-header ((t nil)))
 '(helm-header-line-left-margin ((t nil)))
 '(helm-match ((t (:background "#d75f00" :foreground "#262626"))))
 '(helm-match-item ((t (:foreground "#262626"))))
 '(helm-selection ((t nil)))
 '(helm-selection-line ((t (:background "#262626" :foreground "#262626"))))
 '(helm-source-header ((t nil))))

;;(load "renpy.el")
