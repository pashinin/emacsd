;;; init-navigation --- Tools for navigation
;;; Commentary:
;;
;; By navigation I mean language specific names like function and
;; variables. For searching text or file names - see `init-search.el'
;;
;;; Code:

(require 'req-package)

;; For Elisp
;; https://github.com/purcell/elisp-slime-nav
(req-package elisp-slime-nav
  :init
  ;; elisp-slime-nav-mode-map
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'turn-on-elisp-slime-nav-mode)))

(req-package ctags
  :bind ("<f7>" . ctags-create-or-update-tags-table)
  :init
  (setq path-to-ctags my-emacs-files-dir  ;; <- your ctags path here
        tags-revert-without-query t))
;;(global-set-key (kbd "<f7>") 'ctags-create-or-update-tags-table)

(req-package etags
  :bind (("C-." . find-tag)
         ("M-." . pop-tag-mark)))
;;(global-set-key (kbd "C-.") 'find-tag)
;;(global-set-key (kbd "M-.") 'pop-tag-mark)






(provide 'init-navigation)
;;; init-navigation.el ends here
