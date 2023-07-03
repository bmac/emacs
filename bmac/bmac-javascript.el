;(require 'mocha)

(setq mocha-command "time node_modules/.bin/mocha"
 mocha-environment-variables "BUILD_ENV=qa NODE_ENV=test"
 mocha-options "--colors --compilers js:babel-core/register --require tests/utils/jsdom-setup.js --require tests/utils/shim-webpack-require.js --watch"
 mocha-reporter "spec"
 mocha-which-node ""
 sgml-basic-offset 4
 css-indent-offset 4)

(setq compilation-scroll-output t)

;; Do not pompt before killing process buffers
(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

(defun react-close-tag ()
  (interactive)
  (funcall ;; Toggle modes.
   (prog1 major-mode
     (sgml-mode)
     (sgml-close-tag))))


(use-package tree-sitter
  :ensure t
  :config
  ;; activate tree-sitter on any buffer containing code for which it has a parser available
  (global-tree-sitter-mode)
  ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
  ;; by switching on and off
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

(use-package typescript-mode
  ;; :after tree-sitter
  :mode ("\\.(t|j)sx?\\'" . typescript-mode)
  :hook (typescript-mode . lsp-deferred)
  :init (add-hook 'typescript-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil `(("\\(function\\)"
                          (0 (progn (compose-region (match-beginning 1)
                                                    (match-end 1) "\u0192")
                                    nil)))))))
  :config
  (require 'mocha)
  (define-key typescript-mode-map "\C-c/" 'react-close-tag)
  (define-key typescript-mode-map "\C-cd" 'duplicate-line)
  (define-key typescript-mode-map "\C-ct" 'smart-test-file)
  (define-key typescript-mode-map "\C-ct" 'mocha-test-file)
  )
