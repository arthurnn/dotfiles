;; Colors ;;

(custom-set-faces
;; Ediff colors
 '(ediff-current-diff-A ((t (:background "black" :foreground "brightyellow"))))
 '(ediff-current-diff-B ((t (:background "black" :foreground "brightyellow"))))
 '(ediff-current-diff-C ((t (:background "black" :foreground "brightyellow"))))
 '(ediff-fine-diff-A ((t (:background "black" :foreground "brightred"))))
 '(ediff-fine-diff-B ((t (:background "black" :foreground "green"))))
 '(ediff-fine-diff-C ((t (:background "black" :foreground "yellow"))))
 '(ediff-even-diff-A ((t (:background "brightblack" :foreground "brightgreen"))))
 '(ediff-even-diff-B ((t (:background "brightblack" :foreground "brightgreen"))))
 '(ediff-even-diff-C ((t (:background "brightblack" :foreground "brightgreen"))))
 '(ediff-odd-diff-A ((t (:background "brightblack" :foreground "brightgreen"))))
 '(ediff-odd-diff-B ((t (:background "brightblack" :foreground "brightgreen"))))
 '(ediff-odd-diff-C ((t (:background "brightblack" :foreground "brightgreen"))))
;; Line number colors
 '(linum ((t (:background "brightblack" :foreground "brightgreen"))))
;; Comment color
 '(font-lock-comment-face ((((class color) (min-colors 8) (background dark)) (:foreground "brightyellow")))))


(defun isearch-face-settings ()
  "Face settings for `isearch'."
  (set-face-foreground 'isearch "white")
  (set-face-background 'isearch "blue")
  (set-face-foreground 'lazy-highlight "black")
  (set-face-background 'lazy-highlight "white")
  (custom-set-faces '(isearch-fail ((((class color)) (:background "red"))))))

(eval-after-load "isearch"
  `(isearch-face-settings))

(provide 'isearch-face-settings)
