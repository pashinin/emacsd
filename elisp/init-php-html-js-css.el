;;; init-php-html-js-css --- description
;;; Commentary:
;;; Code:

;; It will refuse to run unless you have byte-compiled it. You must
;; byte-compile it with your version of Emacs because different versions of
;; Emacs have different byte-compiled formats.
(require 'js2-mode)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

;; nxhtml
;;(load "~/.emacs.d/extensions/nxhtml/autostart.el")
;;;;(setq auto-mode-alist
;;;;      (append '(("\\.html?$" . django-html-mumamo-mode)) auto-mode-alist)
;;;;	  )
;;(setq mumamo-background-colors nil)
;;(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))
;;
;;;; Workaround the annoying warnings:
;;;;    Warning (mumamo-per-buffer-local-vars):
;;;;    Already 'permanent-local t: buffer-file-name
;;;; or - just get an archive from pull request
;;(when (and (equal emacs-major-version 24)
;;           (equal emacs-minor-version 3))
;;  (eval-after-load "mumamo"
;;    '(setq mumamo-per-buffer-local-vars
;;           (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

;; Mumamo is making emacs 23.3 freak out:
;;(when (and (equal emacs-major-version 24)
;;           (equal emacs-minor-version 1))
;;(when (equal emacs-major-version 24)
;;  (eval-after-load "bytecomp"
;;    '(add-to-list 'byte-compile-not-obsolete-vars
;;                  'font-lock-beginning-of-syntax-function))
;;  ;; tramp-compat.el clobbers this variable!
;;  (eval-after-load "tramp-compat"
;;    '(add-to-list 'byte-compile-not-obsolete-vars
;;                  'font-lock-beginning-of-syntax-function)))




;; web-mode
;; Install from Melpa, also look at:
;; 1. http://web-mode.org/
;; 2. https://github.com/fxbois/web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.php5?\\'"     . web-mode))


(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset    2) ; CSS offset indentation
  (setq web-mode-code-indent-offset   2) ; indentation for js, Java, PHP, etc.

  ;; HTML content is not indented by default (indeed indenting the content of a TEXTAREA for example can have nasty side effects).
  ;; You can change this behaviour with
  (setq web-mode-indent-style 2)
  (local-set-key (kbd "RET") 'newline-and-indent)
  (smart-tabs-mode-enable)
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  )

;;(add-hook 'web-mode-hook
;;		  '(lambda ()
;;			 (define-key web-mode-map "\C-m" 'newline-and-indent)))
;;(add-hook 'web-mode-hook  'my-web-mode-hook)
;;(add-hook 'web-mode-hook  'myHtmlStyle)

(provide 'init-php-html-js-css)
;;; init-php-html-js-css.el ends here
