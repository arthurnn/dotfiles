;; Bindings file

;; FIX SHIFT-UP
;; from http://stackoverflow.com/questions/10871745/shift-up-arrow-doesnt-highlight-text-emacs-iterm2
;; and http://lists.gnu.org/archive/html/help-gnu-emacs/2011-05/msg00211.html
(define-key input-decode-map "\e[1;2A" [S-up])
(if (equal "xterm" (tty-type))
    (define-key input-decode-map "\e[1;2A" [S-up]))
(defadvice terminal-init-xterm (after select-shift-up activate)
  (define-key input-decode-map "\e[1;2A" [S-up]))

;; Navigation
;; SWITCH WINDOWS
(windmove-default-keybindings)
(global-set-key [M-up]      'windmove-up)
(global-set-key [M-down]    'windmove-down)
(global-set-key [M-left]    'windmove-left)
(global-set-key [M-right]   'windmove-right)

;; This wont work =/
;;(global-set-key (kbd "M-]")      'forward-paragraph)
;;(global-set-key (kbd "M-[")      'backward-paragraph)

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

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c l") 'org-store-link)

(provide 'setup-bindings)
