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

;; slow cursor movement in summary of WL buffer, Emacs24, wl 2.15.9
;;(setq-default bidi-paragraph-direction 'left-to-right)  ;; this helps
;; but what is it?
(setq-default bidi-display-reordering nil
			  bidi-paragraph-direction 'left-to-right)

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

;; Run Wanderlust with "Emacs --daemon"
;; only if have internet - or Emacs hangs
(wl)

(provide 'init-mail-wl)
;;; init-mail-wl.el ends here
