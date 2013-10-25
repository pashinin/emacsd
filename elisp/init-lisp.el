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

(require 'slime)
;;(unload-feature 'slime)
(setq inferior-lisp-program (executable-find "sbcl")) ; your Lisp system
(add-to-list 'load-path "~/.slime") ; your SLIME directory

(provide 'init-lisp)
;;; init-lisp.el ends here
