;;; init-mail --- Work with mail
;;; Commentary:
;;; Code:

;; Configure Outbound Mail
;; Tell the program who you are
(setq user-full-name my-name-full)
(setq user-mail-address my-mail-1)

;; Tell Emacs to use GNUTLS instead of STARTTLS to authenticate when
;; sending mail.
(setq starttls-use-gnutls t)

;; Tell Emacs about your mail server and credentials
(require 'smtpmail)
(setq send-mail-function 'smtpmail-send-it
	  message-send-mail-function 'smtpmail-send-it
	  smtpmail-starttls-credentials
	  '((my-domain1 587 nil nil))
	  smtpmail-auth-credentials
	  (expand-file-name "~/.authinfo.gpg")
	  smtpmail-default-smtp-server my-domain1
	  smtpmail-smtp-server my-domain1
	  smtpmail-smtp-service 587
	  smtpmail-debug-info t)

;; auto-fill - guess the name when writing an email address
;;(setq mime-edit-mode-hook
(add-hook 'mime-edit-mode-hook '(lambda ()(auto-fill-mode 1)))

;; Do not use the html part of a message, use the text part if possible!
(setq mm-discouraged-alternatives '("text/html" "text/richtext"))

;; auto-fill - guess the name when writing an email address
;;(setq mime-edit-mode-hook
(add-hook 'mime-edit-mode-hook
          '(lambda ()
             (auto-fill-mode 1)))

;;(setq compose-mail-user-agent-warnings nil)
(require 'init-w3m)

;; slow cursor movement in summary, Emacs24, wl 2.15.9
;;(setq-default bidi-paragraph-direction 'left-to-right)  ;; this helps
;; but what is it?
(setq-default bidi-display-reordering nil
			  bidi-paragraph-direction (quote left-to-right))

(defun notify-my-mail ()
  "DOCSTRING"
  (interactive)
  (my-notify-popup "title2" "msg2" "~/.emacs.d/bindata/icons/email_envelope.png" "/usr/share/sounds/gnome/default/alerts/drip.ogg"))

(setq mime-view-type-subtype-score-alist
      '(((text . plain) . 4)
        ((text . enriched) . 3)
        ((text . html) . 2)
        ((text . richtext) . 1)))

(require 'init-mail-wl)
(require 'init-mail-gnus)

(provide 'init-mail)
;;; init-mail.el ends here
