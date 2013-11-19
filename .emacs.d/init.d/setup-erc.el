;; ERC
(require 'dash)

;; This causes ERC to connect to the Freenode network upon hitting
;; C-c e f.  Replace MYNICK with your IRC nick.
(global-set-key "\C-cef"
                (lambda () (interactive)
                  (erc :server "irc.freenode.net" :port "6667"
                       :nick "arthurnn")))

;; Join the #emacs and #erc channels whenever connecting to
;; Freenode.
(setq erc-autojoin-channels-alist '(("freenode.net" "#mongoid" "#emacs" "#mongodb")))

(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))

(defun my-erc-hook (match-type nick message)
  "Shows a growl notification, when user's nick was mentioned. If the buffer is currently not visible, makes it sticky."
  (when (and (eq match-type 'keyword)
             ;; I don't want to see anything from the erc server
             (null (string-match "\\`\\([sS]erver\\|localhost\\)" nick))
             ;; or bots
             (null (string-match "\\(bot\\|serv\\)!" nick))
             ;; or from those who abuse the system
             (null (posix-string-match "^\\** *Users on #" message)))
    (growl
     (concat "ERC: name mentioned on: " (buffer-name (current-buffer)))
     message)))
(add-hook 'erc-text-matched-hook 'my-erc-hook)

(defun ted-erc-growl ()
  "Use growl for ERC track change notifications."
  (let* ((buffers (mapcar 'car erc-modified-channels-alist))
         (counts (mapcar 'cadr erc-modified-channels-alist))
         (faces (mapcar 'cddr erc-modified-channels-alist))
         (channels-list (mapcar #'(lambda (buf)
                                 (or (buffer-name buf) ""))
                             buffers)))
    (when (member "#mongoid" channels-list)
      (growl "IRC Activity" "New message on #mongoid"))))

(add-hook 'erc-track-list-changed-hook 'ted-erc-growl)

;; Flowdock

(setq erc-keywords '("@arthurnn" "@all" "@everyone"))

(defun flowdock ()
  (interactive)
  (erc-tls :server "irc.flowdock.com" :port 6697 :nick "arthurnn"))
