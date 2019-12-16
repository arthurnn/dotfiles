;; Install the following packges:
;;
;; go get -u golang.org/x/tools/cmd/goimports
;; go get -u golang.org/x/tools/cmd/guru
;; go get -u github.com/nsf/gocode
;; go get -u github.com/josharian/impl

(require 'company-lsp)
(push 'company-lsp company-backends)

(add-hook 'go-mode-hook 'go-eldoc-setup)

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
  (local-set-key (kbd "C-c C-j") 'go-guru-definition)
  (local-set-key (kbd "C-c C-b") 'pop-tag-mark)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)

(add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)

(defun coder/go-guru-set-current-package-as-main ()
  "GoGuru requires the scope to be set to a go package which
   contains a main, this function will make the current package the
   active go guru scope, assuming it contains a main"
  (interactive)
  (let* ((filename (buffer-file-name))
         (gopath-src-path (concat (file-name-as-directory (go-guess-gopath)) "src"))
         (relative-package-path (directory-file-name (file-name-directory (file-relative-name filename gopath-src-path)))))
    (setq go-guru-scope relative-package-path)))

(provide 'setup-go)
