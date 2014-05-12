(require 'cl)
;; Remove bars first thing
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; PATH var
(add-to-list 'exec-path "/usr/local/bin")

;; Load path etc.
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path (concat dotfiles-dir "/init.d"))

;; Custom libs
(autoload 'growl "growl" t)
(autoload 'idomenu "idomenu" t)

;; Setup stuff
(require '01_packages)
(require 'setup-colors)
(require 'setup-tmux)
(require 'setup-ruby)
(require 'setup-go)
(require 'setup-etc)
(autoload 'setup-erc "setup-erc" t)
(require 'setup-bindings)
;;(autoload 'shopify-mode "shopify-mode" t)
(require 'shopify-mode)
(require 'pygmentize)

;; SETTINGS (SYSTEM)
(setq system-type-config (concat dotfiles-dir (symbol-name system-type) ".el"))
(if (file-exists-p system-type-config) (load system-type-config))

(setq host-name (substring (system-name) 0 (string-match "\\." (system-name))))
(setq host-name-config (concat dotfiles-dir host-name ".el"))
(if (file-exists-p host-name-config) (load host-name-config))
