;;; init-dired-marks --- Mark files by type and extension
;;; Commentary:
;;; Code:

(require 'dired)

(defun make-regex-of-extensions (exts)
  "Return a regexp matching files with extensions EXTS.
You give a list of extensions EXTS ('avi', 'mkv', ...)."
  (interactive)
  (let ((var1 ""))
    ;;(if (and (= (length exts) 1)
    ;;         (not (car exts)))
    ;;    ".*"
    (dolist (x exts var1)
      (setq var1 (concat var1 (concat ".*\\." x))))))

(defun my-dired-mark-all-current-ext ()
  "Mark all files with .ext equal to .ext under cursor."
  (interactive)
  (when (eq major-mode 'dired-mode)
    (let ((f (dired-get-filename)) ext ext-regexp)
      (setq ext (file-name-extension f))
      (if (file-directory-p f)
          (dired-mark-directories nil)
        (if ext (dired-mark-extension (concat "." ext))
          (save-excursion (dired-mark nil)))))))

(defun my-dired-unmark-helper (mark)
  "Unmark all files with .ext equal to .ext under cursor.
Do not care what MARK is.
It is just a helper function."
  (interactive)
  ;; check current mode is dired
  (when (eq major-mode 'dired-mode)
    (message (dired-get-filename))
    (let ((myext (file-name-extension (dired-get-filename)))
          ext-regexp)
      (message myext)
      (setq ext-regexp (make-regex-of-extensions (list myext)))
      (save-excursion
        (let* ((count 0)
               (inhibit-read-only t) case-fold-search
               (string (format "\n%c" mark)))
          (goto-char (point-min))
          (while (if (eq mark ?\r)
                     (re-search-forward dired-re-mark nil t)
                   (search-forward string nil t))

            (let ((file (dired-get-filename)) ext)
              (setq ext (file-name-extension file))
              (when (string= ext myext)
                ;;(if (string-match (dired-get-filename) ext-regexp)
                (subst-char-in-region (1- (point)) (point)
                                      (preceding-char) ?\s)
                (setq count (1+ count))
                ;;)
                )))
          (message (if (= count 1) "1 mark removed"
                     "%d marks removed") count)
          )))))

(defun my-dired-unmark-all-current-ext ()
  "Unmark all files with .ext equal to .ext under cursor."
  (interactive)
  (let ((f (dired-get-filename)) ext ext-regexp)
    (setq ext (file-name-extension f))
    (if (file-directory-p f)
        (dired-mark-directories dired-marker-char)
      (if ext
          (my-dired-unmark-helper ?\r)
        (save-excursion
          (dired-unmark nil)))
  )))

(defun my-dired-mark-all ()
  "Mark all files in directory."
  (interactive)
  (dired-mark-files-regexp ".*"))

(provide 'init-dired-marks)
;;; init-dired-marks.el ends here
