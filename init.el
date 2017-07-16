;; Set the load path
;;(setq load-path (cons "~/.emacs.d/" load-path))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

;; Eshell config
(load "bmac-eshell.el")

;; modified solarized theme to work in osx terminal app
(load "bmac-theme.el")

;;functions I find useful
(load "bmac-functions.el")

;;use hippie expand instead of debbrev
(load "bmac-hippie-expand.el")

(load "bmac-javascript.el")

(require 'browse-kill-ring)

(load "bmac-abbrev-table.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(js-indent-level 2)
 '(js-switch-indent-offset 2)
 '(js2-indent-switch-body t)
 '(js2-strict-inconsistent-return-warning nil)
 '(js2-strict-missing-semi-warning nil)
 '(js2-strict-trailing-comma-warning nil)
 '(jsx-indent-level 2)
 '(mocha-command "time node_modules/.bin/mocha")
 '(mocha-environment-variables "BUILD_ENV=qa NODE_ENV=test")
 '(mocha-options
   "--colors --compilers js:babel-core/register --require tests/utils/jsdom-setup.js --require tests/utils/shim-webpack-require.js --watch")
 '(mocha-reporter "spec")
 '(mocha-which-node "")
 '(package-selected-packages
   (quote
    (shell-pop magit typescript-mode moe-theme fancy-battery smart-mode-line better-shell xterm-color rjsx-mode eslint-fix js2-mode xref-js2 yaml-mode stylus-mode projectile pabbrev neotree markdown-mode github-browse-file git-gutter-fringe flx-ido find-file-in-repository discover-js2-refactor color-theme-solarized browse-kill-ring)))
 '(sgml-basic-offset 2)
 '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
 '(shell-pop-window-size 22)
 '(solarized-termcolors 256)
 '(xref-js2-definitions-regexps
   (quote
    ("\\b%s\\b[\\s]*[:=][^=]" "function[\\s]+\\b%s\\b" "^ +\\b%s([a-zA-Z, ]*) {$")))
 '(xref-js2-ignored-files (quote ("*.min.js" "*-test.js"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq create-lockfiles nil)

(require 'fancy-battery)
(fancy-battery-mode)
(smart-mode-line-enable)
(load "renpy.el")
