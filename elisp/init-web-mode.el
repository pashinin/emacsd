;;; init-web-mode --- html
;;; Commentary:
;; Install from Melpa, also look at:
;; 1. http://web-mode.org/
;; 2. https://github.com/fxbois/web-mode
;;; Code:

(require 'init-browser)

;; emmet-mode
;; Just write something like "a.x>span" and press C-<RET>
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook  'emmet-mode)

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
(add-hook 'web-mode-hook 'whitespace-turn-off)
(add-hook 'web-mode-hook (lambda () (whitespace-mode -1)))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset   2)    ; indentation for js, Java, PHP, etc.
;;(setq web-mode-disable-autocompletion t)

(defun jump-tag-end ()
  (interactive)
  (web-mode-element-end)
  (backward-char 2))
(defun jump-tag-begin ()
  (interactive)
  (web-mode-element-beginning)
  (forward-char 2))
(define-key web-mode-map (kbd "<C-down>") 'jump-tag-end)
(define-key web-mode-map (kbd "<C-up>")   'jump-tag-begin)


(when (require 'init-smarttabs nil 'noerror)
  (add-hook 'html-mode-hook   'myHtmlStyle)
  (add-hook 'nxhtml-mode-hook 'myHtmlStyle)
  (add-hook 'nxml-mode        'myHtmlStyle)
  (add-hook 'php-mode-hook    'myHtmlStyle)
  (add-hook 'web-mode-hook    'myHtmlStyle))


(provide 'init-web-mode)
;;; init-web-mode.el ends here
