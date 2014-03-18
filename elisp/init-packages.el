;;; init-packages --- Packages system for Emacs 24
;;; Commentary:
;; See help - http://ergoemacs.org/emacs/emacs_package_system.html
;;; Code:
;;
(require 'init-variables)

(when (> emacs-major-version 23)
  (require 'package)
  (setq package-archives '(("gnu"       . "http://elpa.gnu.org/packages/")
                           ;;("marmalade" . "http://marmalade-repo.org/packages/")
                           ("melpa"     . "http://melpa.milkbox.net/packages/")))

  ;;(setq package-load-list '((org nil) all))  ; do not load ORG-mode
  (package-initialize)   ; loads all packages, or those defined in
                                        ; "package-load-list" variable
  )

;; auto install Melpa packages
(defvar my-packages
  '(ack-and-a-half ack apache-mode async auto-compile auto-complete auctex
                   bash-completion bm bookmark+ buffer-move bbdb
                   color-theme ctags crontab-mode color-theme-sanityinc-solarized
                   dash dired-details dired-details+
                   emmet-mode emms expand-region
                   frame-cmds frame-fns flycheck flymake full-ack
                   gitignore-mode
                   helm helm-git helm-projectile
                   image-dired+
                   jedi js2-mode js3-mode
                   magit markdown-mode markdown-mode+ multi-term multiple-cursors
                   nginx-mode
                   openwith org
                   projectile pymacs pysmell pyvirtualenv paredit projectile pony-mode
                   s skewer-mode smart-tab smart-tabs-mode smex
                   volatile-highlights
                   web-mode wrap-region windsize
                   yaml-mode yari yasnippet
                   zenburn-theme)
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(condition-case err
    (unless (prelude-packages-installed-p)
      ;; check for new packages (package versions)
      (message "%s" "Refreshing package database...")
      (package-refresh-contents)
      (message "%s" " done.")
      ;; install the missing packages
      (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))
  (error (princ (format "FAILED, needed to download packages: %s" err))
     2))



;; el-get
(when (not travis)
(condition-case err
    (with-no-warnings
      (when (> emacs-major-version 23)
    (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
    (unless (require 'el-get nil 'noerror)
      (when internet-ok
        (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
          (goto-char (point-max))
          (eval-print-last-sexp))))
    (when internet-ok
      (el-get 'sync))))
  (error (princ (format "FAILED loading el-get: %s" err))
     2))
)

;; auto-install - Automates the installation of Emacs Lisp files and packages
;;(when (require 'auto-install nil 'noerror)
;;  (setq auto-install-directory "~/.emacs.d/auto-install/"))

;; Load auto-compile extension (compile all changed .el files)
(when (require 'auto-compile nil 'noerror)
  (auto-compile-on-load-mode 1)
  ;;(auto-compile-global-mode 1)
  (auto-compile-on-save-mode 1))

(provide 'init-packages)
;;; init-packages.el ends here
