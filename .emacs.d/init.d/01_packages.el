(when (< emacs-major-version 24)
  (require 'package))

;; List of packages
(defvar my-packages '(
                      ;Git
                      magit mo-git-blame gist
                      ; Misc modes
                      go-mode markdown-mode ido-ubiquitous znc
                      ;Themes
                      color-theme color-theme-solarized
                      ;Ruby
                      ruby-mode inf-ruby ruby-block ruby-end
		      rubocop rspec-mode minitest yaml-mode haml-mode
		      flymake-ruby rbenv
                      ;JS
                      js2-mode coffee-mode
)  "A list of packages to ensure are installed at launch.")

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(provide '01_packages)
