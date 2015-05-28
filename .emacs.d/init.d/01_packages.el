(require 'package)

;; List of packages
(defvar my-packages '(
                      ;Git
                      magit gist git-link
                      ;Misc modes
                      go-mode markdown-mode znc
                      flx-ido grizzl
                      projectile projectile-rails helm helm-projectile
                      ag yasnippet
                      ;Themes
                      color-theme color-theme-solarized zenburn-theme
                      ;Ruby
                      inf-ruby ruby-block ruby-end
                      rubocop rspec-mode minitest
                      flymake-ruby rbenv bundler
                      yaml-mode haml-mode
                      ;Web
                      web-mode js2-mode coffee-mode web-beautify
)  "A list of packages to ensure are installed at launch.")

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;;(add-to-list 'package-archives
;;             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(provide '01_packages)
