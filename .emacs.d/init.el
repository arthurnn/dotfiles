(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))


;; install some starter-kits
(defvar my-packages '(starter-kit starter-kit-ruby starter-kit-js starter-kit-bindings)
  "A list of packages to ensure are installed at launch.")
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)

;; trailing white-spaces before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; remove annoying auto_fill mode
(defun my-html-mode-hook ()
  (auto-fill-mode -1))
(add-hook 'html-mode-hook 'my-html-mode-hook)
