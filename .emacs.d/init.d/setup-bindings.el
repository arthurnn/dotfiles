;; Bindings file

;; FIX SHIFT-UP ?!
;; from http://stackoverflow.com/questions/10871745/shift-up-arrow-doesnt-highlight-text-emacs-iterm2
(define-key input-decode-map "\e[1;2A" [S-up])
(if (equal "xterm" (tty-type)) (define-key input-decode-map "\e[1;2A" [S-up]))

;; SWITCH WINDOWS
(windmove-default-keybindings)
(global-set-key [M-up]      'windmove-up)
(global-set-key [M-down]    'windmove-down)
(global-set-key [M-left]    'windmove-left)
(global-set-key [M-right]   'windmove-right)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'idomenu)

;; git status
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-g") 'projectile-grep)

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)
;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

(provide 'setup-bindings)
