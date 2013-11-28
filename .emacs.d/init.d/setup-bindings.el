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

;; git status
(global-set-key (kbd "C-x g") 'magit-status)

(provide 'setup-bindings)
