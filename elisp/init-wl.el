;;; init-wl --- description
;;; Commentary:
;;; Code:

(require 'init-variables)
;; w3m octet configuration for handling attachments
(add-to-list 'load-path
             (expand-file-name "~/.emacs.d/packages/w3m"))

(require 'octet)
(octet-mime-setup)


;; IMAP:
(setq
 elmo-imap4-default-authenticate-type 'clear  ; clear  ; login  ; cram-md5
 elmo-imap4-default-user        my-mail-1
 elmo-imap4-default-server      my-domain1
 elmo-imap4-default-port        993  ; 143, 993 (ssl)
 elmo-imap4-use-modified-utf7   t
)

;; stream type: ssl, starttls
(setq elmo-imap4-default-stream-type 'ssl)
(setq elmo-imap4-debug t)  ;; if failed to connect
;; and look into *IMAP4 DEBUG* buffer


(put 'ML 'field-separator "\n")
(put 'User-Agent 'field-separator "\n")

;;(setq bbdb-auto-notes-alist
;;       '(
;;       ("X-ML-Name" (".*$" ML 0))
;;       ("X-Mailinglist" (".*$" ML 0))
;;       ("X-Ml-Name" (".*$" ML 0))
;;       ("X-Mailer" (".*$" User-Agent 0))
;;       ("X-Newsreader" (".*$" User-Agent 0))
;;       ("User-Agent" (".*$" User-Agent 0))
;;       ("X-Face" ("[ \t\n]*\\([^ \t\n]*\\)\\([ \t\n]+\\([^ \t\n]+\\)\\)?\\([ \t\n]+\\([^ \t\n]+\\)\\)?\\([ \t\n]+\\([^ \t\n]+\\)\\)?"
;;                                 face "\\1\\3\\5\\7"))
;;       ))





;; look in zip files as if they were folders
;;(setq elmo-archive-treat-file t)

;; show sent mail by who it was to
(setq wl-summary-showto-folder-regexp ".*")
(setq wl-summary-from-function 'wl-summary-default-from)

;; refiling (what?)
;;(setq wl-refile-rule-alist
;;      '((("To" "Cc")
;;         ("^wl-en@lists.airs.net" . "+mlists"))))


;; How can I prevent WL from splitting large attachments into many
;; messages?
(setq mime-edit-split-message nil)


;; switch multipart
(setq mime-view-type-subtype-score-alist
	  '(((text . plain) . 4)
		((text . enriched) . 3)
		((text . html) . 2)
		((text . richtext) . 1)))
;; use "C-c m" to switch



;; To save passwords for Wanderlust:
;; 1. Enter password 1 time while entering your mail
;; 2. M-x elmo-passwd-alist-save
;; It will save passwords in ~/.elmo/passwd

(provide 'init-wl)
;;; init-wl.el ends here
