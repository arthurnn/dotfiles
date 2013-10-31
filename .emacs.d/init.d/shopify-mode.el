
(defun shopify-whitespaces-and-save ()
  (interactive)
  (delete-trailing-whitespace)
  (save-buffer))

(defun shopify-create ()
  (let* ((outerspace-string ""))
    (rspec-mode -1)
    (rspec-verifiable-mode -1)
    (minitest-mode)
    (remove-hook 'before-save-hook 'delete-trailing-whitespace)
    (concat "Shopify"
            " 🍺  ")))

;;; Minor mode
(defvar shopify-mode-map
  (let ((map (make-sparse-keymap)))
    (let ((prefix-map (make-sparse-keymap)))
      (define-key prefix-map (kbd "w") 'shopify-whitespaces-and-save)

      (define-key map (kbd "C-c") prefix-map))
    map)
  "Keymap for RuboCop mode.")

(defvar shopify-old-car-mode-line-position nil)

;;;###autoload
(define-minor-mode shopify-mode
  "Shopify mode for basic setup of shopify source-code"
  :group 'shopify
  :keymap shopify-mode-map
  (if shopify-mode
      (progn
        (unless shopify-old-car-mode-line-position
          (setq shopify-old-car-mode-line-position (car mode-line-position)))
        (setcar mode-line-position '(:eval (list (shopify-create)))))
    (setcar mode-line-position shopify-old-car-mode-line-position)))

(provide 'shopify-mode)
