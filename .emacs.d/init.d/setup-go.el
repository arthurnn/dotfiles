;; Install the following packges:
;;
;; go get github.com/syohex/emacs-go-eldoc
;; go get github.com/nsf/gocode
;; go get golang.org/x/tools/cmd/goimports
;; go get golang.org/x/tools/cmd/guru

(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

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
