(setq use-package-compute-statistics t)
(setq gc-cons-threshold 64000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

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

(load "bmac-lsp.el")

(load "bmac-javascript.el")

(load "bmac-rust.el")

(load "bmac-helm.el")

(savehist-mode t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:foreground "red" :underline t))))
 '(header-line ((t (:foreground "#8a8a8a" :inverse-video nil))))
 '(helm-candidate-number-suspended ((t nil)))
 '(helm-header ((t nil)))
 '(helm-header-line-left-margin ((t nil)))
 '(helm-match ((t (:background "#d75f00" :foreground "#262626"))))
 '(helm-match-item ((t (:foreground "#262626"))))
 '(helm-selection ((t nil)))
 '(helm-selection-line ((t (:background "#262626" :foreground "#262626"))))
 '(helm-source-header ((t nil))))

;; (load "renpy.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-fringe-indicator-position 'left-fringe)
 '(helm-ag-ignore-patterns '("node_modules" "cache" ".log"))
 '(helm-ag-insert-at-point 'symbol)
 '(mocha-command "time node_modules/.bin/mocha" t)
 '(mocha-environment-variables "NODE_ENV=test" t)
 '(mocha-options "--watch --require ./test/setup.js" t)
 '(mocha-reporter "spec" t)
 '(package-selected-packages
   '(typescript-mode helm lsp-mode lsp-ui rustic flycheck flycheck-rust
                     company helm-ag mocha use-package
                     color-theme-solarized markdown-mode
                     github-browse-file git-gutter-fringe diminish)))
