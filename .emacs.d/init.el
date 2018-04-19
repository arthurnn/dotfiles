(require 'cl)
;; Remove bars first thing
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Load path etc.
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path (concat dotfiles-dir "/init.d"))
(add-to-list 'load-path (concat dotfiles-dir "/vendor"))

;; setup ENV
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(exec-path-from-shell-copy-env "GOPATH")

;; Custom libs
(autoload 'idomenu "idomenu" t)

;; Setup stuff
(require '01_packages)
(require 'setup-colors)
(require 'setup-ruby)
(require 'setup-go)
(require 'setup-etc)
(require 'setup-erc)
(require 'setup-bindings)
(require 'setup-helm)
(require 'pygmentize)
(require 'darwin)

;; SETTINGS (SYSTEM)
(setq system-type-config (concat dotfiles-dir "init.d/" (symbol-name system-type) ".el"))
(if (file-exists-p system-type-config) (load system-type-config))

(setq host-name (substring (system-name) 0 (string-match "\\." (system-name))))
(setq host-name-config (concat dotfiles-dir "init.d/" host-name ".el"))
(if (file-exists-p host-name-config) (load host-name-config))

(defun wg/kludge-gpg-agent ()
  (if
      (display-graphic-p)
      (setenv "DISPLAY"
              (terminal-name))
    (setenv "GPG_TTY"
            (terminal-name))
    (setenv "DISPLAY")))

(add-hook 'window-configuration-change-hook 'wg/kludge-gpg-agent)
