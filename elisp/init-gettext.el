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

(require 'po-mode)
;;(autoload 'po-mode "po-mode"
;;  "Major mode for translators to edit PO files" t)
(setq auto-mode-alist (cons '("\\.po\\'\\|\\.po\\." . po-mode)
                            auto-mode-alist))
;;(autoload 'po-find-file-coding-system "po-compat")
;;(modify-coding-system-alist 'file "\\.po\\'\\|\\.po\\."
;;                            'po-find-file-coding-system)

(provide 'init-gettext)
;;; init-gettext.el ends here
