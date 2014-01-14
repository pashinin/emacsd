;;; init-yasnippet --- description
;;; Commentary:
;; 1. https://github.com/capitaomorte/yasnippet
;; Yasnippets must be loaded after smarttabs. Or TAB is not working.
;;
;;; Code:

(require 'yasnippet)

(setq yas-prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/x-prompt))
(setq yas-wrap-around-region 'cua)
(yas-global-mode 1)
;;(yas-reload-all)
;;(global-set-key (kbd "<tab>") 'yas-expand)

;;(setq yas/root-directory '("~/emacs.d/mysnippets"
;;                           "~/Downloads/interesting-snippets"))
;;;; Map `yas/load-directory' to every element
;;(mapc 'yas/load-directory yas/root-directory)

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
