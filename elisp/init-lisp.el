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

;;(require 'slime)
;;;;(unload-feature 'slime)
;;(setq inferior-lisp-program (executable-find "sbcl")) ; your Lisp system
;;(add-to-list 'load-path "~/.slime") ; your SLIME directory


;; LISP-mode - use spaces, autoindent
(when (require 'init-smarttabs nil 'noerror)
  (add-hook 'emacs-lisp-mode-hook 'my-smarttabs-spaces-autoinednt)
  (add-hook 'lisp-mode-hook       'my-smarttabs-spaces-autoinednt))

(provide 'init-lisp)
;;; init-lisp.el ends here
