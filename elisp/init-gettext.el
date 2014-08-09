;;; init-gettext --- po-mode for editing translations files (.po)
;;; Commentary:
;;; Code:

;; po-mode is part of the gettext suite available here.
;; http://www.gnu.org/software/gettext/

;; apt-get isntall gettext-el
;; /usr/share/emacs24/site-lisp/gettext/po-mode.elc

;; h - Help
;; n - Find next
;; p - Find prev
;; u - Find next untranslated
;; U - Find prev untranslated
;; k - Turn the current entry into an untranslated
;; Q - Quit processing and save the PO file

;;(req-package po-mode
;;  :po-mode
;;  :init
;;  (add-to-list 'auto-mode-alist '("\\.po\\'\\|\\.po\\." . po-mode)))
(require 'po-mode)
(add-to-list 'auto-mode-alist '("\\.po\\'\\|\\.po\\." . po-mode))
(defvar po-entry-type)
(defun po-fuzzy-toggle ()
  "Toggle the fuzzy attribute for the current entry."
  (interactive)
  (po-find-span-of-entry)
  (cond ((eq po-entry-type 'fuzzy)
         (po-decrease-type-counter)
         (po-delete-attribute "fuzzy")
         (po-maybe-delete-previous-untranslated)
         (po-current-entry)
         (po-increase-type-counter))
        (t
         (po-fade-out-entry)))
  (if po-auto-select-on-unfuzzy
      (po-auto-select-entry))
  (po-update-mode-line-string))

(progn
  (define-key po-mode-map (kbd "<down>") 'po-next-entry)
  (define-key po-mode-map (kbd "<up>") 'po-previous-entry)
  (define-key po-mode-map (kbd "<C-up>") 'po-previous-untranslated-entry)
  (define-key po-mode-map (kbd "<C-down>") 'po-next-untranslated-entry)
  (define-key po-subedit-mode-map (kbd "C-с C-с") 'po-subedit-exit)  ;; not Latin here
  (define-key po-mode-map (kbd "TAB") 'po-fuzzy-toggle))

(provide 'init-gettext)
;;; init-gettext.el ends here
