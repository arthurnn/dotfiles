(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; install some starter-kits
(defvar my-packages '(starter-kit
                      starter-kit-ruby
                      starter-kit-js
                      starter-kit-bindings
                      rvm
                      yaml-mode
                      coffee-mode
                      gist
                      markdown-mode
                      color-theme
                      color-theme-solarized)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(dolist (p my-packages)
  (require p))
