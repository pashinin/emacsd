;;; init-  --- description
;;; Commentary:
;;; Code:

;; po-mode is part of the gettext suite available here.
;; http://www.gnu.org/software/gettext/

;; apt-get isntall gettext-el
;; /usr/share/emacs24/site-lisp/gettext/po-mode.elc

(require 'po-mode)
(autoload 'po-mode "po-mode"
  "Major mode for translators to edit PO files" t)
(setq auto-mode-alist (cons '("\\.po\\'\\|\\.po\\." . po-mode)
                            auto-mode-alist))
(autoload 'po-find-file-coding-system "po-compat")
(modify-coding-system-alist 'file "\\.po\\'\\|\\.po\\."
                            'po-find-file-coding-system)

(provide 'init-gettext)
;;; init-gettext.el ends here
