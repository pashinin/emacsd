;;; init-yasnippet --- description
;;; Commentary:
;; 1. https://github.com/capitaomorte/yasnippet
;; Yasnippets must be loaded after smarttabs. Or TAB is not working.
;;
;;; Code:

(require 'yasnippet)

(defun load-my-snippets ()
  "Load my snippets."
  (interactive)
  (with-temp-message ""
    (yas-load-directory "~/.emacs.d/snippets/django")
    (yas-load-directory "~/.emacs.d/snippets/other")))
;; (load-my-snippets)

(setq yas-prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/x-prompt))
(setq yas-wrap-around-region 'cua)
(run-with-timer 1 nil 'load-my-snippets)
(yas-global-mode 1)

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
