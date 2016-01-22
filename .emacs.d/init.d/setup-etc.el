;; Frame title show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " " (:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

;; trailing white-spaces before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(defun turn-off-delete-trailing-whitespace ()
    (remove-hook 'before-save-hook 'delete-trailing-whitespace))
(setq-default whitespace-style (quote
  (face spaces tabs newline space-mark tab-mark newline-mark)))

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)
;; Show tabs
;;(standard-display-ascii ?\t "^I")
;; Disable tabs as indentation
(setq-default indent-tabs-mode nil)

;; send backup files to its own dir
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
)

(defun make-backup-current-file ()
  "Make a backup copy of current file.

The backup file name has the form 「‹name›~‹timestamp›~」, in the same dir. If such a file already exist, it's overwritten.
If the current buffer is not associated with a file, do nothing."
  (interactive)
  (let ((currentFileName (buffer-file-name)) backupFileName)
    (if (file-exists-p currentFileName)
        (progn
          (setq backupFileName (concat currentFileName "~" (format-time-string "%Y%m%d_%H%M%S") "~"))
          (copy-file currentFileName backupFileName t)
          (message (concat "Backup saved as: " (file-name-nondirectory backupFileName)))
          )
      (progn ; file doesn't exist happens when it's new file not yet saved.
        (message (format "file 「%s」 doesn't exist." currentFileName)) ) ) ) )

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

;; turnoff encoding magic
(setq ruby-insert-encoding-magic-comment nil)

;; ido mode
(ido-mode t)
(ido-everywhere t)
(flx-ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil) ;; disable ido faces to see flx highlights.

;; Modes for file extensions
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.sass$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.js\\(on\\)?$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


;; custom vars
(custom-set-variables
 '(coffee-tab-width 2)
 '(css-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-code-indent-offset 2)                                                                                                                                  ;; changelog vars
 '(add-log-full-name "Arthur Neves")
 '(add-log-mailing-address "arthurnn@gmail.com")
 '(change-log-default-name "CHANGELOG.md"))

(defun xah-syntax-color-hex ()
"Syntax color hex color spec such as 「#ff1100」 in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer))
(add-hook 'css-mode-hook 'xah-syntax-color-hex)
(add-hook 'php-mode-hook 'xah-syntax-color-hex)
(add-hook 'html-mode-hook 'xah-syntax-color-hex)

;; Scratch
(setq initial-scratch-message nil)

;; org-mode
(setq org-directory "~/Dropbox/org")
(setq org-agenda-files '("~/Dropbox/org"))
(setq org-mobile-inbox-for-pull "~/Dropbox/org/inbox.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;; Monkey-patch git-link
(eval-after-load "git-link"
  '(defun git-link-new (link)
     (kill-new link)
     (message link)))

;; yasnippet config
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)

(defun volatile-kill-buffer ()
  "Kill current buffer unconditionally."
  (interactive)
  (let ((buffer-modified-p nil))
    (kill-buffer (current-buffer))))

(defun save-and-kill ()
  (interactive)
  (save-buffer)
  (volatile-kill-buffer))

(global-set-key (kbd "C-c C-n") 'save-and-kill)


(provide 'setup-etc)
