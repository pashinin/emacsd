;;; init-openwith  --- description
;;; Commentary:
;; Install "openwith" from MELPA
;;; Code:

(when (require 'openwith nil 'noerror)
  ;;(require 'openwith)
  (setq openwith-associations
        (list
         (list (openwith-make-extension-regexp
                '("odt" "ods" "doc" "docx" "xls" "rtf"))
               "libreoffice" '(file))
         (list (openwith-make-extension-regexp
                '("pdf" "dvi" "djvu"))
               "evince" '(file))
         (list (openwith-make-extension-regexp
                '("rar" "gz" "7z"))
               "file-roller" '(file))
         (list (openwith-make-extension-regexp
                '("chm"))
               "xchm" '(file))
         (list (openwith-make-extension-regexp
                '("mp3" "ogg" "wav" "m4a" "flac"))
               "deadbeef" '(file))
         (list (openwith-make-extension-regexp
                '("mpeg" "avi" "wmv" "flv" "mkv" "ts" "mp4" "webm"))
               "vlc" '(file))
         (list (openwith-make-extension-regexp
                '("jpg" "jpeg" "png" "gif" "jpeg" "bmp"))
               "shotwell" '(file))))

  (openwith-mode t))


(defun open-in-external-app ()
  "Open a current file or marked files in an external app."
  (interactive)
  (let (doIt cmd
             (myFileList
              (cond
               ((eq major-mode 'dired-mode) (dired-get-marked-files))
               (t (list (buffer-file-name))))))

    (setq doIt (if (<= (length myFileList) 5) t (y-or-n-p "Open more than 5 files? ")))

    (when doIt
      (cond
       ((eq system-type 'windows-nt)
        (mapc (lambda (fPath)
                ;;(defvar w32-shell-execute)
                ;;(w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t))
                ) myFileList)
        )
       ((eq system-type 'darwin)
        (mapc (lambda (fPath)
                (let ((process-connection-type nil))
                  (start-process "" nil "open" fPath)))  myFileList))
       ((eq system-type 'gnu/linux)
        (openwith-open-unix "vlc" myFileList)
        )))))

(defun my-dired-smart-open ()
  "Open a file/several files in external apps."
  (interactive)
  (let ((myFileList
         (cond
          ((eq major-mode 'dired-mode) (dired-get-marked-files))
          (t (list (buffer-file-name)))
          )))
    (if (> (length myFileList) 1)
        (open-in-external-app)
      (dired-find-file))
    ))

(defun my-dired-external-open-hook ()
  "Set local dired keys to open files in other apps."
  (interactive)
  (define-key dired-mode-map (kbd "<return>") 'my-dired-smart-open)
  (define-key dired-mode-map (kbd "<kp-enter>") 'my-dired-smart-open))
(add-hook 'dired-mode-hook 'my-dired-external-open-hook)

(provide 'init-openwith)
;;; init-openwith.el ends here
