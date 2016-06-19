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

(require 'whitespace)
(setq whitespace-display-mappings
 '(
    (space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
    (tab-mark 9 [183 9] [46 9])
    ))
(setq whitespace-style '(face tabs trailing tab-mark space-mark spaces))
(let ((dark (eq 'dark (frame-parameter nil 'background-mode))))
    (set-face-attribute 'whitespace-space nil
                        :foreground (if dark "pink4" "azure3")
                        :background 'unspecified)
    (set-face-attribute 'whitespace-tab nil
                        :foreground "red"
                        :background 'unspecified)
    (set-face-attribute 'whitespace-newline nil
                        :foreground "gray15")
    (set-face-attribute 'whitespace-trailing nil
                        :foreground "red"
                        :background 'unspecified
                        :underline t))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; Disable tab modes, unless in C mode, see bellow
(setq-default indent-tabs-mode nil)

;; Default to c linux style
(add-hook 'c-mode-hook
          (lambda ()
            (setq-default indent-tabs-mode t)
            ))
(setq c-default-style "linux" c-basic-offset 2)
(setq-default tab-width 2)

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
 '(js-indent-level 2)
 '(css-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
 '(web-mode-css-indent-offset 2)
 '(web-mode-code-indent-offset 2)
 ;; changelog vars
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

(defun prelude-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line]
                'prelude-move-beginning-of-line)

(provide 'setup-etc)
