(require 'package)

;; List of packages
(defvar my-packages '(
                      ;Git
                      magit gist git-link
                      ;Misc modes
                      lsp-mode lsp-ui company-lsp flycheck
                      markdown-mode rust-mode
                      znc
                      flx-ido grizzl
                      helm helm-git-grep
                      ag yasnippet
                      smartparens
                      expand-region
                      org-pomodoro
                      ;GO
                      go-mode gotest golint
                      ;Ruby
                      inf-ruby
                      minitest
                      yaml-mode haml-mode
                      ;Web
                      web-mode js2-mode coffee-mode web-beautify
)  "A list of packages to ensure are installed at launch.")

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

;;(add-to-list 'package-archives
;;             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(provide '01_packages)
