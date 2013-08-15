;;; init-dired-z --- Working with archives
;;; Commentary:
;;
;; What you should not use:
;; - rar (fuck closed shit)
;; - zip (has problems with encoding of filenames)
;;
;; What you maybe should use:
;; - 7z (open source, good compression. no problems with encoding)
;;
;;; Code:

(require 'dired-extension)
(require 'dired-x)                     ; omitting files possibility

(defun convert-zip-7z (fname)
  "Convert .zip file FNAME to .7z."
  (interactive)
  )

(defun convert-rar-7z (fname)
  "Convert .rar file FNAME to .7z."
  (interactive)
  )

(defcustom my-archives-options nil "Extensions and commands to archive/extract."
  :group 'my-vars)
(setq my-archives-options (list
                           (list "zip" "z" "z")
                           ))

(defun my-get-decompress-cmd (filename)
  "Return compress command for a FILENAME."
  (interactive)
  (let (ext e)
    (setq ext (file-name-extension filename))
    (if ext
        (progn
          (setq e (downcase ext))
          (or (string= e "7z")
              (string= e "zip")
              (string= e "rar")))
      nil)))

(defun my-get-compress-cmd (ext)
  "Return compress command for a file type EXT."
  (interactive)
  "7z a ")

(defun is-archive-ext (filename)
  "Return t if FILENAME extension is \"7z\", \"zip\"..."
  (interactive)
  (let (ext e)
    (setq ext (file-name-extension filename))
    (and ext
         (progn
           (setq e (downcase ext))
           (or (string= e "7z")
               (string= e "zip")
               (string= e "rar"))))))
;; (is-archive-ext "a.7z")
;; (is-archive-ext "a.pdf")

(defun all-extensionss-are-archives (files)
  "Return t if all FILES have archives extensions (7z, zip...)."
  (interactive)
  (let (res)
    ;;(member t )
    (setq res (dolist (element files res)
      (setq res (append res (list (is-archive-ext element))))))
    (not (member nil res))
    ))
;; (all-extensionss-are-archives (list "a.7z" "b.pdf"))

(defun all-are-directories (files)
  "Return t if all FILES are directories."
  (interactive)
  (let (res)
    (member nil (dolist (element files res)
                  (setq res (append res (list (not (file-directory-p element)))))
                  ))))


(defun my-archive-list (filename)
  "List files in a FILENAME archive."
  (interactive)
  (shell-command-to-string (concat "7z l \"" filename "\"")))

(defun my-extract-archive (filename)
  "Smart extract archive FILENAME.
- If only 1 filename in it - get it
- If several nested dirs - get 1 last dir
- If several files - create a dir and extract to it

Overwrites files."
  (interactive)
  (let (f fb outdir)
    (setq f filename)
    (setq fb (file-name-sans-extension (file-name-nondirectory f)))
    (setq outdir (concat (file-name-directory f) fb))
    (message outdir)
    (if (and outdir
             (not (file-directory-p outdir)))
        (make-directory outdir))
    ;;
    ;;(message (my-archive-list filename))
    (message (shell-command-to-string (concat "7z x \"" f "\" -y -o\"" outdir "\"")))
    ;;(message (concat "7z x \"" f "\" -o\"" outdir "\""))
  ))



(defun my-dired-compress ()
  "Do compress/decompress stuff in dired."
  (interactive)
  (when (eq major-mode 'dired-mode)
    ;; get current file
    (let ((files (dired-get-marked-files)) f fb outfile cmd)
      (when (equal (length files) 1)
        (setq f (car files))
        (setq fb (file-name-sans-extension (file-name-nondirectory f)))
        ;; file-name-sans-extension
        (if (is-archive-ext f)
            (progn
              ;;(message (number-to-string (length (dired-get-marked-files))))
              (if (file-directory-p fb)
                  (when (y-or-n-p (concat "Directory \"" fb "\" exists. Overwrite? "))
                    (my-extract-archive f))
                (when (y-or-n-p "Extract? ")
                  (my-extract-archive f))))
          (progn
            (if (file-directory-p f)
                (when (y-or-n-p "Compress this directory? ")
                  (setq cmd (concat "7z a archive.7z \"" f "/*\""))
                  (shell-command cmd))
              (when (y-or-n-p "Compress this file? ")
                (setq cmd (concat "7z a archive.7z \"" f "\""))
                (shell-command cmd)))
            )))
      (when (> (length files) 1)
        (if (all-extensionss-are-archives files)
            (when (y-or-n-p "Extract them all? ")
              (message "Extracting from all...")
              )
          (progn
            ;;(message "not all archives")
            (if (all-are-directories files)
                (message "all dirs"))
            )
          )
        )
      )
    ;;(revert-buffer)
    ))

(provide 'init-dired-z)
;;; init-dired-z.el ends here
