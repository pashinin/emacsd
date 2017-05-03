;;; init-cpp.el --- C/C++
;;; Commentary:
;; Copyright (C) Sergey Pashinin
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;
;; apt-get install global
;;
;;; Code:

;; (require 'init-smarttabs)
;;-----------------------------------------------------
;; C++
(require 'cc-vars)
(require 'cc-mode)
(require 'my-cpp)

(setq-default c-indent-tabs-mode t     ; Pressing TAB should cause indentation
              c-indent-level 4         ; A TAB is equivilent to four spaces
              c-argdecl-indent 0       ; Do not indent argument decl's extra
              c-tab-always-indent t
              backward-delete-function nil
              c-default-style "cc-mode"
              c-basic-offset 4)

(defconst my-c-lineup-maximum-indent 30)

;; If a statement continues on the next line, indent the continuation by 4
(c-add-style "my-c-style" '((c-continued-statement-offset 4)))

(defun my-c-mode-hook ()
  "Set some C style params."
  (interactive)
  (c-set-style "my-c-style")  ; cc-mode, BSD, Ellemtel, linux
  ;;(if (string-match path (buffer-file-name))
  ;;                                 (c-set-style "linux"))
  (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
  (c-set-offset 'case-label '+)        ; indent case labels by c-indent-level, too

  (c-set-offset 'inline-open '+)
  (c-set-offset 'block-open '+)
  (c-set-offset 'brace-list-open '+)   ; all "opens" should be indented by the c-indent-level
  (setq c-basic-offset 4)
  (define-key c-mode-base-map "/" 'self-insert-command)  ;; do not break tabs when comment
  (define-key c-mode-base-map "*" 'self-insert-command)
  (local-set-key (kbd "RET") 'newline-and-indent)

  (c-set-offset 'arglist-intro '+)
  (c-toggle-auto-newline 1)
  )

(define-key c-mode-map (kbd "M-s-s") 'helm-gtags-find-tag)

;;(add-hook 'c-mode-hook        'my-smarttabs-spaces-autoinednt)
;;(add-hook 'c++-mode-hook      'my-smarttabs-spaces-autoinednt)
;;(add-hook 'c-mode-common-hook 'my-c-mode-hook)
;;(add-hook 'c++-mode-hook      'my-c-mode-hook)


(provide 'init-cpp)
;;; init-cpp.el ends here
