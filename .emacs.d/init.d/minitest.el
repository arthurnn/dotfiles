(require 'dash)

(defcustom minitest-keymap-prefix (kbd "C-x t")
  "Minitest keymap prefix."
  :group 'minitest
  :type 'string)

(defun minitest-buffer-name (file-or-dir)
  (concat "*Minitest " file-or-dir "*"))

(defun minitest-project-root ()
  "Retrieve the root directory of a project if available.
The current directory is assumed to be the project's root otherwise."
  (or (->> '("Gemfile" "Rakefile")
        (--map (locate-dominating-file default-directory it))
        (-remove #'null)
        (car))
      (error "You're not into a project")))

(defun minitest--file-command (command)
  "Run COMMAND on currently visited file."
  (let ((file-name (buffer-file-name (current-buffer))))
    (if file-name
        (progn
          (setq default-directory (minitest-project-root))
          (compilation-start
           (concat command " " file-name)
           'compilation-mode
           (lambda (arg) (minitest-buffer-name file-name))))
      (error "Buffer is not visiting a file"))))

(defun minitest-file-run ()
  "Run on current file."
  (interactive)
  (minitest--file-command "ruby -I'lib:test'"))

;;; Minor mode
(defvar minitest-mode-map
  (let ((map (make-sparse-keymap)))
    (let ((prefix-map (make-sparse-keymap)))
      (define-key prefix-map (kbd "f") 'minitest-file-run)

      (define-key map minitest-keymap-prefix prefix-map))
    map)
  "Keymap for RuboCop mode.")

;;;###autoload
(define-minor-mode minitest-mode
  "Minor mode to assist project management and navigation.

\\{projectile-mode-map}"
  :lighter " Minitest"
  :keymap minitest-mode-map
  :group 'minitest)

(provide 'minitest)
