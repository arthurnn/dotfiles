(rvm-use-default) ;; use rvm's default ruby for the current Emacs session
(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))


;; remove wierd ruby hash indentation
(setq ruby-deep-indent-paren nil)

;; add a alias, otherwise gist wont open ruby files
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

(defun ruby--jump-to-test ()
  (find-file
   (replace-regexp-in-string
    "/lib/" "/test/"
    (replace-regexp-in-string
     "/\\([^/]+\\).rb$" "/test_\\1.rb"
     (buffer-file-name)))))

(defun ruby--jump-to-lib ()
  (find-file
   (replace-regexp-in-string
    "/test/" "/lib/"
    (replace-regexp-in-string
     "/test_\\([^/]+\\).rb$" "/\\1.rb"
     (buffer-file-name)))))

(defun ruby-jump-to-other ()
  (interactive)
  (if (string-match-p "/test/" (buffer-file-name))
      (ruby--jump-to-lib)
    (ruby--jump-to-test)))

;;(define-key ruby-mode-map (kbd "C-c t") 'ruby-jump-to-other)

(defun minitest-run ()
  (interactive)
  (tmux-exec "PARALLEL=true bundle exec rake test")
  (message
   (format "Running tests on tmux %s:%s..." tmux-session-name tmux-window-name)))

(defun minitest-unit-run ()
  (interactive)
  (tmux-exec "PARALLEL=true bundle exec rake test:units")
  (message
   (format "Running UNIT tests on tmux %s:%s..." tmux-session-name tmux-window-name)))

(defun minitest-file-run ()
  (interactive)
  (tmux-exec
   (format "bundle exec ruby -Itest %s" buffer-file-name))
  (message
   (format "Running tests on tmux %s:%s..." tmux-session-name tmux-window-name)))

(defun minitest-file-uniq-run ()
  (interactive)
  (setq str (thing-at-point 'line))

  (string-match "test \"\\([^\"]+?\\)\" do" str)
  (setq test_region (match-string 1 str) )

  (setq t2
        (concat "test_"
                (replace-regexp-in-string " " "_" test_region)))
  (tmux-exec
   (format "bundle exec ruby -Itest %s -n\"%s\"" buffer-file-name t2))
  (message
   (format "Running tests %s on tmux %s:%s..." t2 tmux-session-name tmux-window-name))
)

(define-prefix-command 'ring-tests)
(global-set-key (kbd "C-x t") 'ring-tests)
(define-key ring-tests (kbd "a") 'minitest-run)
(define-key ring-tests (kbd "u") 'minitest-unit-run)
(define-key ring-tests (kbd "f") 'minitest-file-run)
(define-key ring-tests (kbd "n") 'minitest-file-uniq-run)
