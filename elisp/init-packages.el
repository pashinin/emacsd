;;; init-packages --- Packages system for Emacs 24
;;; Commentary:
;; See help - http://ergoemacs.org/emacs/emacs_package_system.html
;;; Code:

(require 'init-variables)

(when (> emacs-major-version 23)
  (require 'package)
  (setq package-archives '(("gnu"       . "http://elpa.gnu.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa"     . "http://melpa.milkbox.net/packages/")))

  ;;(setq package-load-list '((org nil) all))  ; do not load ORG-mode
  (package-initialize)   ; loads all packages, or those defined in
                                        ; "package-load-list" variable
  )

;; el-get
(when (> emacs-major-version 23)
  (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
  (when (require 'el-get nil 'noerror)
    (when internet-ok
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
        (goto-char (point-max))
        (eval-print-last-sexp)))
    (el-get 'sync)))  ;; hangs if no internet

;; auto-install - Automates the installation of Emacs Lisp files and packages
(when (require 'auto-install nil 'noerror)
  (setq auto-install-directory "~/.emacs.d/auto-install/"))

;; Load auto-compile extension (compile all changed .el files)
(when (require 'auto-compile nil 'noerror)
  (auto-compile-on-load-mode 1)
  ;;(auto-compile-global-mode 1)
  (auto-compile-on-save-mode 1))

(provide 'init-packages)
;;; init-packages.el ends here
