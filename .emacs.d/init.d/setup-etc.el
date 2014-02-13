;; Frame title show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " " (:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

;; Git mode
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")))

;; trailing white-spaces before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(defun turn-off-delete-trailing-whitespace ()
    (remove-hook 'before-save-hook 'delete-trailing-whitespace))
(setq-default whitespace-style (quote
  (face spaces tabs newline space-mark tab-mark newline-mark)))
(setq-default show-trailing-whitespace t)

;; send backup files to its own dir
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
)
;; turn off recentf
(recentf-mode -1)

;; Grep stuff
(defun delete-grep-header ()
  (save-excursion
    (with-current-buffer grep-last-buffer
      (goto-line 5)
      (narrow-to-region (point) (point-max)))))

(defadvice grep (after delete-grep-header activate) (delete-grep-header))
(defadvice rgrep (after delete-grep-header activate) (delete-grep-header))
(eval-after-load "grep"
  '(progn
     ;; Don't recurse into some directories
     (add-to-list 'grep-find-ignored-directories ".bundle" "vendor")
))

(defun load-passwords ()
  (interactive)
  (load-library "passwords.el.gpg"))

;; set markdown default as rdiscount gem
(setq markdown-command "rdiscount")
(add-hook 'markdown-mode-hook 'turn-off-delete-trailing-whitespace)

;; ido-mode is like magic pixie dust!
(ido-mode t)
(ido-ubiquitous-mode)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)
;; ido mode on M-x
(global-set-key
 "\M-x"
 (lambda ()
   (interactive)
   (call-interactively
    (intern
     (ido-completing-read
      "M-x "
      (all-completions "" obarray 'commandp))))))

;; Modes for file extensions
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.js\\(on\\)?$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))

;; custom vars
(custom-set-variables
 '(coffee-tab-width 4)
 '(css-indent-offset 2)
 ;; changelog vars
 '(add-log-full-name "Arthur Neves")
 '(add-log-mailing-address "arthurnn@gmail.com")
 '(change-log-default-name "CHANGELOG.md")
)

(provide 'setup-etc)
