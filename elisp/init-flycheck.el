;;; init-flycheck --- my settings for flycheck
;;; Commentary:
;;; Code:

(require 'flycheck)

;; Highlight whole line with error
(setq flycheck-highlighting-mode 'lines
      flycheck-emacs-lisp-load-path load-path)

(add-hook 'after-init-hook #'global-flycheck-mode)
;;(global-flycheck-mode)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
