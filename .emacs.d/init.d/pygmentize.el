
(defun pygmentize ()
  (interactive)
  (let ((code (buffer-substring (region-beginning) (region-end))))
    (kill-new
	   (shell-command-to-string (format "echo \"%s\" | pygmentize -f rtf -O \"style=emacs,fontface=Menlo\" -l $(pygmentize -N %s)" code buffer-file-name)))
))
(provide 'pygmentize)
