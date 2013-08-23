;;; init-f5 --- description
;;; Commentary:
;;; Code:

(require 'init-dired-z)
(require 'init-os-misc)

(defun my-magic-python (filename)
  "Do some magic with Python file FILENAME."
  ;; run python shell with current file
  (python-shell-send-buffer t)
  )

(defun after-compilation (status code msg)
  "Run this function after compile."
  (interactive)
  ;; If M-x compile exists with a 0
  ;; compile-command
  ;;(when (and (eq status 'exit) (zerop code))
  ;;  (if (executable-find "upx")
  ;;      (shell-command (concat "upx -q C:/bin/hello/fileexists.exe"))))
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))

(defun my-magic-cpp (filename)
  "Do some magic with C/C++ file FILENAME."
  (interactive)
  (let ((f (file-truename filename))
        (ext (file-name-extension filename))
        (extl (downcase (file-name-extension filename)))
        base gcc files resfile)
    (setq base (file-name-base f))
    (when (eq system-type 'windows-nt)
      (setq gcc "g++ -mwindows ")
      ;;(shell-command (concat gcc f " -o " base ".exe"))
      ;;(compile (concat gcc filename " -o " base ".exe -DCURL_STATICLIB"))

      ;; if have .res file (resources) - add it to the end
      (setq files (directory-files "." nil "\\.res$"))
      (if (> (length files) 0) (setq resfile (car files)))

      (setq compilation-exit-message-function 'after-compilation)
      (compile (concat gcc filename " -o " base ".exe " (if resfile resfile)
                       ;;" -lcurl -lwsock32 -lidn -lwldap32"
                       ;;" -lssh2 -lrtmp -lcrypto -lz -lws2_32 -lwinmm -lssl"
                       ;;" -lboost_filesystem -lboost_system"
                       ;;" -luser32"
                       ))
      )))

(defun my-magic-rc-file (filename)
  "Compile .rc resource FILENAME to .res on Windows."
  (interactive)
  (let (base cmd)
    (setq base (file-name-base filename))
    (setq cmd (concat "windres \"" filename "\" -O coff -o "
                      (concat base ".res")))
    (message (shell-command-to-string cmd))
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
                ((string= ext "rc")    (my-magic-rc-file f))
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

  (let ((f (buffer-file-name)))
    ;; C++
    (when (eq major-mode 'c++-mode)
      (my-magic-cpp f))

    ;; Python
    (when (eq major-mode 'python-mode)
        (my-magic-python f))
    ))

(global-set-key (kbd "<f5>") 'my-magic-f5)

(provide 'init-f5)
;;; init-f5.el ends here
