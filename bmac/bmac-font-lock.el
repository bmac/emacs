
;;color the code
(require 'font-lock)
(global-font-lock-mode t)

;;Use color theme from:
;;http://www.emacswiki.org/cgi-bin/wiki?ColorTheme
(require 'color-theme)
(color-theme-initialize)
(load "color-theme-tango.el")
(color-theme-tango)
