;;; init-f5 --- description
;;; Commentary:
;;; Code:

(require 'init-dired-z)
(require 'init-os-misc)
(require 'my-cpp)
(require 'my-audio)

(defun my-magic-python (filename)
  "Run python shell with current FILENAME."
  (python-shell-send-buffer t)
  ;; do something else
  )

(defun do-magic-with-file (&optional filename)
  "Do something useful with a given FILENAME."
  (interactive)
  (if (not filename)
      (progn
        ;; lisp
        (when (eq major-mode 'emacs-lisp-mode)
          (byte-compile-file (buffer-file-name)))

        ;; dired
        (when (eq major-mode 'dired-mode)
          ;; TODO: remove garbage: thumbs.db files
          (let ((f (dired-get-filename t t))
                (files (dired-get-marked-files))
                ext ext1)
            ;;(message (number-to-string (length files)))
            (if (and f (= (length files) 1))
                (do-magic-with-file f)
              (mapc 'do-magic-with-file files))
            )
          (save-window-excursion (with-temp-message "" (revert-buffer))))

        ;; tex
        (when (fboundp 'latex-mode)
          (when (eq major-mode 'latex-mode)
            (my-tex-run-tex)
            ))

        (let ((f (buffer-file-name)))
          ;; C++
          (when (eq major-mode 'c++-mode)
            (my-magic-cpp f))

          ;; Python
          (when (eq major-mode 'python-mode)
            (my-magic-python f))
          ))
    (let (ext ext1 f d)
      (setq f (or filename (buffer-file-name)))
      (setq d (file-name-directory f))
      (if (file-exists-p (concat d "desktop.ini"))
          (shell-command-to-string (concat "rm \"" d "desktop.ini\"")))
      (if (file-directory-p f)
          (progn
            ;;(setq ext-regexp (make-regex-of-extensions (list ext)))
            ;;(dired-mark-files-regexp ext-regexp)
            (message f))
        (progn
          (setq ext (downcase (or (file-name-extension f) "")))
          (cond ((or (string= ext "cpp")
                     (string= ext "c")) (my-magic-cpp f))
                ((is-archive-ext f)     (message "archive"))
                ((string= ext "iso")    (mount-iso f))
                ((string= ext "rc")     (my-magic-rc-file f))
                ((string= ext "el")     (byte-compile-file f))
                ((or (string= ext "mp3")
                     (string= ext "m4a")) (convert-mp3-ogg f))
                ((or (string= ext "doc")
                     (string= ext "docx"))
                 (libreoffice-convert f "odt"))
                )
          ))
      )
    ))

(defun do-magic-current-dir (&optional dir recursive child)
  "Do magic with all files recursively in current dir.
Or in specified DIR.
If RECURSIVE - call recursively.
CHILD - function called from other."
  (interactive)
  ;;dir
  (let ((d dir) files ext)
    (if (not dir) (setq d default-directory))
    (setq files (directory-files d t "\\.*"))
    (setq files (nthcdr 2 files))
    (dolist (el files)
      (message el)
      (sleep-for 1)
      (if (and (file-directory-p el)
               recursive)
          (do-magic-current-dir el)
        (do-magic-with-file el))
      )
    )
  (if (not dir)
      (when (eq major-mode 'dired-mode)
        (save-window-excursion (with-temp-message "" (revert-buffer)))))
  )

(defun do-magic-recursively ()
  "Do magic with all files recursively in current dir."
  (interactive)
  (do-magic-current-dir nil t))

;; with current buffer or marked file(s) in Dired:
(global-set-key (kbd "<f5>") 'do-magic-with-file)

;; with same files in current directory (Shift-F5)
(global-set-key (kbd "<S-f5>") 'do-magic-current-dir)

;; with same files in current and all directories in it (Shift-Win-F5)
(global-set-key (kbd "<s-S-f5>") 'do-magic-recursively)

(provide 'init-f5)
;;; init-f5.el ends here
