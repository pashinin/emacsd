;;; init-mail --- Work with mail
;;; Commentary:
;;; Code:

;;(setq wl-init-file "~/.emacs.d/mysettings/wl.el")
(require 'wl)
(require 'wl-draft)
;; To load WL only when needed - use these lines:
;;(autoload 'wl "wl" "Wanderlust" t)
;;(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
;;(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

;; ----------------------------------------------------------------------------
;;; Basic configuration
(setq wl-icon-directory "~/.emacs.d/el-get/wanderlust/etc/icons"
      ;;elmo-msgdb-directory "~/Emacs/Wanderlust/Elmo"
      ;;elmo-split-log-file "~/Emacs/Wanderlust/Elmo/split-log"

      ;; Offline and synchronization
      wl-plugged                   t
      elmo-imap4-use-modified-utf7 t
      elmo-imap4-use-cache         t
      ;;elmo-nntp-use-cache          t
      ;;elmo-pop3-use-cache          t
      wl-ask-range                 nil

      ;;elmo-message-fetch-confirm   t
      ;;elmo-message-fetch-threshold 250000
      ;;elmo-network-session-idle-timeout 30

      wl-fcc                "+~/Mail/outbox/out"          ; where to store sent mails
      wl-fcc-force-as-read  t
      wl-from (concat user-full-name " <" user-mail-address ">")
      ;;wl-organization "XxxxXXX Ltd."

      ;; Automatic signature insertion
      ;;signature-file-name "~/Maildir/Signatures/XxxxXXXAddress"
      ;;signature-insert-at-eof t
      ;;signature-delete-blank-lines-at-eof t

      ;; User Email addresses
      wl-user-mail-address-list    nil

      wl-draft-reply-buffer-style 'keep
      ;;wl-draft-reply-buffer-style 'full
      wl-interactive-send         nil
      wl-interactive-exit         nil

      ;; Windows and decoration
      wl-folder-use-frame             nil
      wl-highlight-body-too           t
      wl-use-highlight-mouse-line     nil
      wl-show-plug-status-on-modeline t
      wl-message-window-size          '(1 . 4)
      )


;; summari line format:
;; help - <F1-v> on variable
(setq wl-summary-line-format "%n%T%P%1@%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %s") ; default
(setq wl-summary-line-format "%T%P%t%[%25(%c %f%) %]%1@%Y.%M.%D(%W) %h:%m %s")


;; Configure Outbound Mail
;; Tell the program who you are
(setq user-full-name my-name-full)
(setq user-mail-address my-mail-1)

;; Tell Emacs to use GNUTLS instead of STARTTLS to authenticate when
;; sending mail.
(setq starttls-use-gnutls t)

;; Threads!  I hate reading un-threaded email -- especially mailing
;; lists.  This helps a ton!
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

;;; 143        - IMAP
;;; 119        - NNTP. http://ru.wikipedia.org/wiki/NNTP
;;
;;;; GMANE is about the only free news server I've seen.
;;;; I set it to my primary server so I can read a few Free software mailing lists.
;;;(setq gnus-select-method
;;;	  '(nntp "news.gmane.org"))
;;;(setq gnus-select-method
;;;	  '(nntp my-domain1    ; fill in your server!  (see below)
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
;				(nnimap-address "calmail.berkeley.edu")
;				(nnimap-server-port 993)
;				(nnimap-authenticator login)
;				(nnimap-expunge-on-close 'never)
;				(nnimap-stream ssl))
;		(nnimap "ocf" ; secondary account
;				(nnimap-address "mail.ocf.berkeley.edu")
;				(nnimap-server-port 993)
;				(nnimap-authenticator login)
;				(nnimap-expunge-on-close 'never)
;				(nnimap-stream ssl))))


;;(setq mail-user-agent gnus-user-agent)
;;(setq gnus-visible-headers "^From:\\|^Subject:")


;; ignore  all fields
(setq wl-message-ignored-field-list '("^.*:"))
;;(setq wl-message-ignored-field-list '("^"))

;; ..but these five:
(setq wl-message-visible-field-list '("^To" "^Subject" "^From" "^Date" "^Cc"))
;;(setq wl-message-visible-field-list
;;	  '("^To:"
;;		"^Cc:"
;;		"^From:"
;;		"^Subject:"
;;		"^Date:"))

;; In addition you can control the order of these headers using the
;; variable ‘wl-message-sort-field-list’:
(setq wl-message-sort-field-list
	  '("^From:"
		"^Subject:"
		"^Date:"
		"^To:"
		"^Cc:"))

;; auto-fill - guess the name when writing an email address
;;(setq mime-edit-mode-hook
(add-hook 'mime-edit-mode-hook
          '(lambda ()
             (auto-fill-mode 1)))

;;(setq compose-mail-user-agent-warnings nil)
(require 'init-w3m)

;;(setq wl-summary-toggle-mime "mime")  ;; wtf is it?
;; Open new frame for draft buffer.
(setq wl-draft-use-frame nil)

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

;; SMTP
;;(setq wl-smtp-connection-type 'starttls)
;;(setq wl-smtp-posting-port 587)
;;(setq wl-smtp-authenticate-type "cram-md5")
;;(setq wl-smtp-posting-user "sado")
;;(setq wl-smtp-posting-server "max.icu.ac.jp")
;;(setq wl-local-domain "icu.ac.jp")
(setq wl-smtp-posting-server my-domain1)
(setq wl-message-id-domain my-domain1)
(setq wl-from my-mail-1full)
(setq wl-user-mail-address-list
      (list (wl-address-header-extract-address wl-from) my-mail-1full))
(setq wl-local-domain my-domain1)
(setq wl-draft-always-delete-myself t)

;; expiry
(setq wl-expire-alist
      '(("^\\+trash$"   (date 14) remove) ;; delete
        ("^\\+tmp$"     (date 7) trash)   ;; re-file to wl-trash-folder
        ("^\\%inbox"    (date 30) wl-expire-archive-date)
        ;; archive by year and month (numbers discarded)
        ))

;; slow cursor movement in summary, Emacs24, wl 2.15.9
;;(setq-default bidi-paragraph-direction 'left-to-right)  ;; this helps
;; but what is it?
(setq-default bidi-display-reordering nil
			  bidi-paragraph-direction (quote left-to-right))

(defun notify-my-mail ()
  "DOCSTRING"
  (interactive)
  (my-notify-popup "title2" "msg2" "~/.emacs.d/bindata/icons/email_envelope.png" "/usr/share/sounds/gnome/default/alerts/drip.ogg"))

;; notify mail arrival
(setq
 wl-biff-check-folder-list '((concat "%inbox:\"" my-mail-1 "\"/clear@" my-domain1 ":993!"))
 ;;wl-biff-notify-hook '(ding)
 wl-biff-notify-hook nil
 wl-biff-check-interval 10
 ;;wl-biff-use-idle-timer t
 wl-summary-no-subject-message "(no subject)")
;;wl-biff-event-handler

(add-hook 'wl-biff-notify-hook
          (lambda()
            (notify-my-mail)))


;; Hidden header field in message buffer.
(setq wl-message-ignored-field-list
      '(".*Received:"
        ".*Path:"
                                        ;	"^Message-I[dD]:"		; RFC 2036 too!
        "^References:"
        "^Replied:"
        "^Errors-To:"
        "^Lines:"
        ".*Sender:"			; include X-Sender, X-X-Sender, etc.
        ".*Host:"
        "^Xref:"
        "^Content-Type:"
;;;	"^Precedence:"
        "^Status:"
        "^X-VM-.*:"
        "^[mM][iI][mM][eE]-[vV]ersion:"	; irrelevant!  :-)
        "^[cC]ontent.*:"		; irrelevant!  :-)
        "^In-Reply-To:"			; just another message-id
        "^DomainKey.*:"			; bogus junk
        "^X-Sieve:"			; cyrus
        "^X-BeenThere:"			; mailman?
        "^X-Mailman.*:"			; mailman
        "^X-ML.*:"			; fml
                                        ;	"^X-Original-To:"		; fml?
        "^X-MAil-Count:"		; fml?
        "^X-SKK:"
        "^List-.*:"			; rfc????
        "^X-Cam.*:"			; some stupid virus scanner
        "^X-Spam.*:"
        "^X-Scanned.*:"
        "^X-Virus.*:"
        "^X-CanItPRO.*:"
        "^X-PMX.*:"
        "^X-RPI.*:"
        "^X-Accept-Language:"
        "^X-Greylist.*:"
        "^X-OriginalArrivalTime:"
        "^X-MIME-Autoconverted:"

        "^X-Rc-Virus:"
        "^X-Rc-Spam:"
        ;;"^Resent-Message-I[dD]:"
        "^X-DSPAM.*:"
        ))

;;(require 'bbdb-wl "/usr/share/emacs/site-lisp/wl/utils/bbdb-wl.el")

(setq mime-view-type-subtype-score-alist
      '(((text . plain) . 4)
        ((text . enriched) . 3)
        ((text . html) . 2)
        ((text . richtext) . 1)))

;; Run Wanderlust with "Emacs --daemon"
;; only if have internet - or Emacs hangs
(wl)

(provide 'init-mail)
;;; init-mail.el ends here
