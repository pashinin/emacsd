;;; init-f5 --- description
;;; Commentary:
;;; Code:

(require 'init-dired-z)
(require 'init-os-misc)

(defun my-magic-cpp (filename)
  "Do some magic with C/C++ file FILENAME."
  (interactive)
  (let ((f (file-truename filename))
        (ext (file-name-extension filename))
        (extl (downcase (file-name-extension filename)))
        base gcc)
    (setq base (file-name-base f))
    (when (eq system-type 'windows-nt)
      (setq gcc "g++ -mwindows ")
      ;;(shell-command (concat gcc f " -o " base ".exe"))
      ;;(compile (concat gcc filename " -o " base ".exe -DCURL_STATICLIB"))
      (compile (concat gcc filename " -o " base ".exe"
                       ;;" -lcurl -lwsock32 -lidn -lwldap32"
                       ;;" -lssh2 -lrtmp -lcrypto -lz -lws2_32 -lwinmm -lssl"
                       ;;" -lboost_filesystem -lboost_system"
                       ;;" -luser32"
                       ))
      ;; update dired buffer
      )))

(defcustom var-libreoffice-exe nil
  "Explicitly point to LibreOffice executable."
  :group 'my-vars)

(defun libreoffice-exec ()
  "Return a full path to LibreOffice executable."
  (interactive)
  (if var-libreoffice-exe
      var-libreoffice-exe
    (let (files res)
      (if (eq system-type 'windows-nt)
          (progn
            (setq files (list
                         "C:/Program Files (x86)/LibreOffice 4/program/soffice.exe"
                         "C:/Program Files (x86)/LibreOffice 4.0/program/soffice.exe"))
            (dolist (element files res)
              (if (file-exists-p element)
                  (setq res element))))
        "libreoffice"))))

;; doesn't work on windows
(defun libreoffice-convert (filename format)
  "Convert fucking doc FILENAME to FORMAT."
  (interactive)
  (message "converting")
  (let (office cmd)
    (setq office (libreoffice-exec))

    (setq cmd (concat (shell-quote-argument office)
                      " --headless"
                      " --invisible"
                      " --convert-to " format
                      " "
                      ;;" --outdir D:/"
                      (shell-quote-argument filename)
                      ;;filename
                      ))
    (message (shell-command-to-string cmd))
    ;;(message cmd)
    ;;(kill-ring-save cmd)
  ))

(defun my-magic-f5 ()
  "Do magic.
It's not finished and never will be."
  (interactive)
  ;; lisp
  (when (eq major-mode 'emacs-lisp-mode)
    (byte-compile-file (buffer-file-name)))

  ;; dired
  (when (eq major-mode 'dired-mode)
    (let ((f (dired-get-filename)) ext ext1)
      (if (file-directory-p f)
          (progn
            ;;(setq ext-regexp (make-regex-of-extensions (list ext)))
            ;;(dired-mark-files-regexp ext-regexp)
            (message f))
        (progn
          (setq ext (downcase (file-name-extension f)))
          (cond ((or (string= ext "cpp")
                     (string= ext "c")) (my-magic-cpp f))
                ((string= ext "iso")    (mount-iso f))
                ((is-archive-ext f)     (message "archive"))
                ((or (string= ext "doc")
                     (string= ext "docx"))
                 (libreoffice-convert f "odt"))
                ))))
    (save-window-excursion
      (with-temp-message "" (revert-buffer)))
    )

  ;; tex
  (when (fboundp 'latex-mode)
    (when (eq major-mode 'latex-mode)
      ;;(TeX-texify)
      (my-tex-run-tex)
      ))

  ;; C++
  (when (eq major-mode 'c++-mode)
    (let ((f (buffer-file-name)))
      (my-magic-cpp f)
    ))
  )

(global-set-key (kbd "<f5>") 'my-magic-f5)

(provide 'init-f5)
;;; init-f5.el ends here
