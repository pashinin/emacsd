;;; init-jabber --- Jabber config
;;; Commentary:
;; Get it here:
;; 1. http://emacs-jabber.sourceforge.net/
;; 2. git://git.code.sf.net/p/emacs-jabber/git

;;; Code:

;; Jabber
;;(require 'hexrgb)     ; dependency
;;;(add-to-list 'load-path "~/.emacs.d/elisp/extensions/jabber-0.8.92")
;;;(add-to-list 'load-path "~/.emacs.d/elisp/extensions/emacs-jabber")
;;(require 'jabber-autoloads)     ; For 0.7.90 and above
;;(load-file "~/.emacs_files/jabberaccs.el")
(req-package jabber
  :bind ("C-M-s-j" . jabber-connect-all)
  :config
  (progn
    (setq jabber-history-enabled      t
          jabber-backlog-days         300.0    ; what for infinity?
          jabber-history-size-limit   10240    ; b, kb, mb?
          jabber-roster-line-format "%c %-25n %u %-8s (%r)")
    ;;(setq jabber-roster-line-format   " %a %c %-25n %u %-8s  %S " t)
    (setq jabber-roster-show-title    nil)
    ;;(setq jabber-socks5-proxies       (quote ("yourdomain.com")))

    (add-hook 'jabber-chat-mode-hook 'flyspell-mode)
    ;;(global-set-key "\C-x\C-a" 'jabber-activity-switch-to) ; to the new message

    ;;(define-key jabber-chat-mode-map (kbd "RET") 'newline)
    ;;(define-key jabber-chat-mode-map [C-return] 'jabber-chat-buffer-send)

    ;; Here’s a hook which will highlight URLs, and bind C-c RET to open the URL
    ;; using browse-url:
    (add-hook 'jabber-chat-mode-hook 'goto-address)

    ;; This code will issue incoming message alerts using the notification
    ;; daemon on linux systems. On Debian, the libnotify1 and libnotify-bin
    ;; packages are required.
    (req-package init-os-misc)
    (defvar libnotify-program "/usr/bin/notify-send")

    (defun notify-send (title message)
      (start-process "notify" " notify"
                     libnotify-program "--expire-time=4000" title message))

    (defun libnotify-jabber-notify (from buf text proposed-alert)
      "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
      (when (or jabber-message-alert-same-buffer
                (not (memq (selected-window) (get-buffer-window-list buf))))
        (if (jabber-muc-sender-p from)
            (notify-send (format "(PM) %s"
                                 (jabber-jid-displayname (jabber-jid-user from)))
                         (format "%s: %s" (jabber-jid-resource from) text)))
        (notify-send (format "%s" (jabber-jid-displayname from))
                     text)))

    (add-hook 'jabber-alert-message-hooks 'libnotify-jabber-notify)

    ;;(global-set-key (kbd "C-M-s-j") 'jabber-connect-all)

    ))

(provide 'init-jabber)
;;; init-jabber.el ends here
