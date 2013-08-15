;;; init-yasnippet --- description
;;; Commentary:
;; 1. https://github.com/capitaomorte/yasnippet
;; Yasnippets must be loaded after smarttabs. Or TAB is not working.
;;
;;; Code:

(require 'yasnippet)
(yas-global-mode 1)

(defun epy-django-snippets ()
  "Load django snippets."
  (interactive)
  (yas-load-directory "~/.emacs.d/snippets/django"))

(setq yas-prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/x-prompt))
(setq yas-wrap-around-region 'cua)

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
