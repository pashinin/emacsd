;;; init-workgroups --- Configure workgroups2 extension
;;; Commentary:
;;; Code:

(require 'init-variables)
(add-to-list 'load-path (concat my-emacs-ext-dir "workgroups2/src"))

;; (desktop-save-mode 1)   ; may have issues with workgroups

(when (require 'workgroups2 nil 'noerror)

;; WG file:
(setq wg-default-session-file (concat my-emacs-files-dir "workgroups"))

(setq
 wg-mode-line-decor-left-brace "["
 wg-mode-line-decor-right-brace "]"
 wg-mode-line-only-name t           ; show only current WG name
 wg-display-nowg nil                ; if no workgroups - display nothing
 wg-mode-line-use-faces t           ; colorize mode line
 wg-use-faces t                     ; colorize messages
 )

;; Keyboard shortcuts - load, save, switch
(global-set-key (kbd "<pause>")     'wg-reload-session)
(global-set-key (kbd "C-S-<pause>") 'wg-save-session)
(global-set-key (kbd "s-z")         'wg-switch-to-workgroup)
(global-set-key (kbd "s-/")         'wg-switch-to-previous-workgroup)
;;(global-set-key (kbd "<s-f1>") (lambda () (interactive) (my-switch-wg-to "mail" )))
;;(global-set-key (kbd "<s-f2>") (lambda () (interactive) (my-switch-wg-to "music")))


;; Define my functions
(defun my-switch-wg-to (workgroup)
  "Switch to WORKGROUP (name) or return to previous one."
  (interactive)
  (if (equal (wg-workgroup-name (wg-current-workgroup)) workgroup)
      (wg-switch-to-previous-workgroup)
    (wg-switch-to-workgroup workgroup))
  (message (wg-workgroup-name (wg-current-workgroup))))

(defun test-and-load-workgroups ()
  "Load workgroups if it's not a Capture frame."
  (interactive)
  (workgroups-mode 1)
  (with-selected-frame (selected-frame)
    (when (not (equal "capture" (frame-parameter nil 'name)))
      (wg-reload-session)
      (select-frame-set-input-focus (selected-frame)))
    (select-frame-set-input-focus (selected-frame))))

(defun load-workgroups-if-needed()
  (run-with-idle-timer 0.5 nil 'test-and-load-workgroups))

(defun set-my-frame-title (frame)
  "Set FRAME title format."
  (interactive)
  (setq frame-title-format '("" "%b - Emacs " emacs-version)))

(add-hook 'after-make-frame-functions 'set-my-frame-title)

(workgroups-mode 1)

)
(provide 'init-workgroups)
;;; init-workgroups.el ends here
