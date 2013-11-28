(add-to-list 'load-path "~/.emacs.d/init.d/")

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
