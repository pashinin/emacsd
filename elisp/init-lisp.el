;;; init-lisp.el --- created for testing `slime'
;;; Commentary:
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;
;; Install "sbcl" in your OS:
;; sudo apt-get install sbcl
;;
;; Then M-x slime
;;
;;; Code:

(require 'req-package)
;;(require 'slime)
;;;;(unload-feature 'slime)
;;(setq inferior-lisp-program (executable-find "sbcl")) ; your Lisp system
;;(add-to-list 'load-path "~/.slime") ; your SLIME directory

(req-package paxedit
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'paxedit-mode)
    (add-hook 'clojure-mode-hook 'paxedit-mode)
    (eval-after-load "paxedit"
      '(progn (define-key paxedit-mode-map (kbd "M-<right>") 'paxedit-transpose-forward)
              (define-key paxedit-mode-map (kbd "M-<left>") 'paxedit-transpose-backward)
              ;; (define-key paxedit-mode-map (kbd "M-<up>") 'paxedit-backward-up)
              ;; (define-key paxedit-mode-map (kbd "M-<down>") 'paxedit-backward-end)
              ;; (define-key paxedit-mode-map (kbd "M-b") 'paxedit-previous-symbol)
              ;; (define-key paxedit-mode-map (kbd "M-f") 'paxedit-next-symbol)
              (define-key paxedit-mode-map (kbd "C-%") 'paxedit-copy)
              (define-key paxedit-mode-map (kbd "C-&") 'paxedit-kill)
              (define-key paxedit-mode-map (kbd "C-*") 'paxedit-delete)
              (define-key paxedit-mode-map (kbd "C-^") 'paxedit-sexp-raise)
              (define-key paxedit-mode-map (kbd "M-u") 'paxedit-symbol-change-case)
              (define-key paxedit-mode-map (kbd "C-@") 'paxedit-symbol-copy)
              (define-key paxedit-mode-map (kbd "C-#") 'paxedit-symbol-kill)))))



;; LISP-mode - use spaces, autoindent
(when (require 'init-smarttabs nil 'noerror)
  (add-hook 'emacs-lisp-mode-hook 'my-smarttabs-spaces-autoinednt)
  (add-hook 'lisp-mode-hook       'my-smarttabs-spaces-autoinednt))

(provide 'init-lisp)
;;; init-lisp.el ends here
