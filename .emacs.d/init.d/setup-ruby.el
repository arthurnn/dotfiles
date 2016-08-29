(require 'bundler)
(require 'minitest)
(require 'rspec-mode)
(require 'chruby)

(require 'smartparens-config)
(add-hook 'ruby-mode-hook #'smartparens-mode)

;; add projectile on rails
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; add rubocop - Ruby static code analyzer
(add-hook 'ruby-mode-hook 'rubocop-mode)

;; turn off auto-fill
(add-hook 'ruby-mode-hook 'turn-off-auto-fill)

;; add flymake syntax check
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

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
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

;; remove wierd ruby hash indentation
(setq ruby-deep-indent-paren nil)

;; add a alias, otherwise gist wont open ruby files
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

(defun ruby-erb-t ()
  "Called when interpolation key is pressed"
  (interactive)
  (insert "<%=t '' %>")
  (backward-char 4)
)
(global-set-key (kbd "C-c r t") 'ruby-erb-t)

(defun ruby-interpolation-insert ()
  "Called when interpolation key is pressed"
  (interactive)
  (insert "#")
  (when (and
         (looking-back "\".*")
         (looking-at ".*\""))
    (insert "{}")
    (backward-char 1)))

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "#") 'ruby-interpolation-insert)))

(defun rails-test-ar-conn(db)
  (interactive
   (list (ido-completing-read "Which section to modified: " '("mysql2" "sqlite3" "postgresql"))))
  (setenv "ARCONN" db))

;; Some custom vars
(custom-set-variables
 '(rspec-use-bundler-when-possible t)
 '(rspec-use-zeus-when-possible t)
)

;; Avoid conflicts with rspec-mode
(add-hook 'minitest-mode-hook (lambda () (rspec-verifiable-mode -1)))

(setq safe-local-variable-values
      '((minitest-use-bundler . nil)
        (minitest-use-zeus-when-possible . nil)
        (minitest-default-command . ("bin/testrb_or_zt"))))

;; Install snippets
(eval-after-load 'minitest
  '(minitest-install-snippets))

(provide 'setup-ruby)
