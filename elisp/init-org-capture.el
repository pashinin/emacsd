;;; init-org-capture --- description
;;; Commentary:
;;; Code:

;; Org - Capture
(require 'remember)
;; make the frame contain a single window. by default org-remember
;; splits the window.
(add-hook 'remember-mode-hook 'delete-other-windows)

;;---------------------
;; http://www.windley.com/archives/2010/12/capture_mode_and_emacs.shtml
(defadvice org-capture-finalize
  (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

(defadvice org-capture-destroy
  (after delete-capture-frame activate)
  "Advise capture-destroy to close the frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-frame)))

;; make the frame contain a single window. by default org-capture
;; splits the window.
(add-hook 'org-capture-mode-hook 'delete-other-windows)

(defadvice org-switch-to-buffer-other-window
  (after supress-window-splitting activate)
  "Delete the extra window if we're in a capture frame"
  (if (equal "capture" (frame-parameter nil 'name))
      (delete-other-windows)
    ))

(defun make-remember-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  ;; if there are no emacs frames - make frame
  (if (= (length '(frame-list)) 0)
      (progn
        (make-frame '((name . "capture")
                      (width . 90)
                      (height . 20)
                      ;;(auto-raise . t)
                      )))
    (progn
      (rename-frame (selected-frame) "capture")  ; install frame-cmds from melpa for this
      ))
  (select-frame-by-name "capture")
  (set-frame-width  (selected-frame) 90)
  (set-frame-height (selected-frame) 20)
  (setq word-wrap      1)
  (setq truncate-lines nil)
  (org-capture))

;; templates to add notes
;; %U - date and time,                     [2013-01-06 Sun 02:24]
;; %a - current file in buffer as a link
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/my.org") "Todo's")
         "* %?\n  %i\n")
        ("e" "Emacs-todo" entry (file+headline (concat org-directory "/my.org") "Emacs") "* %?\n %i\n")
        ("f" "just forget it" entry (file+headline (concat org-directory "/my.org") "forget") "* %?\n %i\n"))
      )

(provide 'init-org-capture)
;;; init-org-capture.el ends here
