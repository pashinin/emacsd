;;; init-js-coffee.el --- JavaScript / CoffeeScript
;;; Commentary:
;; Copyright (C) Sergey Pashinin
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;
;; sudo apt-get install nodejs npm &&
;; sudo npm install -g coffee-script coffeelint jslint
;;
;;; Code:

(require 'init-variables)
(require 'init-firefox)
(require 'js3-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(add-to-list ' load-path (concat my-emacs-ext-dir "jquery-doc"))
(require 'jquery-doc)
(add-hook 'js3-mode-hook 'jquery-doc-setup)
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
;;coffee-indent-line


(define-key js3-mode-map (kbd "s-r") 'firefox-reload)
(define-key js3-mode-map (kbd "s-h") 'js3-mode-toggle-element)


;;
;; Coffee
;;
(require 'coffee-mode)
(require 'flymake-coffee)
;;(require 'flymake-coffeelint)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)
(setq coffee-tab-width 2
      coffee-indent-tabs-mode t
      coffee-args-compile '("-c" "-b")
      )
(custom-set-variables '(coffee-tab-width 2))

;; hook
(defun my-coffee-hook ()
  "Run when in coffee-mode."
  (interactive)
  (my-smarttabs-spaces-autoinednt)

  (smart-tabs-mode-enable)
  (setq coffee-tab-width 2
        coffee-indent-tabs-mode nil
        coffee-args-compile '("-c" "-b" "--map")
        )
  ;;coffee-compile-file
  ;;(smart-tabs-advice  coffee-indent-line     coffee-indent-line)
  ;;(smart-tabs-advice  py-indent-line         py-indent-offset)
  ;;(smart-tabs-advice  py-newline-and-indent  python-indent-line-1)
  ;;(smart-tabs-advice  py-indent-region       py-indent-offset)
  ;;py-indent-offset
  )

(when (require 'init-smarttabs nil 'noerror)
  ;;(add-hook 'js2-mode-hook    'my-smarttabs-tabs-autoinednt)
  (add-hook 'js3-mode-hook    'myHtmlStyle)
  (add-hook 'coffee-mode-hook 'my-coffee-hook)
  ;;(add-hook 'coffee-mode-hook 'myHtmlStyle)
  ;;(remove-hook 'coffee-mode-hook 'myHtmlStyle)
  ;;(add-hook 'coffee-mode-hook 'my-coffee-hook)
  ;;(remove-hook 'coffee-mode-hook 'my-coffee-hook)
  ;;coffee
  )


(defun coffee-on-save()
  "My function on saving coffee."
  (when (eq major-mode 'coffee-mode)
    (coffee-compile-file)
    (firefox-reload)))
(add-hook 'after-save-hook 'coffee-on-save)

;; Enable autocomplete in scss-mode
(when (require 'init-autocomplete nil 'noerror)
  (add-to-list 'ac-modes 'coffee-mode))


;; json


(provide 'init-js-coffee)
;;; init-js-coffee.el ends here
