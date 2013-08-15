;;; init-smarttabs --- Smarttabs config
;;; Commentary:
;; https://github.com/jcsalomon/smarttabs
;;; Code:

(require 'smart-tab)
(global-smart-tab-mode 1)
;;(autoload 'smart-tabs-mode "smart-tabs-mode"
;;  "Intelligently indent with tabs, align with spaces!")
;;(autoload 'smart-tabs-mode-enable "smart-tabs-mode")
;;(autoload 'smart-tabs-advice "smart-tabs-mode")

;;(setq cua-auto-tabify-rectangles nil)
;; Exceptions (no smarttabs here):
(add-to-list 'smart-tab-disabled-major-modes 'shell-mode)
(add-to-list 'smart-tab-disabled-major-modes 'eshell-mode)
(add-to-list 'smart-tab-disabled-major-modes 'org-agenda-mode)

(setq-default indent-tabs-mode nil)  ; spaces are better
(setq-default tab-width 4)

(defun my-smarttabs-spaces-autoinednt ()
  "Make current mode use spaces for indentation and indent on RET.
Used in hooks."
  (interactive)
  (smart-tabs-mode-enable)
  (setq indent-tabs-mode nil)
  (local-set-key (kbd "RET") 'newline-and-indent)
  ;;(define-key org-mode-map "\C-m" 'newline-and-indent)  ; auto indent
  )

(defun my-smarttabs-tabs-autoinednt ()
  "Make current mode use tabs for indentation and indent on RET.
Used in hooks."
  (interactive)
  (smart-tabs-mode-enable)
  (setq indent-tabs-mode t)
  (local-set-key (kbd "RET") 'newline-and-indent)
  ;;(define-key org-mode-map "\C-m" 'newline-and-indent)  ; auto indent
  )



;;; smart-tabs
;;(require 'smart-tab)
;; for python
;(smart-tabs-advice python-indent-line-function python-indent)
;;(smart-tabs-advice python-indent-line python-indent)
;;(smart-tabs-advice python-indent-region python-indent)
;;(smart-tabs-advice python-indent- python-indent)

;; http://stackoverflow.com/questions/6679625/how-to-make-emacs-python-mode-generate-tabs-for-indent

;;(smart-tabs-advice python-indent-line-1 python-indent)

;; Note that it might be preferable to delay calling smart-tabs-advice
;; until after the major mode is loaded and evaluated:
(add-hook 'python-mode-hook
          (lambda ()
            (smart-tabs-mode-enable)
            (smart-tabs-advice  python-indent-line-1   python-indent-line-1)
            ;;(smart-tabs-advice  python-indent-line-1   python-indent)
            (smart-tabs-advice  py-indent-line         py-indent-offset)
            (smart-tabs-advice  py-newline-and-indent  python-indent-line-1)
            ;;(smart-tabs-advice  py-newline-and-indent  py-indent-line)
            (smart-tabs-advice  py-indent-region       py-indent-offset)
            ;;(smart-tabs-advice  py-
            (setq indent-tabs-mode nil) ; nil - use spaces, t - tabs
            ;;(setq tab-width 4)
            ;;(set-variable 'py-indent-offset 4)
            ;;(setq python-indent 4)
            (setq python-indent-offset 4)
            ;;(set-variable 'py-smart-indentation t)
            (setq tab-width (default-value 'tab-width))
            (define-key python-mode-map "\C-m" 'newline-and-indent)
            ))


;;-----------------------------------------------------
;; C++
(require 'cc-vars)
(require 'cc-mode)
;; styles: cc-mode, BSD, Ellemtel
;;(if (string-match path (buffer-file-name))
;;                                 (c-set-style "linux"))
;;(smart-tabs-advice  c-indent-line    c-basic-offset)
;;(smart-tabs-advice  c-indent-region  c-basic-offset)
(setq-default c-default-style "cc-mode"
              c-basic-offset 4
              backward-delete-function nil) ; DO NOT expand tabs when deleting

(defun my-c-mode-hook ()
  "Set some C style params."
  (interactive)
  (c-set-style "my-c-style")
  (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
  (c-set-offset 'inline-open '+)
  (c-set-offset 'block-open '+)
  (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
  (c-set-offset 'case-label '+)       ; indent case labels by c-indent-level, too
  (setq c-basic-offset 4)
  ;;c-basic-indent 4 )
  ;;(c-set-offset 'substatement-open 0) ; do not tab for cycles
  ;;(setq indent-tabs-mode nil)  ; use Tabs? - no!
  ;;(local-set-key (kbd "RET") 'newline-and-indent)
  (define-key c-mode-base-map "/" 'self-insert-command)  ;; do not break tabs when comment
  (define-key c-mode-base-map "*" 'self-insert-command)
  )

(add-hook 'c-mode-common-hook 'my-smarttabs-spaces-autoinednt)
(add-hook 'c-mode-hook        'my-smarttabs-spaces-autoinednt)
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;;----------------------------------------------------
;; HTML
;;(smart-tabs-advice  c-indent-line    c-basic-offset)
;;(smart-tabs-advice  c-indent-region  c-basic-offset)
(defun myHtmlStyle ()
  "Set smarttabs html parameters."
  (smart-tabs-mode-enable)
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  (local-set-key (kbd "RET") 'newline-and-indent)
  )

(add-hook 'html-mode-hook   'myHtmlStyle)
(add-hook 'nxhtml-mode-hook 'myHtmlStyle)
(add-hook 'nxml-mode        'myHtmlStyle)
(add-hook 'css-mode-hook    'myHtmlStyle)
(add-hook 'php-mode-hook    'myHtmlStyle)
;;(add-hook 'web-mode-hook    'myHtmlStyle)

;; Javascript
(add-hook 'js2-mode-hook        'my-smarttabs-tabs-autoinednt)

;; shell scripts
;;(add-hook 'shell-mode-hook      'my-smarttabs-tabs-autoinednt)

;; org-mode - use spaces, autoindent
(add-hook 'org-mode-hook        'my-smarttabs-spaces-autoinednt)

;; LaTeX
(add-hook 'LaTeX-mode-hook      'my-smarttabs-spaces-autoinednt)

;; LISP-mode - use spaces, autoindent
(add-hook 'emacs-lisp-mode-hook 'my-smarttabs-spaces-autoinednt)
(add-hook 'lisp-mode-hook       'my-smarttabs-spaces-autoinednt)


;;----------------------------------------
;; COOL FEATURES

;; In TextMate, pasted lines are automatically indented, which is extremely
;; time-saving. This should be fairly straightforward to implement in Emacs,
;; but how?
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                                     clojure-mode    scheme-mode
                                                     haskell-mode    ruby-mode
                                                     rspec-mode      python-mode
                                                     c-mode          c++-mode
                                                     objc-mode       latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))



(provide 'init-smarttabs)
;;; init-smarttabs.el ends here
