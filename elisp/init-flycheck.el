;;; init-flycheck --- my settings for flycheck
;;; Commentary:
;;
;; Source: https://github.com/flycheck/flycheck
;;
;;; Code:

(require 'flycheck)

;; Highlight whole line with error
(setq flycheck-highlighting-mode 'lines
      flycheck-emacs-lisp-load-path load-path)

;;(add-hook 'after-init-hook #'global-flycheck-mode)
(global-flycheck-mode)


(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
;;flycheck-flake8rc is a variable defined in `flycheck.el'.
;;Its value is ".flake8rc"

(require 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)

(require 'flymake-yaml)
(add-hook 'yaml-mode-hook 'flymake-yaml-load)

(global-set-key (kbd "s-<") 'flymake-goto-prev-error)
(global-set-key (kbd "s->") 'flymake-goto-next-error)

;;(set-face-background 'flymake-warnline "dark slate blue")

(provide 'init-flycheck)
;;; init-flycheck.el ends here
