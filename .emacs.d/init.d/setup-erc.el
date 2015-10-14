;; ERC

;; Freenode.
(setq erc-keywords '("@arthurnn" "@all" "@everyone"))
(setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "#rubyonrails" "#ruby")))

(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))

(defun my-erc-hook (match-type nick message)
  "Shows a growl notification, when user's nick was mentioned. If the buffer is currently not visible, makes it sticky."
  (when (and (eq match-type 'keyword)
             ;; I don't want to see anything from the erc server
             (null (string-match "\\`\\([sS]erver\\|localhost\\)" nick))
             ;; or bots
             (null (string-match "\\(bot\\|serv\\)!" nick))
             ;; or from those who abuse the system
             (null (posix-string-match "^\\** *Users on #" message)))
    (growl
     (concat "ERC: name mentioned on: " (buffer-name (current-buffer)))
     message)))
(add-hook 'erc-text-matched-hook 'my-erc-hook)

;;;###autoload
(defun start-irc ()
  (interactive)
  (config-znc)
  (znc-erc "freenode")
)

;; auto identify
(defun config-znc ()
  (unless (boundp 'znc-password)
    (load-passwords))
  (setq znc-servers `(("apps.arthurnn.com" 5000 nil
		       ((freenode ,"arthurnn" ,znc-password))))))

(provide 'setup-erc)
