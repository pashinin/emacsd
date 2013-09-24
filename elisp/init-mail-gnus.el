;;; init-mail-gnus --- Try to use GNUS
;;; Commentary:
;;; Code:

;; Threads - keep all messages with same subject together
(setq gnus-summary-thread-gathering-function
      'gnus-gather-threads-by-subject)

;; Also, I prefer to see only the top level message.  If a message has
;; several replies or is part of a thread, only show the first message.
;; 'gnus-thread-ignore-subject' will ignore the subject and look at
;; 'In-Reply-To:' and 'References:' headers.
(setq gnus-thread-hide-subtree t)
(setq gnus-thread-ignore-subject t)

;; Tell Emacs about your mail server and credentials
(require 'smtpmail)
(setq send-mail-function            'smtpmail-send-it
      message-send-mail-function    'smtpmail-send-it
      smtpmail-starttls-credentials '((my-domain1 587 nil nil))
      smtpmail-auth-credentials     (expand-file-name "~/.authinfo.gpg")
      smtpmail-default-smtp-server  my-domain1
      smtpmail-smtp-server          my-domain1
      smtpmail-smtp-service         587
      smtpmail-debug-info           t)

;; 143    - IMAP
;; 119    - NNTP - http://ru.wikipedia.org/wiki/NNTP

;; GMANE is about the only free news server I've seen.
;; I set it to my primary server so I can read a few Free software mailing lists.
(setq gnus-select-method '(nntp "news.gmane.org"))
;;;(setq gnus-select-method
;;;   '(nntp my-domain1    ; fill in your server!  (see below)
;;;           (nntp-port-number 119)))

;;(setq gnus-select-method
;;      '(nnimap ""  ; domain.com
;;               (nnimap-address "")  ; domain.com
;;               (nnimap-server-port 143)
;;               (nnimap-stream ssl)))


;; Mostly, though, I just want to read my mail. This setup uses a standard
;; SSL-based connection to read the mail for the accounts I have through UC
;; Berkeley:
;(setq gnus-secondary-select-methods
;      '((nnimap "calmail" ; primary email
;               (nnimap-address "calmail.berkeley.edu")
;               (nnimap-server-port 993)
;               (nnimap-authenticator login)
;               (nnimap-expunge-on-close 'never)
;               (nnimap-stream ssl))
;       (nnimap "ocf" ; secondary account
;               (nnimap-address "mail.ocf.berkeley.edu")
;               (nnimap-server-port 993)
;               (nnimap-authenticator login)
;               (nnimap-expunge-on-close 'never)
;               (nnimap-stream ssl))))


;;(setq mail-user-agent gnus-user-agent)
;;(setq gnus-visible-headers "^From:\\|^Subject:")

(provide 'init-mail-gnus)
;;; init-mail-gnus.el ends here
