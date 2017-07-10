;; Colors ;;
(require 'atom-one-dark-theme)

(load-theme 'atom-one-dark t)

(let ((dark (eq 'dark (frame-parameter nil 'background-mode))))
    (set-face-attribute 'whitespace-space nil
                        :foreground (if dark "pink4" "azure3")
                        :background 'unspecified)
    (set-face-attribute 'whitespace-tab nil
                        :foreground "red"
                        :background 'unspecified)
    (set-face-attribute 'whitespace-newline nil
                        :foreground "gray15")
    (set-face-attribute 'whitespace-trailing nil
                        :foreground "red"
                        :background 'unspecified
                        :underline t))

(provide 'setup-colors)
