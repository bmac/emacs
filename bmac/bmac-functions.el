;; Show an ASCII table
(defun ascii-table ()
  "Show a table of ASCII characters by decimal, hex, and octal value."

  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (let ((min 1) (max 255)
        (special-chars '(
                         (1 . "%c  SOH (start of heading)")
                         (2 . "%c  STX (start of text)")
                         (3 . "%c  ETX (end of text)")
                         (4 . "%c  EOT (end of transmission)")
                         (5 . "%c  ENQ (enquiry)")
                         (6 . "%c  ACK (acknowledge)")
                         (7 . "%c  BEL (bell)")
                         (8 . "%c  BS  (backspace)")
                         (9 . "    TAB (horizontal tab)")
                         (10 . "    LF  (NL line feed, new line)")
                         (11 . "%c  VT  (vertical tab)")
                         (12 . "    FF  (NP form feed, new page)")
                         (13 . "%c  CR  (carriage return)")
                         (14 . "%c  SO  (shift out)")
                         (15 . "%c  SI  (shift in)")
                         (16 . "%c  DLE (data link escape)")
                         (17 . "%c  DC1 (device control 1)")
                         (18 . "%c  DC2 (device control 2)")
                         (19 . "%c  DC3 (device control 3)")
                         (20 . "%c  DC4 (device control 4)")
                         (21 . "%c  NAK (negative acknowledge)")
                         (22 . "%c  SYN (synchronous idle)")
                         (23 . "%c  ETB (end of trans. block)")
                         (24 . "%c  CAN (cancel)")
                         (25 . "%c  EM  (end of medium)")
                         (26 . "%c  SUB (substitute)")
                         (27 . "%c  ESC (escape)")
                         (28 . "%c  FS  (file separator)")
                         (29 . "%c  GS  (group separator)")
                         (30 . "%c  RS  (record separator)")
                         (31 . "%c  US  (unit separator)")
                         (32 . "%c       (space)")
                         (9999)
                         )))
    (insert (format "ASCII characters %d-%d\n\n" min max))
    (insert " Dec   Hex   Oct    Character\n")
    (let ((i 0))
      (while (< i 60)
        (insert "=")
        (setq i (+ i 1))))
    (insert "\n")
    (let ((i min))
      (while (<= i max)
        (let ((line "%4d  0x%02X  %04o    ") (char "%c"))
          (while (> i (car (car special-chars)))
            (setq special-chars (cdr special-chars)))
          (if (= (car (car special-chars)) i)
              (setq char (cdr (car special-chars))))
          (insert (format (concat line char "\n") i i i i))
          (setq i (+ i 1))))))
  (beginning-of-buffer))



;;Indent whole buffer
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


                                        ;Copy-only from M-x all things emacs.
(defun copy-line (&optional arg)
  "Do a kill-line but copy rather than kill. This function directly calls
kill-line, so see documentation of kill-line for how to use it including prefix
argument and relevant variables. This function works by temporarily making the
buffer read-only, so I suggest setting kill-read-only-ok to t."
  (interactive "P")
  (toggle-read-only 1)
  (kill-line arg)
  (toggle-read-only 0))
(setq-default kill-read-only-ok t)
(global-set-key "\C-c\C-k" 'copy-line)


(defun pretty-lambdas ()
  (interactive)
  (font-lock-add-keywords
   nil `(("(?\\(lambda\\>\\)"
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))

(defun recompile-init ()
  "Byte-compile all your dotfiles again"
  (interactive)
  (byte-recompile-directory dotfiles-dir 0))

(defun insert-date ()
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%c" (current-time))))

(defun bmac-smart-advance (point)
  "Advances the point to after the next , ) \" or ; on the current line."
  (interactive "d")
  ;;narrow to line macro
  (push-mark point)
  (save-restriction
    (narrow-to-region (line-beginning-position) (line-end-position))
    ;;search foward till you find a , " ) or ;
    (re-search-forward "[,);\"]")))

(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")
  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))
      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )
      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let
  ;; put the point in the lowest line and return
  (next-line arg))
(global-set-key (kbd "C-d") 'duplicate-line)

(defun set-transparency (n)
  "Sets the transparency of the current buffer. 100 for solid 0 for near see though."
  (interactive "nAlpha (100 for a solid background):")
  (modify-frame-parameters nil (list (cons 'alpha n))))

(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key "\C-a" 'smart-beginning-of-line)

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer
        (delq (current-buffer)
              (remove-if-not 'buffer-file-name (buffer-list)))))


(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

(defun next-10-lines ()
  (next-line 10)
)


(defun open-journal (&optional arg)
  (interactive)
  (find-file
   (concat "~/code/journal/"
           (shell-command-to-string "echo -n $(date +%Y%m%d)")
           ".md")
   ))

(defun open-month-journal (&optional arg)
  (interactive)
  (find-file
   (concat "~/code/journal/"
           (shell-command-to-string "echo -n $(date +%Y-%B)")
           ".md")
   ))

(global-set-key "\C-c\j" 'open-journal)
(global-set-key "\C-c\m" 'open-month-journal)


(defun vim-shell-command (command)
  (interactive (list (read-shell-command "Shell command: ")))
  (suspend-emacs (concat command ";read -n 1 -s -r -p 'Press any key to continue'; fg")))

(defun eslint-disable-macro ()
  (interactive)
  (insert "// eslint-disable-next-line "))
