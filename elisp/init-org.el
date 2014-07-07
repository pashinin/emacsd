;;; init-org  --- description
;;; Commentary:
;; Repo:         git://orgmode.org/org-mode.git
;; Mailing list: https://lists.gnu.org/mailman/listinfo/emacs-orgmode
;;; Code:

(req-package init-variables)
(req-package org
  :commands org-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
    ;; org files directory:
    (setq org-directory (if (eq system-type 'windows-nt)
                            "//SERVER/disk_3/MY/ORG"  ;; on Windows
                          "/usr/data/disk_3/MY/org"))
    (setq org-log-done t
          org-support-shift-select  t  ; select with "shift + arrows"
          )
    (setq org-agenda-files
          (list
           (concat org-directory "/work.org")
           (concat org-directory "/my.org")
           (concat org-directory "/site.org")
           (concat org-directory "/coursera.org")))
    (setq org-default-notes-file (concat org-directory "/notes.org"))

    (setq org-todo-keyword-faces
          '(("TODO" . (:foreground "red"    :weight bold))
            ("PROC" . (:foreground "yellow" :weight bold))
            ("DONE" . (:foreground "green"  :weight bold))))

    (require 'init-org-agenda)
    (req-package init-org-capture)

    ;; wrap lines
    (add-hook 'org-mode-hook
              '(lambda ()
                 (turn-on-visual-line-mode)))    ; wrap lines

    ;; Highlight src in BEGIN_SRC
    (setq org-src-fontify-natively t)

    ;; NOTIFICATIONS
    ;; org-notify - http://orgmode.org/w/?p=org-mode.git;a=blob_plain;f=contrib/lisp/org-notify.el;hb=HEAD
    ;; 1. Set property "notify" for a task to some value
    ;; 2. `org-notify-add' to this value
    ;; C-c C-x p      Set a property
    ;; C-c C-d        Set a deadline
    ;; C-c C-s        Schedule
    ;;(require 'org-notify)

    (defun my/org-set-current-task ()
      "Set a task under the cursor current.
Set a property \"notify\" to \"current\"."
      (interactive)
      ;;(org-entr
      (with-temp-message ""
        (org-delete-property-globally "notify")
        (org-set-property "notify" "current")))

    (defun org-notify-action-notify (plist)
      "Show popup."
      (interactive)
      ;;(my-notify-popup "asd" "1")
      (my-notify-popup (plist-get plist :heading) (org-notify-body-text plist)))

    ;;(org-notify-add 'current
    ;;                '(:time "100d" :period "30s" :actions -notify/window)
    ;;                )
    ;;(org-notify-start)
    ;;(org-notify-stop)

    ;; my/org-set-current-task
    (define-key org-mode-map (kbd "C-s-c") 'my/org-set-current-task)
    (define-key org-mode-map (kbd "<return>") 'newline-and-indent)
    ))

;;(require 'org-compat)


;; org-mode - use spaces, autoindent
;;(add-hook 'org-mode-hook        'my-smarttabs-spaces-autoinednt)

;; change some colors:
;;org-agenda-date-today
;;(org-agenda-date-today ((t (:italic t :bold t :foreground "LightSkyBlue" :slant italic :weight bold))))


(provide 'init-org)
;;; init-org.el ends here
