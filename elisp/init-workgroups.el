;;; init-workgroups --- Configure workgroups2 extension
;;; Commentary:
;;; Code:

(require 'init-variables)
(add-to-list 'load-path (concat my-emacs-ext-dir "workgroups2/src"))
(when (require 'workgroups2 nil 'noerror)

;; Some settings:
(setq wg-prefix-key (kbd "C-c z")
      wg-restore-associated-buffers nil
      wg-use-default-session-file nil
      wg-default-session-file (concat my-emacs-files-dir "workgroups")
      wg-use-faces t
      wg-morph-on nil)             ; animation off

(if (eq system-type 'windows-nt)
    (setq wg-use-default-session-file t))  ; turn off for "emacs --daemon"
;; (wg-reload-session)

(setq
 wg-mode-line-decor-left-brace "["
 wg-mode-line-decor-right-brace "]"
 wg-mode-line-only-name t
 wg-display-nowg nil)

;; Define my functions
(defun my-switch-wg-to (workgroup)
  "Switch to WORKGROUP (name) or return to previous one."
  (interactive)
  (if (equal (wg-workgroup-name (wg-current-workgroup)) workgroup)
      (progn (wg-switch-to-previous-workgroup))
    (progn
      (wg-switch-to-workgroup workgroup)))
  (message (wg-workgroup-name (wg-current-workgroup))))

(defun test-and-load-workgroups ()
  "Load workgroups if it's not a Capture frame."
  (interactive)
  (with-selected-frame (selected-frame)
    (when (not (equal "capture" (frame-parameter nil 'name)))
      (wg-reload-session)
      (select-frame-set-input-focus (selected-frame)))
    (select-frame-set-input-focus (selected-frame))))

(defun load-workgroups-if-needed()
  (run-with-idle-timer 0.5 nil 'test-and-load-workgroups))

;; Keyboard shortcuts - load, save, switch
(global-set-key (kbd "<pause>")     'wg-reload-session)
(global-set-key (kbd "C-S-<pause>") 'wg-save-session)
(global-set-key (kbd "s-z")         'wg-switch-to-workgroup)
(global-set-key (kbd "s-/")         'wg-switch-to-previous-workgroup)
(global-set-key (kbd "<s-f1>") (lambda () (interactive) (my-switch-wg-to "mail" )))
(global-set-key (kbd "<s-f2>") (lambda () (interactive) (my-switch-wg-to "music")))

;;(run-with-idle-timer 0.1 nil 'frame-workgroups)
;;(add-hook 'after-make-frame-functions 'load-workgroups-if-needed)

(setq wg-display-nowg nil)  ; if no workgroups - display nothing

(defun set-my-frame-title (frame)
  "Set FRAME title format."
  (interactive)
  (setq frame-title-format '("" "%b - Emacs " emacs-version)))

(add-hook 'after-make-frame-functions 'set-my-frame-title)

(workgroups-mode 1)
)
(provide 'init-workgroups)
;;; init-workgroups.el ends here
