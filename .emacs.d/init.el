
(add-to-list 'load-path "~/.emacs.d/init.d/")
(load "01_packages")

(load "setup-colors")
(load "setup-tmux")
(load "setup-ruby")
(load "setup-etc")


(require 'minitest)
(require 'shopify-mode)
