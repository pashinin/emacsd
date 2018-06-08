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

;; (req-package smart-tab
;;   :bind ("TAB" . smart-tab)
;;   :config
;;   (progn
;;     (setq smart-tab-using-hippie-expand t)
;;     ;; (add-to-list 'smart-tab-disabled-major-modes 'markdown-mode)
;;     (global-smart-tab-mode t)
;;     ;; (delete 'markdown-mode 'smart-tab-disabled-major-modes)
;;     (setq smart-tab-using-hippie-expand t)))

(defun markdown-indent-line ()
  "Indent the current line using some heuristics.
If the _previous_ command was either `markdown-enter-key' or
`markdown-cycle', then we should cycle to the next
reasonable indentation position.  Otherwise, we could have been
called directly by `markdown-enter-key', by an initial call of
`markdown-cycle', or indirectly by `auto-fill-mode'.  In
these cases, indent to the default position.
Positions are calculated by `markdown-calc-indents'."
  (interactive)
  (let ((positions (markdown-calc-indents))
        (cur-pos (current-column)))
    (if (equal this-command 'newline-and-indent)
        (progn
          (indent-line-to (markdown-cur-line-indent))
          ;; (indent-line-to 4)
          )
      (if (not (equal this-command 'markdown-cycle))
          (indent-line-to (car positions))
        (setq positions (sort (delete-dups positions) '<))
        (indent-line-to
         (markdown-indent-find-next-position cur-pos positions))))))

;; (markdown-indent-find-next-position (current-column) (markdown-calc-indents))
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
  (setq indent-tabs-mode nil)
  (make-local-variable 'tab-width)
  (setq tab-width 2)
  ;;(setq css-indent-offset 2)
  (setq css-indent-offset 2)
  (local-set-key (kbd "RET") 'newline-and-indent))



(add-hook 'css-mode-hook    'myHtmlStyle)

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
                                          plain-tex-mode  js3-mode js2-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))


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

(req-package yasnippet
  :ensure t
  :commands yas-global-mode
  :init
  (progn
    ;; (push 'yas-installed-snippets-dir yas-snippet-dirs)
    ;;yas-installed-snippets-dir
    (setq yas-prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/x-prompt))
    ;;(setq yas-wrap-around-region 'cua)
    (setq yas-wrap-around-region nil
          yas-fallback-behavior 'call-other-command            ; call-other-command nil
          )
    (setq yas-indent-line t)
    ;;(yas-global-mode 1)


    (req-package hippie-exp
      :init
      (progn
        ;;(add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand)
        (setq hippie-expand-try-functions-list
              '(;;smart-tab
                yas/hippie-try-expand
                try-expand-dabbrev
                try-expand-dabbrev-all-buffers
                try-expand-dabbrev-from-kill
                try-complete-file-name
                try-complete-lisp-symbol))))

    ;; Try to expand yasnippet snippets based on prefix
    (push 'yas-hippie-try-expand hippie-expand-try-functions-list)


    ;;(yas-reload-all)
    ;; Fixing a problem
    (defun my-smart-tab ()
      "Do `yas-expand' only if on text, else - `smart-tab'."
      (interactive)
      (if (looking-back "[\n ]" 1)
          (smart-tab)
        (yas-expand)))

    ;;(global-set-key (kbd "TAB") 'my-smart-tab)
    (yas-global-mode 1)
    ))

;;(yas-global-mode 1)


(provide 'init-tab)
;;; init-tab.el ends here
