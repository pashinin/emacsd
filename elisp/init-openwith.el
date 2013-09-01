;;; init-openwith  --- description
;;; Commentary:
;; Install "openwith" from MELPA
;;; Code:

;;(when (require 'openwith nil 'noerror)
(require 'openwith)
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

  (openwith-mode t)
;;)


;; Open ISO files

(defun open-in-external-app ()
  "Open the current file or dired marked files in external app."
  (interactive)
  (let ( doIt
         (myFileList
          (cond
           ((string-equal major-mode "dired-mode") (dired-get-marked-files))
           (t (list (buffer-file-name))) ) ) )

    (setq doIt (if (<= (length myFileList) 5)
                   t
                 (y-or-n-p "Open more than 5 files? ") ) )

    (when doIt
      (cond
       ((string-equal system-type "windows-nt")
        (mapc (lambda (fPath)
                ;;(defvar w32-shell-execute)
                ;;(w32-shell-execute "open" (replace-regexp-in-string "/" "\\" fPath t t))
                ) myFileList)
        )
       ((string-equal system-type "darwin")
        (mapc (lambda (fPath)
                (let ((process-connection-type nil))
                  (start-process "" nil "open" fPath)))  myFileList) )
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (fPath)
                (let ((process-connection-type nil))
                  (start-process "" nil "xdg-open" fPath)) ) myFileList))))))

(defun my-dired-external-open-hook ()
  "Set local dired keys to open files in other apps."
  (interactive)
  (local-set-key (kbd "<C-return>") 'open-in-external-app))
(add-hook 'dired-mode-hook 'my-dired-external-open-hook)

(provide 'init-openwith)
;;; init-openwith.el ends here
