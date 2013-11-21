;; the toolbar is just a waste of valuable screen estate
;; in a tty tool-bar-mode does not properly auto-load, and is
;; already disabled anyway
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; the menu bar is mostly useless as well
;; but removing it under OS X doesn't make much sense
(defun my-frame-config (frame)
  "Custom behaviours for new frames."
  (if (eq system-type 'darwin)
      (with-selected-frame frame
        (if (display-graphic-p)
            (modify-frame-parameters frame '((menu-bar-lines . 1)))
          (modify-frame-parameters frame '((menu-bar-lines . 0)))))
    (menu-bar-mode -1)))
(my-frame-config (selected-frame))
(add-hook 'after-make-frame-functions 'my-frame-config)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Frame title show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " " (:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

;;(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)

;; trailing white-spaces before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(defun turn-off-delete-trailing-whitespace ()
    (remove-hook 'before-save-hook 'delete-trailing-whitespace))
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
(recentf-mode -1)

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
     (add-to-list 'grep-find-ignored-directories ".bundle" ".vendor")
))

;; set markdown default as rdiscount gem
(setq markdown-command "rdiscount")
(add-hook 'markdown-mode-hook 'turn-off-delete-trailing-whitespace)
