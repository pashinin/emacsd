;;; init-variables  --- description
;;; Commentary:
;;; Code:

(defcustom my-emacs-files-dir "~/.emacs_files/"
  "All your configs directory."
  :group 'my-vars)
(unless (file-exists-p my-emacs-files-dir)
  (make-directory my-emacs-files-dir))

(defcustom my-emacs-ext-dir "~/.emacs.d/elisp/extensions/"
  "A dir with some extensions."
  :group 'my-vars)

(setq load-path (cons my-emacs-ext-dir load-path))
(require 'dflet)    ; no warnings for new Emacs about "flet"

(defconst package-subdirectory-regexp
  "\\([^.].*?\\)-\\([0-9]+\\(?:[.][0-9]+\\|\\(?:pre\\|beta\\|alpha\\)[0-9]+\\)*\\)"
  "Regular expression matching the name of a package subdirectory.
The first subexpression is the package name.
The second subexpression is the version string.

The regexp should not contain a starting \"\\`\" or a trailing
 \"\\'\"; those are added automatically by callers.")


(setq backup-inhibited t)       ; disable backup
(setq auto-save-default nil)    ; disable auto save

(defun have-internet ()
  "Return t if we can access some sites."
  (interactive)
  (if (eq system-type 'windows-nt)
	nil
	(or (= 0 (call-process "curl" nil nil nil "--connect-timeout" "2" "-f" "facebook.com"))
      (= 0 (call-process "curl" nil nil nil "--connect-timeout" "2" "-f" "google.com")))))
;; (have-internet)

(defcustom internet-ok nil
  "Show if recent test for the internet is ok."
  :type 'boolean
  :group 'my-vars)

(defun internet-fail ()
  "Show if recent test for the internet failed."
  (interactive)
  (not internet-ok))
;; (internet-fail)

(defun write-internet-status (&optional good)
  "Check internet with `have-internet'.
Or write GOOD to the `internet-ok' var."
  (interactive)
  (if (boundp 'good)
      (setq internet-ok good)
    (setq internet-ok (have-internet))))

;; internet-ok
;; Check internet every 20 seconds
;(if (not (eq system-type 'windows-nt))
;    (run-with-timer 10 20 '(lambda ()
;                             (async-start
;                              (lambda ()
;                                (or (= 0 (call-process "curl" nil nil nil
;                                                       "--connect-timeout" "2" "-f" "facebook.com"))
;                                    (= 0 (call-process "curl" nil nil nil
;                                                       "--connect-timeout" "2" "-f" "google.com"))))
;                              (lambda (res)
                                        ;                                (write-internet-status res))))))

(defvar in-travis (string= (getenv "CI") "true")
  "If the code is run within a Travis build.")

(provide 'init-variables)
;;; init-variables.el ends here
