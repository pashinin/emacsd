;;; init-yaml.el ---
;;; Commentary:
;;; Code:

(require 'req-package)

;;yaml-indent-line
(defun yaml-indent-line ()
  "Indent the current line.
The first time this command is used, the line will be indented to the
maximum sensible indentation.  Each immediately subsequent usage will
back-dent the line by `yaml-indent-offset' spaces.  On reaching column
0, it will cycle back to the maximum sensible indentation."
  (interactive "*")
  (let ((ci (current-indentation))
        (cc (current-column))
        (need (yaml-compute-indentation)))
    (save-excursion
      (beginning-of-line)
      (delete-horizontal-space)
      ;;(if (and (equal last-command this-command) (/= ci 0))
      ;;    (indent-to (* (/ (- ci 1) yaml-indent-offset) yaml-indent-offset))
      ;;  (indent-to need))
      (indent-to need))
    (if (< (current-column) (current-indentation))
        (forward-to-indentation 0))
    ))


(req-package yaml-mode
init:
(progn
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


))

(provide 'init-yaml)
;;; init-yaml.el ends here
