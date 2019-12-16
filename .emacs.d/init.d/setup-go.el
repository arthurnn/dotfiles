;; Install the following packges:
;;
;; go get -u golang.org/x/tools/cmd/goimports
;; go get golang.org/x/tools/gopls@latest

(require 'company-lsp)
(push 'company-lsp company-backends)

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")

  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)

  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  ; Godef jump key binding
  (local-set-key (kbd "C-c C-j") 'lsp-find-definition)
  (local-set-key (kbd "C-c C-b") 'pop-tag-mark)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)

(add-hook 'go-mode-hook 'lsp-deferred)

(provide 'setup-go)
