;; Commentary:
;; Code:

(require 'init-variables)
(require 'autoinsert)

(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory "~/.emacs.d/auto-insert/") ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion

(setq auto-insert-alist '(("\\.sh$" . ["insert.sh" my-auto-update-defaults])
                          ("\\.el$" . ["insert.el" my-auto-update-defaults])
                          ("\\.py$" . ["insert-python.py" my-auto-update-defaults])
                          ("\\.tex$" . ["insert-tex.tex" my-auto-update-defaults])
                          ))

(defun my-auto-replace-header-name ()
  (save-excursion
    (while (search-forward "###" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match (upcase (file-name-nondirectory buffer-file-name)))
        (subst-char-in-region (point-min) (point-max) ?. ?_)
        (subst-char-in-region (point-min) (point-max) ?- ?_)
        ))
    ))

(defun my-auto-replace-file-name ()
  (save-excursion
    ;; Replace @@@ with file name
    (while (search-forward "(>>FILE<<)" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match (file-name-nondirectory buffer-file-name) t)
        ))
    ))

(defun my-auto-replace-file-name-no-ext ()
  (save-excursion
    ;; Replace @@@ with file name
    (while (search-forward "(>>FILE_NO_EXT<<)" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match (file-name-sans-extension (file-name-nondirectory buffer-file-name)) t)
        ))
    )
  )

(defun my-insert-today ()
  "Insert today's date into buffer"
  (interactive)
  (insert (format-time-string "%Y.%m.%e" (current-time))))

(defun my-auto-replace-date-time ()
  (save-excursion
    ;; replace DDDD with today's date
    (while (search-forward "(>>DATE<<)" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match "" t)
        (my-insert-today)
        ))))

(defun my-auto-update-header-file ()
  (my-auto-replace-header-name)
  (my-auto-replace-file-name)
  )

(defun my-auto-update-c-source-file ()
  (save-excursion
    ;; Replace HHHH with file name sans suffix
    (while (search-forward "HHHH" nil t)
      (save-restriction
        (narrow-to-region (match-beginning 0) (match-end 0))
        (replace-match (concat (file-name-sans-extension (file-name-nondirectory buffer-file-name)) ".h") t))))
  (my-auto-replace-file-name)
  (my-auto-replace-date-time))

(defun my-auto-update-defaults ()
  (my-auto-replace-file-name)
  (my-auto-replace-file-name-no-ext)
  (my-auto-replace-date-time)
  (save-buffer)
  )

(provide 'init-auto-insert)
;; init-auto-insert.el ends here
