;; init-autocomplete --- Auto Completion
;;; Commentary:
;; Extensions: "auto-complete", "company". Use 2nd (easier)
;; http://company-mode.github.io/
;;
;; Company doesn't have a way to show documentation in a popup. Instead
;; you see the first line of the docstring in the echo area, and you can
;; press <f1> to pop up a window with documentation.
;;
;;; Code:

(require 'init-common)
(require 'req-package)

(req-package company
  :init
  (progn
    (global-company-mode)
    ))

;;(setq company-auto-complete t)



;; (req-package auto-complete
;;   :commands ac-complete ac-config-default
;;   :init
;;   (progn
;;     (setq
;;      ac-auto-start t  ;;(setq ac-auto-start 4)  ; number of chars after to complete
;;      ;;ac-dwim t
;;      ;;ac-comphist-file (concat my-emacs-files-dir "ac-comphist.dat")
;;      ac-comphist-file "/tmp/ac-comphist.dat"
;;      ac-auto-show-menu 0.0
;;      ac-delay 0.1
;;      ac-quick-help-delay 0.1
;;      ;;ac-source-yasnippet nil
;;      ;;ac-source-yasnippet t
;;      )
;;     (ac-config-default)
;; )
;;   :config
;;   (progn
;;     ;;(add-to-list 'ac-dictionary-directories (concat epy-install-dir "elpa-to-submit/auto-complete/dict/"))

;;     ;; Set some colors for AC
;;     (set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
;;     (set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
;;     (set-face-attribute 'popup-tip-face    nil   :background "#003A4E" :foreground "light gray")

;;     ;;(define-key ac-completing-map [tab] nil)               ; make yasnippets work on <tab>
;;     ;;(define-key ac-completing-map [return] 'ac-complete)   ; insert suggested on <enter>
;;     (add-to-list 'ac-modes 'scss-mode)
;;     ;; Default sources (for all modes):
;;     (setq-default ac-sources
;;                   '(ac-source-yasnippet
;;                     ac-source-semantic-raw
;;                     ac-source-features
;;                     ;;ac-source-functions
;;                     ;;ac-source-variables
;;                     ;;ac-source-symbols
;;                     ac-source-abbrev
;;                     ac-source-dictionary
;;                     ac-source-words-in-same-mode-buffers
;;                     ))
;;     ))

;(req-package ac-helm
;  :init
;  (progn
;    (global-set-key (kbd "C-:") 'ac-complete-with-helm)
;    (define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)))



;;(add-hook 'css-mode-hook
;;          (lambda ()
;;            (make-local-variable 'ac-ignores)
;;            (add-to-list 'ac-ignores ";")))

(provide 'init-autocomplete)
;;; init-autocomplete.el ends here
