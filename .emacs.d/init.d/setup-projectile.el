(projectile-global-mode t)

(setq projectile-completion-system 'helm)
(helm-projectile-on)

(setq projectile-cache-file (concat dotfiles-dir "projectile.cache"))
(setq projectile-known-projects-file (concat dotfiles-dir "projectile-bookmarks.eld"))
(setq projectile-indexing-method 'alien)

(add-to-list 'projectile-globally-ignored-directories "elpa")
(add-to-list 'projectile-globally-ignored-directories ".cache")
(add-to-list 'projectile-globally-ignored-directories "node_modules")

(setq projectile-use-git-grep t)
;;(setq projectile-enable-caching t) ;; THIS DOESNT WORK !
(setq projectile-completion-system 'grizzl)

(provide 'setup-projectile)
