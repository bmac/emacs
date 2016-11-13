(require `xterm-color)

;; comint install
(progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
       (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))
       (setq font-lock-unfontify-region-function 'xterm-color-unfontify-region))

;; comint uninstall
(progn (remove-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
       (add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
       (setq font-lock-unfontify-region-function 'font-lock-default-unfontify-region))

;; Also set TERM accordingly (xterm-256color)

;; You can also use it with eshell (and thus get color output from system ls):

(require 'eshell)

(add-hook 'eshell-mode-hook
          (lambda ()
            (setq xterm-color-preserve-properties t)))

(add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
(setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))

;;  Don't forget to setenv TERM xterm-256color

(defun curr-dir-git-branch-string (pwd)
  "Returns current git branch as a string, or the empty string if
PWD is not in a git repo (or the git command is not found)."
  (interactive)
  (if (and (eshell-search-path "git")
             (locate-dominating-file pwd ".git"))
      (let ((git-branch (shell-command-to-string (concat "git branch | grep '\\*' | sed -e 's/^\\* //'")))
            (git-commit (shell-command-to-string (concat "git reflog 2> /dev/null | head -n1 | awk '{print $1}'"))))
        (concat
         (propertize " on " 'face `(:foreground "#8A9796"))
         (propertize
          (if (> (length git-branch) 0)
              (substring git-branch 0 -1)
            "no branch")
          'face `(:foreground "#C48FFF"))
         (propertize " at " 'face `(:foreground "#8A9796"))
         (propertize
          (substring git-commit 0 -1)
          'face `(:foreground "#E08821"))
         ))
    ""))


(setq eshell-prompt-function
      (lambda ()
        (concat (propertize (abbreviate-file-name (eshell/pwd)) 'face `(:foreground "#8A9796"))
                (curr-dir-git-branch-string (eshell/pwd))
                (propertize "\n$ " 'face `(:foreground "#8A9796")))))

(setq eshell-prompt-regexp "\$ ")
