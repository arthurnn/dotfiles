(rvm-use-default) ;; use rvm's default ruby for the current Emacs session
(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

;; add rubocop - Ruby static code analyzer
(add-hook 'ruby-mode-hook 'rubocop-mode)

;; turn off auto-fill
(add-hook 'ruby-mode-hook 'turn-off-auto-fill)

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.builder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))
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

(define-prefix-command 'ring-tests)
(global-set-key (kbd "C-x t") 'ring-tests)
(define-key ring-tests (kbd "a") 'minitest-run)
(define-key ring-tests (kbd "n") 'minitest-file-uniq-run)

(custom-set-variables
 '(rspec-use-bundler-when-possible t)
 '(rspec-use-rvm t)
 '(rspec-use-zeus-when-possible t)
)
