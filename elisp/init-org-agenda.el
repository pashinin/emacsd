;;; init-org-agenda --- description
;;; Commentary:
;;; Code:

(require 'org-agenda)

;; AGENDA
(setq org-agenda-window-setup 'current-window)  ;; Type C-h v
;; org-agenda-window-setup
;; for other options.
;; do not display DONE tasks:
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-prefix-format '((agenda . " %t %s") ; " %i %-12:c%?-12t% s"
                                 (timeline . " % s")   ; (timeline . "  % s")
                                 (todo . "")           ; (todo . " %i %-12:c")
                                 (tags . " %i %-12:c") ; (tags . " %i %-12:c")
                                 (search . " %i %-12:c")))
(setq org-agenda-use-time-grid nil)

;; ("Scheduled: " "Sched.%2dx: ")
(setq org-agenda-scheduled-leaders '("" "%2dx: "))

;; (org-agenda nil "n")  ; for running Agenda
;; See "org-agenda-custom-commands" variable for help

;; Update agenda buffer after saving "org-mode" file
;; http://stackoverflow.com/questions/3313210/converting-this-untabify-on-save-hook-for-emacs-to-work-with-espresso-mode-or-a
(defcustom my-update-agenda-on-save-modes '(org-mode)
  "When saving these modes - update Agenda buffer."
  :group 'my-vars)

(setq my-update-agenda-on-save-modes '(org-mode))  ;; on what modes saving?
(defun my-update-agenda-hook ()
  "When saving `org-mode' file - update Agenda buffer."
  (interactive)
  (when (member major-mode my-update-agenda-on-save-modes)
    (if (get-buffer org-agenda-buffer-name)
        (save-window-excursion
          (save-excursion  ; save cursor position
            (with-current-buffer org-agenda-buffer-name
              (let ((line (org-current-line)))
                (org-agenda-redo)
                ;;(if line (org-goto-line line))
                )))))))
(add-hook 'after-save-hook 'my-update-agenda-hook)

(provide 'init-org-agenda)
;;; init-org-agenda.el ends here
