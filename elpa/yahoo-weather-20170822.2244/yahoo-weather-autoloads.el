;;; yahoo-weather-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "yahoo-weather" "yahoo-weather.el" (0 0 0 0))
;;; Generated autoloads from yahoo-weather.el

(defvar yahoo-weather-mode nil "\
Non-nil if Yahoo-Weather mode is enabled.
See the `yahoo-weather-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `yahoo-weather-mode'.")

(custom-autoload 'yahoo-weather-mode "yahoo-weather" nil)

(autoload 'yahoo-weather-mode "yahoo-weather" "\
Toggle weather information display in mode line (yahoo-weather information mode).
With a prefix argument ARG, enable yahoo-weather mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "yahoo-weather" '("yahoo-weather-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; yahoo-weather-autoloads.el ends here
