(add-hook
 'go-mode-hook
 '(lambda ()
    (make-local-variable 'outline-regexp)
    (setq outline-regexp "//\\.\\|//[^\r\n\f][^\r\n\f]\\|pack\\|func\\|impo\\|cons\\|var[^\r\n\f]\\|type\\|\t\t*[^\r\n\f]\\{4\\}")
    (outline-minor-mode 1)
    (local-set-key "\M-a" 'outline-previous-visible-heading)
    (local-set-key "\M-e" 'outline-next-visible-heading)
    ))

;; helper variable
(defvar hook-go-pkg nil
  "History variable for `go-install-package' and `go-test-package'.")

;; helper function
(defun go ()
  "run current buffer"
  (interactive)
  (compile (concat "go run \"" (buffer-file-name) "\"")))

;; helper function
(defun go-build ()
  "build current buffer"
  (interactive)
  (compile (concat "go build  \"" (buffer-file-name) "\"")))

;; helper function
(defun go-build-dir ()
  "build current directory"
  (interactive)
  (compile "go build ."))

;; helper function
(defun go-fmt-buffer ()
  "run gofmt on current buffer"
  (interactive)
  (if buffer-read-only
    (progn
      (ding)
      (message "Buffer is read only"))
    (let ((p (line-number-at-pos))
          (filename (buffer-file-name))
          (old-max-mini-window-height max-mini-window-height))
      (show-all)
      (if (get-buffer "*Go Reformat Errors*")
          (progn
            (delete-windows-on "*Go Reformat Errors*")
            (kill-buffer "*Go Reformat Errors*")))
      (setq max-mini-window-height 1)
      (if (= 0 (shell-command-on-region (point-min) (point-max) "gofmt" "*Go Reformat Output*" nil "*Go Reformat Errors*" t))
          (progn
            (erase-buffer)
            (insert-buffer-substring "*Go Reformat Output*")
            (goto-char (point-min))
            (forward-line (1- p)))
        (with-current-buffer "*Go Reformat Errors*"
          (progn
            (goto-char (point-min))
            (while (re-search-forward "<standard input>" nil t)
              (replace-match filename))
            (goto-char (point-min))
            (compilation-mode))))
      (setq max-mini-window-height old-max-mini-window-height)
      (delete-windows-on "*Go Reformat Output*")
      (kill-buffer "*Go Reformat Output*"))))

;; helper function
(defun go-fix-buffer ()
  "run gofix on current buffer"
  (interactive)
  (show-all)
  (shell-command-on-region (point-min) (point-max) "go tool fix -diff"))

;; helper function
(defun go-install-package ()
  "install package"
  (interactive)
  (let
      ((pkg (read-from-minibuffer "Install package: " nil nil nil 'hook-go-pkg)))
    (if (not (string= pkg ""))
        (compile (concat "go install \"" pkg "\"")))))

;; helper function
(defun go-test-package ()
  "test package"
  (interactive)
  (let
      ((pkg (read-from-minibuffer "Test package: " nil nil nil 'hook-go-pkg)))
    (if (not (string= pkg ""))
        (compile (concat "go test \"" pkg "\"")))))


(provide 'setup-go)
