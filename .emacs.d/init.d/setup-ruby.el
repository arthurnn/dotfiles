(rvm-use-default) ;; use rvm's default ruby for the current Emacs session
;;(add-hook 'ruby-mode-hook
;;          (lambda () (rvm-activate-corresponding-ruby)))
(add-hook 'ruby-mode 'rubocop-mode)

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.builder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . ruby-mode))
;;(require 'haml-mode)
;;(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))


;; remove wierd ruby hash indentation
(setq ruby-deep-indent-paren nil)

;; add a alias, otherwise gist wont open ruby files
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

(defun minitest-run ()
  (interactive)
  (tmux-exec "PARALLEL=true bundle exec rake test")
  (message
   (format "Running tests on tmux %s:%s..." tmux-session-name tmux-window-name))
)

(defun minitest-unit-run ()
  (interactive)
  (tmux-exec "PARALLEL=true bundle exec rake test:units")
  (message
   (format "Running UNIT tests on tmux %s:%s..." tmux-session-name tmux-window-name))
)

(defun minitest-file-run ()
  (interactive)
  (tmux-exec
   (format "bundle exec ruby -Itest %s" buffer-file-name))
  (message
   (format "Running tests on tmux %s:%s..." tmux-session-name tmux-window-name))
)

(defun minitest-file-uniq-run ()
  (interactive)
  (setq str (thing-at-point 'line))

  (when (string-match "test \"\\([^\"]+?\\)\" do" str)
    (setq t2 (concat "test_" (replace-regexp-in-string " " "_" (match-string 1 str)))))

  (when (string-match "def \\([_A-Za-z0-9]+\\)" str)
    (setq t2 (match-string 1 str)))

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

(custom-set-variables
 '(ruby-test-ruby-executables '("ruby"))
)
