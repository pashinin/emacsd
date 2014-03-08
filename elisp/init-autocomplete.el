;; init-autocomplete --- Auto Completion
;;; Commentary:
;; Manual - http://cx4a.org/software/auto-complete/manual.html
;;; Code:

(require 'init-common)
(require 'auto-complete-config nil t)
;;(add-to-list 'ac-dictionary-directories (concat epy-install-dir "elpa-to-submit/auto-complete/dict/"))

(setq
 ac-auto-start t  ;;(setq ac-auto-start 4)  ; number of chars after to complete
 ac-dwim t
 ac-comphist-file (concat my-emacs-files-dir "ac-comphist.dat")
 ac-auto-show-menu 0.0
 ac-delay 0.1
 ac-quick-help-delay 0.5
 ac-source-yasnippet nil
 )

(ac-config-default)

;; Set some colors for AC
(set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
(set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
(set-face-attribute 'popup-tip-face    nil   :background "#003A4E" :foreground "light gray")

(define-key ac-completing-map [tab] nil)               ; make yasnippets work on <tab>
(define-key ac-completing-map [return] 'ac-complete)   ; insert suggested on <enter>

(setq-default ac-sources
              '(ac-source-semantic-raw
                ac-source-features
                ac-source-functions
                ac-source-yasnippet
                ac-source-variables
                ac-source-symbols
                ac-source-abbrev
                ac-source-dictionary
                ac-source-words-in-same-mode-buffers
                ))

;;(add-hook 'css-mode-hook
;;          (lambda ()
;;            (make-local-variable 'ac-ignores)
;;            (add-to-list 'ac-ignores ";")))

(provide 'init-autocomplete)
;;; init-autocomplete.el ends here
