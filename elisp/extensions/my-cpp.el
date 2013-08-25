;;; my-cpp.el --- Some compilation functions
;;; Commentary:
;; Copyright (C) Sergey Pashinin
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;; Code:

(require 'compile)

(defun after-compilation (status code msg)
  "Run this function after compilation.
STATUS CODE MSG"
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

(provide 'my-cpp)
;;; my-cpp.el ends here
