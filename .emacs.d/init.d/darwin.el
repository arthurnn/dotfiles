;;; darwin --- darwin
;;; Commentary:
;;; Code:

;; SHARE CLIPBOARD WITH EMACS
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(unless (getenv "TMUX")
  (progn
    (setq interprogram-cut-function 'paste-to-osx)
    (setq interprogram-paste-function 'copy-from-osx)))

(setq browse-url-browser-function
      'browse-url-generic browse-url-generic-program
      "open")

;; mac switch meta key
(setq-default mac-option-modifier '(:ordinary meta :function meta :mouse meta))

(provide 'darwin)
;;; darwin.el ends here
