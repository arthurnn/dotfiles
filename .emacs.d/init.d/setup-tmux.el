(setq tmux-session-name
 (substring
  (shell-command-to-string "tmux list-panes -F '#{session_name}'")
  0 -1))
(setq tmux-window-name 2)
(setq tmux-pane-number 0)

(defun tmux-exec (command)
  "Execute command in tmux"
  (interactive)
  (shell-command
   (format "tmux send-keys -t %s:%s.%s '%s' Enter" tmux-session-name tmux-window-name tmux-pane-number command)))

(defun tmux-setup (x y z)
  "Setup global variables for tmux session, window, and pane"
  (interactive "sEnter tmux session name: \nsEnter tmux window name: \nsEnter tmux pane number: ")
  (setq tmux-session-name x)
  (setq tmux-window-name y)
  (setq tmux-pane-number z)
  (message "Tmux Setup, session name: %s, window name: %s, pane number: %s" tmux-session-name tmux-window-name tmux-pane-number))

(defun tmux-print-session-name ()
  (interactive)
  (message tmux-session-name))

(provide 'setup-tmux)
