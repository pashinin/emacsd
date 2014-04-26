;;; init-git --- Git config
;;; Commentary:
;;
;; l l - short log
;; E - Rebase
;; M-n, M-p - reorder commits
;;
;; Windows (cygwin) has a bug (when using Magit "stash apply stash@{0}"):
;; it destroys brackets "{", "}" - so need to escape them
;; https://github.com/magit/magit/issues/522
;;
;;; Code:

(require 'magit)
(define-key global-map (kbd "C-s-g") 'magit-status)

(setq magit-set-upstream-on-push t)
(setq magit-status-buffer-switch-function 'switch-to-buffer)

(require 'github-browse-file)
(global-set-key (kbd "<s-home>") 'github-browse-file)


(require 'helm-ls-git)
(global-set-key (kbd "C-c C-g") 'helm-ls-git-ls)
(global-set-key (kbd "s-]") 'helm-ls-git-ls)
;;(global-set-key (kbd "C-x C-d") 'helm-browse-project)


(provide 'init-git)
;;; init-git.el ends here
