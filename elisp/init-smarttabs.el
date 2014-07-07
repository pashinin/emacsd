;;; init-smarttabs --- Smarttabs config
;;; Commentary:
;; https://github.com/jcsalomon/smarttabs
;; Tabs or spaces?
;;; Code:

(setq-default indent-tabs-mode nil)  ; spaces are better
(setq-default tab-width 4)

(req-package smart-tab
  :bind ("TAB" . smart-tab)
  :config
  (progn
    (setq smart-tab-using-hippie-expand t)
    (global-smart-tab-mode t)
    (setq smart-tab-using-hippie-expand t)))

;;(req-package smart-tabs-mode)


;; Exceptions:
;;(add-to-list 'smart-tab-disabled-major-modes 'shell-mode)
;;(add-to-list 'smart-tab-disabled-major-modes 'eshell-mode)
;;(add-to-list 'smart-tab-disabled-major-modes 'org-agenda-mode)
;;(add-to-list 'smart-tab-disabled-major-modes 'python-mode)
;;(add-to-list 'smart-tab-disabled-major-modes 'coffee-mode)
;;smart-tab-disabled-major-modes
;; (delete 'coffee-mode 'smart-tab-disabled-major-modes)


(defun my-smarttabs-spaces-autoinednt ()
  "Make current mode use spaces for indentation and indent on RET."
  (interactive)
  (smart-tabs-mode-enable)
  (setq indent-tabs-mode nil)
  (local-set-key (kbd "RET") 'newline-and-indent))

(defun my-smarttabs-tabs-autoinednt ()
  "Make current mode use tabs for indentation and indent on RET."
  (interactive)
  (smart-tabs-mode-enable)
  (setq indent-tabs-mode t)
  (local-set-key (kbd "RET") 'newline-and-indent))

(defun myHtmlStyle ()
  "Set smarttabs for HTML / js / css."
  (smart-tabs-mode-enable)
  (setq indent-tabs-mode t)
  (make-local-variable 'tab-width)
  (setq tab-width 2)
  (setq css-indent-offset 2)
  (local-set-key (kbd "RET") 'newline-and-indent))


;; Automatically indent pasted lines in these modes
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode
                        '(emacs-lisp-mode lisp-mode
                                          clojure-mode    scheme-mode
                                          haskell-mode    ruby-mode
                                          rspec-mode      ;; python-mode
                                          scss-mode       css-mode
                                          ;;c-mode          c++-mode
                                          objc-mode       latex-mode
                                          plain-tex-mode  js3-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))


;;function to implement a smarter TAB (EmacsWiki)
(defun smart-tab2 ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (hippie-expand nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (if (looking-at "\\_>")
          ;;(hippie-expand nil)
          (yas-expand)
        ;;(if (looking-back "[\n ]" 1)
        (smart-tab-default)
        ;;(yas-expand))
        )))  ;; (indent-for-tab-command)
  )

;;(global-set-key (kbd "TAB") 'smart-tab)


(provide 'init-smarttabs)
;;; init-smarttabs.el ends here
