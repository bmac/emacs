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
