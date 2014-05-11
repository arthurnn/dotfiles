;;; pygmentize.el --- An Emacs set of functions to use pygmentize within emacs

;; Copyright © 2014 Arthur Nogueira Neves

;; Author: Arthur Neves
;; URL:
;; Version: 0.0.1

;; This file is NOT part of GNU Emacs.

;;; Code:

(defun pygmentize ()
  (interactive)
  (let ((code (buffer-substring (region-beginning) (region-end))))
    (kill-new
	   (shell-command-to-string (format "echo \"%s\" | pygmentize -f rtf -O \"style=emacs,fontface=Menlo\" -l $(pygmentize -N %s)" code buffer-file-name)))
))
(provide 'pygmentize)
