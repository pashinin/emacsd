;;; init-packages --- Packages system for Emacs 24
;;; Commentary:
;;; Code:

(require 'init-variables)

(require 'package)
(setq package-archives '(("gnu"       . "http://elpa.gnu.org/packages/")
                         ;;("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa"     . "http://melpa.milkbox.net/packages/")))
;;(setq package-load-list '((org nil) all))  ; do not load ORG-mode
(package-initialize)

;; auto install Melpa packages
(defvar my-packages)
(setq my-packages '(req-package))

(defun prelude-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(when (not in-travis)
(condition-case err
    (unless (prelude-packages-installed-p)
      (message "%s" "Refreshing package database...")
      (package-refresh-contents)
      (message "%s" " done.")
      (dolist (p my-packages)
        (when (not (package-installed-p p))
          (package-install p))))
  (error (princ (format "FAILED, needed to download packages: %s" err))
     2))
)

(require 'req-package)

;; el-get
;;(when (not travis)
;;(condition-case err
;;    (with-no-warnings
;;      (when (> emacs-major-version 23)
;;    (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
;;    (unless (require 'el-get nil 'noerror)
;;      (when internet-ok
;;        (with-current-buffer
;;        (url-retrieve-synchronously
;;         "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;          (goto-char (point-max))
;;          (eval-print-last-sexp))))
;;    (when internet-ok
;;      (el-get 'sync))))
;;  (error (princ (format "FAILED loading el-get: %s" err))
;;     2))
;;)

;; auto-install - Automates the installation of Emacs Lisp files and packages
;;(when (require 'auto-install nil 'noerror)
;;  (setq auto-install-directory "~/.emacs.d/auto-install/"))

;;(req-package epl)

;; Compile all changed .el files
;(require 'auto-compile)
;(auto-compile-on-load-mode 1)
;(auto-compile-on-save-mode 1)

;(require 'markdown-mode)
;(define-key markdown-mode-map (kbd "RET") 'comment-indent-new-line)

;; Emacs major mode for editing Lua
;; https://github.com/immerrr/lua-mode
;(require 'lua-mode)
;(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
;(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
;(setq lua-indent-level 4)

(provide 'init-packages)
;;; init-packages.el ends here
