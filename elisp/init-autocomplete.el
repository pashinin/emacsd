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
(setq ac-comphist-file (concat my-emacs-files-dir "ac-comphist.dat"))

(setq ac-auto-start t)
;;(setq ac-auto-start 4)  ; number of chars after to complete
;;(setq ac-auto-show-menu t)
;;(setq ac-auto-show-menu 0.8)  ; Show 0.8 second later

;; TAB
;;(custom-set-variables
;; '(ac-trigger-key "TAB")
;; '(ac-auto-start nil)
;; '(ac-use-menu-map t))

(ac-config-default)

;; custom keybindings to use tab, enter and up and down arrows
;;(define-key ac-complete-mode-map "\t" 'ac-expand)
;;(define-key ac-complete-mode-map "\t" 'ac-expand)
;;(define-key ac-complete-mode-map "\r" 'ac-complete)
;;(define-key ac-complete-mode-map "\M-n" 'ac-next)
;;(define-key ac-complete-mode-map "\M-p" 'ac-previous)
;;(define-key ac-mode-map (kbd "C-TAB") 'auto-complete)
;;(define-key ac-mode-map (kbd "C-TAB") 'auto-expand)
;;(global-set-key "\M-/" 'auto-complete)

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
;;
;;;;(setq ac-ignores (concatenate 'list ac-ignores (epy-get-all-snips)))
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
