;;; init-yasnippet --- description
;;; Commentary:
;; 1. https://github.com/capitaomorte/yasnippet
;; Yasnippets must be loaded after smarttabs. Or TAB is not working.
;;
;; How does it work?
;; 1. If have a snippet - expand it
;; 2. Else - run `yas--fallback' (which tries to get a command like if there were no yasnippet mode)
;;    It `call-interactively' `yas--keybinding-beyond-yasnippet'
;;
;; Problem in `python-mode':
;; http://stackoverflow.com/questions/22287201/wrong-indentation-in-python-mode-with-yasnippet-emacs
;;
;;; Code:

(require 'yasnippet)

(setq yas-prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/x-prompt))
;;(setq yas-wrap-around-region 'cua)
(setq yas-wrap-around-region nil
      yas-fallback-behavior 'call-other-command            ; call-other-command nil
      )
(setq yas-indent-line nil)
(yas-global-mode 1)

(require 'hippie-exp)
(add-to-list 'hippie-expand-try-functions-list
             'yas/hippie-try-expand)
;; hippie-expand-try-functions-list
;;hippie-expand-try-functions-list
(setq hippie-expand-try-functions-list
      '(;;smart-tab
        yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-lisp-symbol))

;;(yas-reload-all)

;; Fixing a problem
(defun my-smart-tab ()
  "Do `yas-expand' only if on text, else - `smart-tab'."
  (interactive)
  (if (looking-back "[\n ]" 1)
      (smart-tab)
    (yas-expand)))


;; `global-set-key' will NOT work for this, so:
;;(define-key yas-minor-mode-map (kbd "<tab>") 'my-smart-tab)
;;(define-key yas-minor-mode-map (kbd "TAB") 'my-smart-tab)
;;(define-key yas-minor-mode-map (kbd "<tab>") 'yas-expand)
;;(define-key yas-minor-mode-map (kbd "TAB") 'yas-expand)
;;;(define-key yas-minor-mode-map (kbd "<the new key>") 'yas-expand)
;;;(global-set-key (kbd "TAB") 'my-smart-tab)

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
