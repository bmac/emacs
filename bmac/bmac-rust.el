;; https://github.com/racer-rust/emacs-racer

;; $ rustup toolchain add nightly
;; $ rustup component add rust-src
;; $ cargo +nightly install racer

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'rust-mode-hook #'auto-complete-mode)
(add-hook 'rust-mode-hook #'flycheck-mode)

(add-hook 'flycheck-mode-hook
          (lambda ()
            (flycheck-set-indication-mode 'left-margin)
            (define-key rust-mode-map "\C-ct" 'cargo-process-current-file-tests)
          ))

