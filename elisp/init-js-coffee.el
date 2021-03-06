;;; init-js-coffee.el --- JavaScript / CoffeeScript
;;; Commentary:
;;
;; https://github.com/mooz/js2-mode
;; https://github.com/thomblake/js3-mode
;;
;; sudo apt-get install nodejs npm
;; sudo npm install -g coffee-script coffeelint jslint
;;
;; https://github.com/marijnh/tern
;;
;;; Code:

(require 'req-package)
(require 'init-variables)

(req-package jquery-doc
:ensure t)

;; js3
(req-package js3-mode
:ensure t
  :commands js3-mode js3-mode-toggle-element
  :bind ("s-h" . js3-mode-toggle-element)
  :init
  (progn
    ;;(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
    ;;(add-hook 'js3-mode-hook 'jquery-doc-setup)
    (add-hook 'js3-mode-hook 'moz-minor-mode-enable)
    (setq js3-auto-indent-p t
          js3-enter-indents-newline t)

    ;;(define-key js3-mode-map (kbd "s-r") 'firefox-reload)
    ;;(define-key js3-mode-map (kbd "s-h") 'js3-mode-toggle-element)
    ))

;; js2
;; https://emacs.stackexchange.com/questions/26949/can-i-turn-off-or-switch-the-syntax-checker-for-js2-mode
(req-package js2-mode
:ensure t
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
    (setq
     js2-highlight-level 3
     js-indent-level 2
     js2-basic-offset 2
     js2-mode-show-parse-errors nil
     js2-mode-show-strict-warnings nil
     )

    (add-hook 'js2-mode-hook
              (lambda ()
                (flycheck-mode t)
                (setq
                 indent-tabs-mode nil
                 js-indent-level 2
                 js2-basic-offset 2
                 js2-mode-show-parse-errors nil
                 js2-mode-show-strict-warnings nil)
                ))
    ))

;;
(req-package js2-refactor
:ensure t)
(req-package ac-js2
:ensure t
  :init
  (add-hook 'js2-mode-hook 'ac-js2-mode))

;;(add-to-list 'load-path (concat my-emacs-ext-dir "jquery-doc"))
(add-to-list 'load-path "~/src/lintnode")

(req-package init-tab
  :init
  (progn
    ;;(add-hook 'js2-mode-hook    'my-smarttabs-tabs-autoinednt)
    ;; (add-hook 'js3-mode-hook    'myHtmlStyle)
    ;; (add-hook 'js2-mode-hook    'myHtmlStyle)
    (add-hook 'coffee-mode-hook 'my-coffee-hook)
    ;;(add-hook 'coffee-mode-hook 'myHtmlStyle)
    ;;(remove-hook 'coffee-mode-hook 'myHtmlStyle)
    ;;(add-hook 'coffee-mode-hook 'my-coffee-hook)
    ;;(remove-hook 'coffee-mode-hook 'my-coffee-hook)
    ;;coffee
    ))

;; (require 'indium)
;; (add-hook 'js-mode-hook #'indium-interaction-mode)


;;(require 'flymake-jslint)
;; Make sure we can find the lintnode executable
;;(setq lintnode-location "~/src/lintnode")
;; JSLint can be... opinionated
;;(setq lintnode-jslint-excludes (list 'nomen 'undef 'plusplus 'onevar 'white))
;; Start the server when we first open a js file and start checking
;;(add-hook 'js3-mode-hook (lambda () (lintnode-hook)))
;;(remove-hook 'js3-mode-hook '(lambda () (lintnode-hook)))
;;coffee-indent-line

;;(req-package swank-js)


;; Enable autocomplete in scss-mode
;;(req-package init-autocomplete
;;  :init
;;  (add-to-list 'ac-modes 'coffee-mode))

(provide 'init-js-coffee)
;;; init-js-coffee.el ends here
