;;; init-f5 --- A magic key
;;; Commentary:
;; Just my experiments
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
  "Do something useful with a given FILENAME.
If not given - use current buffer file or file under the cursor."
  (interactive)
  (if (not filename)
      (let ((f (buffer-file-name)))
        (cond
         ;; lisp
         ((eq major-mode 'emacs-lisp-mode)
          (byte-compile-file (buffer-file-name)))

         ;; dired
         ((eq major-mode 'dired-mode)
          (let ((f (dired-get-filename t t))
                (files (dired-get-marked-files))
                ext ext1)
            ;;(message (number-to-string (length files)))
            (save-window-excursion
              ;; TODO: analyze - what is selected
              (cond
               ((and f (= (length files) 1))  ; only 1 file
                (do-magic-with-file f))
               ((> (length files) 1)          ; more than 1 file selected
                (let ((stats (files-stats files))
                      img art)
                  (cond
                   ((files-ogg-1jpg stats)
                    (when (yes-or-no-p "Make this an album art for all OGG files?")
                      (setq img (get-first-image-from-files files))
                      (setq art (make-art-image img))
                      ;;(message (concat "TDOD: add " img " album cover to OGGs"))
                      (dolist (el (get-files-by-extension files "ogg"))
                        (message el)
                        (ogg-add-cover art el)
                        )))
                   (t
                    (message "Do magic on each file...")
                    (mapc 'do-magic-with-file files))
                   )))
               (t
                (message "Nothing selected!") ; nothing selected!
                ))))
          (save-window-excursion (with-temp-message "" (revert-buffer))))

         ;; TeX
         ((and (fboundp 'latex-mode)
               (eq major-mode 'latex-mode))
          (my-tex-run-tex))

         ;; C++
         ((eq major-mode 'c++-mode) (my-magic-cpp f))

         ;; Python
         ((eq major-mode 'python-mode) (my-magic-python f))

         ;; EMMS playlist
         ((eq major-mode 'emms-playlist-mode)
          ;; if on last line - add a new file to the playlist
          (let* ((current-track (emms-playlist-track-at (point)))
                 (next-track (emms-playlist-track-at (+ (line-end-position) 1)))
                 (f-current (cdr (assoc 'name current-track)))
                 (f-next (cdr (assoc 'name next-track)))
                 (resfile (or (do-magic-with-file f-current) "")))
            ;;(emms-playlist-track-at (end-of-line)
            ;;(emms-insert-file (do-magic-with-file f))

            (if (and (string= f-next resfile))
                (message "Already have it")
              ;;(emms-add-file resfile)
              (save-excursion
                (forward-line 1)
                (emms-insert-file resfile)
              ))))

         ;; - Unknown mode -
         (t (message "Don't know what to do in this mode!"))
         ))

    ;; if filename provided:
    (let (ext ext1 f d)
      (setq f (or filename (buffer-file-name)))
      (setq d (file-name-directory f))
      ;; TODO: remove garbage: thumbs.db files
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

(defun do-magic-action1 (&optional filename)
  "Do something else with a given FILENAME."
  (interactive)
  (if (not filename)
      (progn
        ;; lisp
        (when (eq major-mode 'emacs-lisp-mode)
          (byte-compile-file (buffer-file-name)))

        (when (eq major-mode 'dired-mode)
          (let ((f (dired-get-filename t t))
                (files (dired-get-marked-files))
                ext ext1)
            (save-window-excursion
              (if (and f (= (length files) 1))
                  (do-magic-with-file f)
                (mapc 'do-magic-with-file files))
              ))
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


;; default F5 action
(global-set-key (kbd "<f5>")     'do-magic-with-file)
(global-set-key (kbd "<S-f5>")   'do-magic-current-dir)
(global-set-key (kbd "<s-S-f5>") 'do-magic-recursively)

;; additional action 1 (M-f5)
(global-set-key (kbd "<M-f5>")   'do-magic-action1)

;; additional action 2 (C-f5)
(global-set-key (kbd "<C-f5>")   'do-magic-action2)

(provide 'init-f5)
;;; init-f5.el ends here
