(defun github--customize ()
  (setq 'minitest-use-bundler nil)
  (setq 'minitest-default-command '("bin/testrb")))

(add-hook 'ruby-mode-hook 'minitest-mode)

(defun github--label ()
  (let* ((string ""))
    (concat "GitHub" " 🍺  ")))

;;; Minor mode
(defvar github-mode-map
  (let ((map (make-sparse-keymap)))
    (let ((prefix-map (make-sparse-keymap)))
      (define-key map (kbd "C-c") prefix-map))
    map)
  "Keymap for GitHub mode.")

;;;###autoload
(defun github--buffer-is-github-p ()
  (let ((file-name (buffer-file-name (current-buffer))))
    (and file-name
         (numberp (string-match "\\/src\\/github\\/" file-name)))))

(defvar github-old-car-mode-line-position nil)

;;;###autoload
(define-minor-mode github-mode
  "GitHub mode for basic setup of github-core source-code"
  :group 'github
  :keymap github-mode-map
  (if github-mode
      (progn
        (unless github-old-car-mode-line-position
          (setq github-old-car-mode-line-position (car mode-line-position)))
        (setcar mode-line-position '(:eval (list (github--label))))
        (minitest-mode 1)
        (github--customize)
        (message "Github enabled"))
    (progn
      (setcar mode-line-position github-old-car-mode-line-position)
      )))

;;;###autoload
(defun enable-github-mode ()
  (if (github--buffer-is-github-p)
      (github-mode)
    (github-mode 0)))

;;;###autoload
(add-hook 'ruby-mode-hook 'enable-github-mode)

(provide 'github-mode)
