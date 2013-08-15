;;; init-bbdb --- address book
;;; Commentary:
;; install using Melpa
;;
;;; Code:

;;(require 'init-variables)
;;(require 'bbdb-autoloads)
;;(load "bbdb-autoloads.el")
(setq bbdb-file "~/.bbdb/bbdb")    ; "~/.bbdb"
(require 'bbdb)
(require 'bbdb-com)
;;(unless (file-exists-p bbdb-file)  ; create if not exists?
;;  (write-region "" nil bbdb-file))

(bbdb-initialize)

;; mklink "where" "what"
;; mklink C:\bin\bbdb C:\bin\.bbdb\bbdb

;;(if (eq system-type 'windows-nt)
;;    (let ((f "C:/bin/bbdb")
;;          (f2 "C:/bin/bbdb-my/bbdb"))
;;      (if (and (not (file-exists-p f))
;;               (file-exists-p f2))
;;          (shell-command-to-string "mklink C:\\bin\\bbdb C:\\bin\bbdb-my\\bbdb")
;;        )))


;;(setq bbdb-file "~/bbdb")    ; "~/.bbdb"
;;(setq bbdb-file "~/.bbdb/bbdb")
;;(bbdb-initialize 'gnus 'message)

;;(add-to-list 'file-coding-system-alist (cons "\\.bbdb"  'utf-8))

;;(setq bbdb-use-pop-up nil)    ; See the BBDB only when I ask
;;(setq bbdb-canonicalize-redundant-nets-p t)  ; Ignore subnets

;; If you don't live in Northern America, you should disable the syntax
;; check for telephone numbers by saying
;;(setq bbdb-north-american-phone-numbers-p nil)

;; Tell bbdb about your email address:
;;(setq bbdb-user-mail-names
;;      (regexp-opt '("my@mail.com"
;;					)))

;;(setq bbdb-use-pop-up nil)
;;;(setq
;;; bbdb-always-add-address t                ;; add new addresses to DB automatically
;;; bbdb-auto-revert        t                ;; reload DB if it's changed on disk
;;; bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx
;;; bbdb-complete-name-allow-cycling t
;;; bbdb-complete-name-allow-cycling t       ;; cycle through matches
;;; bbdb-completion-type nil                 ;; complete on anything
;;; bbdb-dwim-net-address-allow-redundancy t ;; always use full name
;;; bbdb-electric-p t                        ;; be disposable with SPC
;;; ;;bbdb-message-caching-enabled t           ;; be fast
;;; bbdb-elided-display t                    ;; single-line addresses
;;; bbdb-offer-save 1                        ;; 1 means save-without-asking
;;; bbdb-popup-target-lines  1               ;; very small
;;; bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs
;;; bbdb-use-alternate-names t               ;; use AKA
;;(setq bbdb-use-pop-up t)                        ;; allow popups for addresses
;;;
;;; ;; auto-create addresses from mail
;;; bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook
;;; bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
;;; ;; NOTE: there can be only one entry per header (such as To, From)
;;; ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html
;;; '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter"))
;;; )
;; Now you should be ready to go. Say `M-x bbdb RET RET' to open a bbdb
;; buffer showing all entries.

;;(global-set-key (kbd "s-b") 'bbdb)

(provide 'init-bbdb)
;;; init-bbdb.el ends here
