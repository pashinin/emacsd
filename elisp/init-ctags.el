;;; init-ctags --- description
;;; Commentary:
;;; Code:

(req-package ctags
  :bind ("<f7>" . ctags-create-or-update-tags-table)
  :init
  (setq path-to-ctags my-emacs-files-dir  ;; <- your ctags path here
        tags-revert-without-query t))
;;(global-set-key (kbd "<f7>") 'ctags-create-or-update-tags-table)

;; I got "Error creating TAGS"
;; just moved to parent dir and it's ok

(req-package etags
  :bind (("C-." . find-tag)
         ("M-." . pop-tag-mark)))
;;(global-set-key (kbd "C-.") 'find-tag)
;;(global-set-key (kbd "M-.") 'pop-tag-mark)

(provide 'init-ctags)
;;; init-ctags.el ends here
