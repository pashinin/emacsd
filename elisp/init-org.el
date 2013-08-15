;;; init-org  --- description
;;; Commentary:
;; Repo:         git://orgmode.org/org-mode.git
;; Mailing list: https://lists.gnu.org/mailman/listinfo/emacs-orgmode
;;; Code:

(require 'init-variables)
(require 'org)
(require 'org-compat)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; org files directory:
(setq org-directory     "/usr/data/disk_3/MY/org")
(if (eq system-type 'windows-nt)
    (setq org-directory "//SERVER/disk_3/MY/ORG")) ; on windows

(setq org-log-done              t)
(setq org-support-shift-select  t)   ; select with "shift + arrows"

;; parse these files:
(setq org-agenda-files
      (list
       (concat org-directory "/work.org")
       (concat org-directory "/my.org")
       (concat org-directory "/coursera.org")))
(setq org-default-notes-file (concat org-directory "/notes.org"))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red"    :weight bold))
        ("PROC" . (:foreground "yellow" :weight bold))
        ("DONE" . (:foreground "green"  :weight bold))))

(require 'init-org-agenda)
(require 'init-org-capture)

;; wrap lines
(add-hook 'org-mode-hook
          '(lambda ()
             (turn-on-visual-line-mode)))    ; wrap lines

;; change some colors:
;;org-agenda-date-today
;;(org-agenda-date-today ((t (:italic t :bold t :foreground "LightSkyBlue" :slant italic :weight bold))))

;; Highlight src in BEGIN_SRC
(setq org-src-fontify-natively t)

(provide 'init-org)
;;; init-org.el ends here
