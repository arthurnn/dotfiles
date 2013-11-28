;; Remove bars first thing
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Load path etc.
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/init.d"))

;; Default requires
(mapcar 'require
	'(cl
	  saveplace
	  ffap
	  uniquify
	  ansi-color))

;; Custom libs
(require 'growl)
(require 'idomenu)

;; Setup stuff
(mapcar 'require
        '(01_packages
	  setup-colors
	  setup-tmux
	  setup-ruby
	  setup-go
	  setup-etc
	  setup-erc
	  shopify-mode))
