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
     (define-key ruby-mode-map (kbd "#") 'ruby-interpolation-insert)
     (define-key ruby-mode-map (kbd "C-c b")
       (λ () (interactive) (async-shell-command "bundle install" "**Bundler**")))))

;; Some custom vars
(custom-set-variables
 '(rspec-use-bundler-when-possible t)
 '(rspec-use-zeus-when-possible t)
)

(provide 'setup-ruby)
