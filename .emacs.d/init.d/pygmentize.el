
(defun pygmentize ()
  (interactive)
  (let ((code (buffer-substring (region-beginning) (region-end))))
    (kill-new
	   (shell-command-to-string (format "echo \"%s\" | /usr/local/bin/pygmentize -f rtf -O \"style=emacs,fontface=Menlo\" -l html" code)))
))
(provide 'pygmentize)
