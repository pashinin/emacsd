;;; init-server  --- description
;;; Commentary:
;;; Code:

;; start server
;;-----------------------------
;; On windows you must have "server" folder in .emacs.d and be it's
;; owner (properties->security->advanced) or you'll have error:
;; http://stackoverflow.com/questions/5233041/emacs-and-the-server-unsafe-error
;; better run Emacs as daemon and do not use server-start
;;(if (and (fboundp 'server-running-p)  ;; if we can check server is started
;;         (not (server-running-p)))

(require 'server)

;; maybe on GNU/Linux:
;;(when (and (server-running-p)
;;           (window-system))
;;	  ;;(kill-emacs)
;;	  )

;; error: The directory `~/.emacs.d/server' is unsafe
;; 1. Create dir "~/.emacs.d/server"
;; 2. change owner to yourself
(let ((start t))
  (when (eq system-type 'windows-nt)
    (let ((d (file-truename "~/.emacs.d/server")))
      (unless (file-directory-p d) (make-directory d))   ; create "~/.emacs.d/server" dir
      (setq start (= (shell-command (concat "icacls " d " /setowner " (user-login-name) " /T /C"))
                     0))
      ))
  (if start (unless (server-running-p) (server-start))))

(provide 'init-server)
;;; init-server.el ends here
