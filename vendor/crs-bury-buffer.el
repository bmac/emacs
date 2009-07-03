;; ctrl tab to burry buffer from http://www.emacswiki.org/emacs/ControlTABbufferCycling
    ; necessary support function for buffer burial
    (defun crs-delete-these (delete-these from-this-list)
      "Delete DELETE-THESE FROM-THIS-LIST."
      (cond
       ((car delete-these)
        (if (member (car delete-these) from-this-list)
            (crs-delete-these (cdr delete-these) (delete (car delete-these)
                                                     from-this-list))
          (crs-delete-these (cdr delete-these) from-this-list)))
       (t from-this-list)))

    ; this is the list of buffers I never want to see
    (defvar crs-hated-buffers
      '("KILL" "*Apropos*" "*Completions*" "*grep*"
                                ".newsrc-dribble" ".bbdb" "sent-mail" "*vc*"
                               "*Compile-Log*" "*Help*" "*Messages*" "*Pymacs*"))

    (defun crs-hated-buffers ()
      "List of buffers I never want to see, converted from names to buffers."
      (delete nil
              (append
               (mapcar 'get-buffer crs-hated-buffers)
               (mapcar (lambda (this-buffer)
                         (if (string-match "^ " (buffer-name this-buffer))
                             this-buffer))
                       (buffer-list)))))

    ; I'm sick of switching buffers only to find KILL right in front of me
    (defun crs-bury-buffer (&optional n)
      (interactive)
      (unless n
        (setq n 1))
      (let ((my-buffer-list (crs-delete-these (crs-hated-buffers)
                                              (buffer-list (selected-frame)))))
        (switch-to-buffer
         (if (< n 0)
             (nth (+ (length my-buffer-list) n)
                  my-buffer-list)
           (bury-buffer)
           (nth n my-buffer-list)))))

    (global-set-key (kbd "C-<tab>") 'crs-bury-buffer)
    (global-set-key (kbd "C-M-<tab>") (lambda ()
                                           (interactive)
                                           (crs-bury-buffer -1)))