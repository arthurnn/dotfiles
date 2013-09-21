(require 'cl)
(require 'package)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; install some starter-kits
(defvar my-packages '(starter-kit
                      expand-region
                      gist
                      markdown-mode
                      color-theme
                      color-theme-solarized
                      inf-ruby
                      ruby-block
                      ruby-end
                      ruby-mode
                      rspec-mode
                      ruby-compilation
                      rinari
                      rbenv
                      rvm
                      yaml-mode
                      js2-mode
                      coffee-mode)
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(defun my-install-packages ()
  (unless (my-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs is refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (dolist (p my-packages)
      (unless (package-installed-p p)
        (package-install p)))))

(my-install-packages)

(provide 'my-packages)
