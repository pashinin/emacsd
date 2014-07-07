;;; init-irc --- IRC config
;;; Commentary:
;; erc-services ?
;;; Code:

(require 'erc)
(require 'erc-services)
;;(require 'init-gpg)      ; my personal config that loads some passwords


(erc-services-mode 1)
(setq erc-prompt-for-nickserv-password nil)

;;(when (locate-library "init-gpg")
;;(autoload 'ediff-trees "ediff-trees" "Start an tree ediff" t)
(autoload 'irc-freenode-nick-passwd "init-gpg")

;; set some passwords
(if (boundp 'irc-freenode-nick-passwd)  ; from my init-gpg.el
    (setq erc-nickserv-passwords
          `((freenode (("spok"     . ,irc-freenode-nick-passwd)
                       ;;("nick-2"   . ,irc-freenode-nick-passwd)
                       ))
            ;;(DALnet       (("nickname" . ,dalnet-pass)))
            )))

;; joining && autojoing
;; make sure to use wildcards for e.g. freenode as the actual server
;; name can be be a bit different, which would screw up autoconnect
(erc-autojoin-mode t)
;;(setq erc-autojoin-channels-alist
;;      '(
;;          ;(".*\\.freenode.net" "#emacs" "#gnu" "#gcc" "#modest" "#maemo")
;;          ;(".*\\.freenode.net" "#emacs" )
;;          ;(".*\\.gimp.org" "#unix" "#gtk+")
;;        ))


;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
;;(setq erc-hide-list '("PART" "NICK"))


(defun erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer."
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?
      (erc-track-switch-buffer 1) ;; yes: switch to last active
    (progn
      (erc :server "irc.freenode.net" :port 6667 :nick "spok" :full-name "Sergey"))))

;;(defun nickname-freenode-after-connect (server nick)
;;  (when (and (string-match "irc\\.freenode\\.net" server)
;;            (boundp 'irc-freenode-nick-passwd))
;;    (erc-message "PRIVMSG" (concat "NickServ identify " irc-freenode-nick-passwd))))
;;(add-hook 'erc-after-connect 'nickname-freenode-after-connect)

(defun my-switch-to-jabber-irc ()
  "Switch to Jabber and IRC windows."
  (interactive)
  (if (fboundp 'wg-workgroup-name)
      (if (not (equal (wg-workgroup-name (wg-current-workgroup)) "IRC"))
          (my-switch-wg-to "IRC")))
  (erc-start-or-switch))

;; switch to ERC and Jabber - M-s-r
(global-set-key (kbd "M-s-r") 'my-switch-to-jabber-irc)
;; /join #emacs
;;)

(provide 'init-irc)
;;; init-irc.el ends here
