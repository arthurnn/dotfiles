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

;; Custom requires
(mapcar 'require
        '(01_packages
	  growl
	  setup-colors
	  setup-tmux
	  setup-ruby
	  setup-go
	  setup-etc
	  setup-erc
	  shopify-mode))
