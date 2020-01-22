;; Install the following packges:
;;
;; go get -u golang.org/x/tools/cmd/goimports
;; go get golang.org/x/tools/gopls@latest

(require 'company-lsp)
(push 'company-lsp company-backends)

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")

  (setq go-test-verbose 1)

  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)

  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  ;; Godef jump key binding
  (local-set-key (kbd "C-c C-j") 'lsp-find-definition)
  (local-set-key (kbd "C-c C-b") 'pop-tag-mark)
  ;; go-test
  (local-set-key (kbd "C-c , a") 'go-test-current-project)
  (local-set-key (kbd "C-c , v") 'go-test-current-file)
  (local-set-key (kbd "C-c , s") 'go-test-current-test)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)

(add-hook 'go-mode-hook 'lsp-deferred)


(global-set-key (kbd "C-x ,") 'split-window-below)


(provide 'setup-go)
