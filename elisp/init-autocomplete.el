;; init-autocomplete --- Auto Completion
;;; Commentary:
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories
;;      (concat epy-install-dir "auto-complete/ac-dict"))
;;
;; Problems to fix:
;;  1. AC makes yasnippets not work
;;     We need to use TAB on Autocompletion only if have no snippets
;;     And maybe use popup for snippets.
;;; Code:

(require 'init-common)
(require 'auto-complete-config nil t)
;;(add-to-list 'ac-dictionary-directories (concat epy-install-dir "elpa-to-submit/auto-complete/dict/"))
(setq ac-dwim t)
;;(setq ac-dwim nil)
(setq ac-comphist-file (concat my-emacs-files-dir "ac-comphist.dat"))

(setq ac-auto-start t)
;;(setq ac-auto-start 4)  ; number of chars after to complete

;; Show AC 0.5 second later
(setq ac-auto-show-menu 0.0)
(setq ac-delay 0.1
      ac-quick-help-delay 0.5)

(setq ac-source-yasnippet nil)
(ac-config-default)

;; Set some colors for AC
(set-face-attribute 'ac-candidate-face nil   :background "#00222c" :foreground "light gray")
(set-face-attribute 'ac-selection-face nil   :background "SteelBlue4" :foreground "white")
(set-face-attribute 'popup-tip-face    nil   :background "#003A4E" :foreground "light gray")

(define-key ac-completing-map [tab] nil)
(define-key ac-completing-map [return] 'ac-complete)

;; resetting ac-sources
;; (ac-source-features ac-source-functions ac-source-yasnippet
;; ac-source-variables ac-source-symbols ac-source-abbrev
;; ac-source-dictionary ac-source-words-in-same-mode-buffers)

(setq-default ac-sources '(ac-source-semantic-raw
                           ac-source-features
                           ac-source-functions
                           ac-source-yasnippet
                           ac-source-variables
                           ac-source-symbols
                           ac-source-abbrev
                           ac-source-dictionary
                           ac-source-words-in-same-mode-buffers
                           ))
;;(setq-default ac-sources '(ac-source-semantic-raw))

;; Disabling Yasnippet completion
;;(defun epy-snips-from-table (table)
;;  (with-no-warnings
;;    (let ((hashtab (ac-yasnippet-table-hash table))
;;          (parent (ac-yasnippet-table-parent table))
;;          candidates)
;;      (maphash (lambda (key value)
;;                 (push key candidates))
;;               hashtab)
;;      (identity candidates)
;;      )))
;;
;;(defun epy-get-all-snips ()
;;  (require 'yasnippet) ;; FIXME: find a way to conditionally load it
;;  (let (candidates)
;;    (maphash
;;     (lambda (kk vv) (push (epy-snips-from-table vv) candidates)) yas/tables)
;;    (apply 'append candidates))
;;  )

;;(setq ac-ignores (concatenate 'list ac-ignores (epy-get-all-snips)))
;;
;;;; ropemacs Integration with auto-completion
;;(defun ac-ropemacs-candidates ()
;;  (mapcar (lambda (completion)
;;      (concat ac-prefix completion))
;;    (rope-completions)))
;;
;;(ac-define-source nropemacs
;;  '((candidates . ac-ropemacs-candidates)
;;    (symbol     . "p")))
;;
;;(ac-define-source nropemacs-dot
;;  '((candidates . ac-ropemacs-candidates)
;;    (symbol     . "p")
;;    (prefix     . c-dot)
;;    (requires   . 0)))
;;
;;(defun ac-nropemacs-setup ()
;;  (setq ac-sources (append '(ac-source-nropemacs
;;                             ac-source-nropemacs-dot) ac-sources)))
;;(defun ac-python-mode-setup ()
;;  (add-to-list 'ac-sources 'ac-source-yasnippet))
;;
;;(add-hook 'python-mode-hook 'ac-python-mode-setup)
;;(add-hook 'rope-open-project-hook 'ac-nropemacs-setup)

;;setup for auto-complete-yasnippet

;;(ac-set-trigger-key "TAB")
;;(ac-set-trigger-key "<tab>")

(provide 'init-autocomplete)
;;; init-autocomplete.el ends here
