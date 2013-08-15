;;; init-shell-term --- description
;;; Commentary:
;;; Code:

(require 'multi-term)
;;(setq multi-term-program "/bin/bash")
(setq multi-term-program "/usr/bin/zsh")

;;;(custom-set-variables
;;; '(term-default-bg-color "#000000")        ;; background color (black)
;;; '(term-default-fg-color "#dddd00"))       ;; foreground color (yellow)
;;
;;;;(setq term-default-fg-color (face-foreground 'default))
;;;;(setq term-default-bg-color (face-background 'default))
;;;; term-default-fg-color' is an obsolete variable (as of 24.3); use the face `term' instead.
;;;(add-hook 'term-mode-hook
;;;		  (lambda ()
;;;			(global-set-key "\C-xc" 'term-line-mode)))

;;(defun my-toggle-term-mode ()
;;  (interactive)
;;  (if term-line-mode
;;  ;(if (and (boundp 'term-line-mode) term-line-mode)
;;	  (term-char-mode)
;;	(term-line-mode)))
;;(add-hook 'term-mode-hook (lambda()
;;							(global-set-key "\C-xc"
;;											'my-toggle-term-mode)))
(setq term-bind-key-alist
	  (list (cons "C-c C-c"   'term-interrupt-subjob)
			(cons "C-p"       'previous-line)
			(cons "C-n"       'next-line)
			(cons "M-f"       'term-send-forward-word)
			(cons "M-b"       'term-send-backward-word)
			(cons "C-c C-j"   'term-line-mode)
			(cons "C-c C-k"   'term-char-mode)
			(cons "M-DEL"     'term-send-backward-kill-word)
			(cons "M-d"       'term-send-forward-kill-word)
			(cons "<C-left>"  'term-send-backward-word)
			(cons "<C-right>" 'term-send-forward-word)
			(cons "C-r"       'term-send-reverse-search-history)
			(cons "M-p"       'term-send-raw-meta)
			(cons "M-y"       'term-send-raw-meta)
			(cons "C-y"       'term-send-raw)))

;; Term
;;(term-color-black ((,class (:background ,base02 :foreground ,base02))))
;;(term-color-blue ((,class (:background ,blue :foreground ,blue))))
;;(term-color-cyan ((,class (:background ,cyan :foreground ,cyan))))
;;(term-color-green ((,class (:background ,green :foreground ,green))))
;;(term-color-magenta ((,class (:background ,magenta :foreground ,magenta))))
;;(term-color-red ((,class (:background ,red :foreground ,red))))
;;(term-color-white ((,class (:background ,base2 :foreground ,base2))))
;;(term-color-yellow ((,class (:background ,yellow :foreground ,yellow))))

(provide 'init-shell-term)
;;; init-shell-term.el ends here
