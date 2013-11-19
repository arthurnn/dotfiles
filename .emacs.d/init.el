
(add-to-list 'load-path "~/.emacs.d/init.d/")
(load "01_packages")
(require 'growl)


(load "setup-colors")
(load "setup-tmux")
(load "setup-ruby")
(load "setup-go")
(load "setup-etc")
(load "setup-erc")

(require 'shopify-mode)
