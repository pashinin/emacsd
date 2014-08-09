;;; init-tab.el --- TAB
;;; Commentary:
;;
;; TAB key does "autocomplete", "smarttab" and "yasnippets"
;;
;; https://github.com/jcsalomon/smarttabs
;;
;;; Code:

(require 'req-package)

(setq-default indent-tabs-mode nil)  ; spaces are better
(setq-default tab-width 4)

(req-package smart-tab
  :bind ("TAB" . smart-tab)
  :config
  (progn
    (setq smart-tab-using-hippie-expand t)
    (global-smart-tab-mode t)
    (setq smart-tab-using-hippie-expand t)))

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
  (smart-tabs-mode-enable)
  (setq indent-tabs-mode nil)
  (local-set-key (kbd "RET") 'newline-and-indent))

(defun my-smarttabs-tabs-autoinednt ()
  "Make current mode use tabs for indentation and indent on RET."
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
;;(defun smart-tab2 ()
;;  "This smart tab is minibuffer compliant: it acts as usual in
;;    the minibuffer. Else, if mark is active, indents region. Else if
;;    point is at the end of a symbol, expands it. Else indents the
;;    current line."
;;  (interactive)
;;  (if (minibufferp)
;;      (unless (minibuffer-complete)
;;        (hippie-expand nil))
;;    (if mark-active
;;        (indent-region (region-beginning)
;;                       (region-end))
;;      (if (looking-at "\\_>")
;;          ;;(hippie-expand nil)
;;          (yas-expand)
;;        ;;(if (looking-back "[\n ]" 1)
;;        (smart-tab-default)
;;        ;;(yas-expand))
;;        )))  ;; (indent-for-tab-command)
;;  )
;;(global-set-key (kbd "TAB") 'smart-tab)






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

(require 'req-package)

(req-package yasnippet
  :commands yas-global-mode
  :init
  (progn
    (setq yas-prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/x-prompt))
    ;;(setq yas-wrap-around-region 'cua)
    (setq yas-wrap-around-region nil
          yas-fallback-behavior 'call-other-command            ; call-other-command nil
          )
    (setq yas-indent-line nil)
    ;;(yas-global-mode 1)

    (req-package hippie-exp
      :init
      (progn
        (add-to-list 'hippie-expand-try-functions-list
                     'yas/hippie-try-expand)))

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
    ;;(define-key yas-minor-mode-map (kbd "<the new key>") 'yas-expand)
    (global-set-key (kbd "TAB") 'my-smart-tab)
    ))

(yas-global-mode 1)


(provide 'init-tab)
;;; init-tab.el ends here