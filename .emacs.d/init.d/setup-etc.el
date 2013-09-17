(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)

;; trailing white-spaces before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default whitespace-style (quote
  (face spaces tabs newline space-mark tab-mark newline-mark)))
(setq-default show-trailing-whitespace t)

;; remove annoying auto_fill mode
(auto-fill-mode -1)
(remove-hook 'text-mode-hook 'turn-on-auto-fill)

;; send backup files to its own dir
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
)

(defun delete-grep-header ()
  (save-excursion
    (with-current-buffer grep-last-buffer
      (goto-line 5)
      (narrow-to-region (point) (point-max)))))

(defadvice grep (after delete-grep-header activate) (delete-grep-header))
(defadvice rgrep (after delete-grep-header activate) (delete-grep-header))

;; set markdown default as rdiscount gem
(setq markdown-command "rdiscount")

(defun delete-whitespaces-and-save ()
  (interactive)

  (delete-trailing-whitespace)
  (save-buffer)
)

(global-set-key (kbd "C-c w") 'delete-whitespaces-and-save)
