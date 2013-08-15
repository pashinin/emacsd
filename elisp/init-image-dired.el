;;; init-image-dired  --- description
;;; Commentary:
;;; Code:

(require 'init-variables)
(require 'image-dired)
(require 'image-dired+)
(autoload 'eimp-mode "eimp" "Emacs Image Manipulation Package." t)
(add-hook 'image-mode-hook 'eimp-mode)

;; directories
;;(defvar imd-images-dir (concat (getenv "HOME") "/image-dired")
(defvar imd-images-dir (concat my-emacs-files-dir "image-dired")
  "Root dir for `image-dired' mode thumbnails.")
(unless (file-exists-p imd-images-dir)
  (make-directory imd-images-dir))
(defvar imd-meta-data-dir imd-images-dir)
(setq image-dired-dir (concat imd-images-dir "/image-dired_thumbnails"))
(setq image-dired-main-image-directory (concat imd-images-dir"/temp"))

;; files
(setq image-dired-db-file (concat imd-meta-data-dir "/image-dired_db"))
(setq image-dired-temp-image-file (concat imd-images-dir "/image-dired_temp_file"))
(setq image-dired-temp-rotate-image-file (concat imd-images-dir "/dired_rotate_temp_file"))

;; "%p -rotate %d -copy all -outfile %t \"%o\""
(setq image-dired-cmd-rotate-original-program "convert"
      image-dired-cmd-rotate-original-options "%p \"%o\" -rotate %d \"%t\"")

(defun image-dired-rotate-original (degrees)
  "Redefined function to rotate an original image by DEGREES degrees."
  (if (not (image-dired-image-at-point-p))
      (message "No image at point")
    (let ((file (image-dired-original-file-name))
          command)
      ;;(if (not (string-match "\.[jJ][pP[eE]?[gG]$" file))
      ;;    (error "Only JPEG images can be rotated!"))
      (setq command (format-spec
                     image-dired-cmd-rotate-original-options
                     (list
                      (cons ?p image-dired-cmd-rotate-original-program)
                      (cons ?o (expand-file-name file))
                      (cons ?d degrees)
                      (cons ?t image-dired-temp-rotate-image-file)
                      )))
      (if (not (= 0 (call-process shell-file-name nil nil nil
                                  shell-command-switch command)))
          (progn
            (error "Could not rotate image")
            ;;(message command)
            )
        (image-dired-display-image image-dired-temp-rotate-image-file)
        (if (or (and image-dired-rotate-original-ask-before-overwrite
                     (y-or-n-p
                      "Rotate to temp file OK.  Overwrite original image? "))
                (not image-dired-rotate-original-ask-before-overwrite))
            (progn
              (copy-file image-dired-temp-rotate-image-file file t)
              (image-dired-refresh-thumb))
          (image-dired-display-image file))))))

;;(defun image-dired-rotate-cmd ()
;;  "DOCSTRING"
;;  (interactive)
;;  (let (command)
;;    (setq command (format-spec
;;                   image-dired-cmd-rotate-original-options
;;                   (list
;;                    (cons ?p image-dired-cmd-rotate-original-program)
;;                    (cons ?d "90")
;;                    (cons ?o (expand-file-name "/filename"))
;;                    (cons ?t image-dired-temp-rotate-image-file))))
;;    (message command)))

(provide 'init-image-dired)
;;; init-image-dired.el ends here
