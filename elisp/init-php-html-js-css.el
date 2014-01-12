;;; init-php-html-js-css --- description
;;; Commentary:
;;; Code:

;;
;; js3-mode
;;
(require 'js3-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(add-to-list ' load-path (concat my-emacs-ext-dir "jquery-doc"))
(require 'jquery-doc)
(add-hook 'js3-mode-hook 'jquery-doc-setup)

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(defun moz-minor-mode-enable ()
  (moz-minor-mode 1))

(add-hook 'js3-mode-hook 'moz-minor-mode-enable)

(add-to-list 'load-path "~/src/lintnode")
(require 'flymake-jslint)
;; Make sure we can find the lintnode executable
(setq lintnode-location "~/src/lintnode")
;; JSLint can be... opinionated
(setq lintnode-jslint-excludes (list 'nomen 'undef 'plusplus 'onevar 'white))
;; Start the server when we first open a js file and start checking
;;(add-hook 'js3-mode-hook (lambda () (lintnode-hook)))
;;(remove-hook 'js3-mode-hook '(lambda () (lintnode-hook)))


(defun firefox-reload ()
  "Reload current tab in Firefox."
  (interactive)
  (comint-send-string (inferior-moz-process)
                      "BrowserReload();"))

(define-key js3-mode-map (kbd "s-r") 'firefox-reload)

(require 'css-mode)
(add-hook 'css-mode-hook 'moz-minor-mode-enable)
(define-key css-mode-map (kbd "s-r") 'firefox-reload)

;;
;; emmet-mode
;; Just write something like "a.x>span" and press C-<RET>
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'web-mode-hook  'emmet-mode)

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
(add-hook 'web-mode-hook 'moz-minor-mode-enable)
(define-key web-mode-map (kbd "s-r") 'firefox-reload)
(add-to-list 'auto-mode-alist '("\\.phtml\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'"  . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'"    . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.php5?\\'"     . web-mode))
;;(set-face-attribute 'web-mode-css-rule-face nil :foreground "Pink3")
(add-hook 'web-mode-hook 'whitespace-turn-off)
(add-hook 'web-mode-hook (lambda () (whitespace-mode -1)))

(setq web-mode-markup-indent-offset 2)
;;(setq web-mode-css-indent-offset    3)  ; CSS offset indentation
(setq web-mode-code-indent-offset   2)  ; indentation for js, Java, PHP, etc.
(setq web-mode-disable-autocompletion t)

(defun jump-tag-end ()
  (interactive)
  (web-mode-element-end)
  (backward-char 2))
(defun jump-tag-begin ()
  (interactive)
  (web-mode-element-beginning)
  ;;(web-mode-tag-end)
  (forward-char 2))
(define-key web-mode-map (kbd "<C-down>") 'jump-tag-end)
(define-key web-mode-map (kbd "<C-up>")   'jump-tag-begin)

(provide 'init-php-html-js-css)
;;; init-php-html-js-css.el ends here
