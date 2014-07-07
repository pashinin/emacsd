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

(req-package magit
  :bind ("C-s-g" . magit-status)
  :config
  (progn
    ;;(define-key global-map (kbd "C-s-g") 'magit-status)

    (setq magit-set-upstream-on-push t)
    (setq magit-status-buffer-switch-function 'switch-to-buffer)

    (req-package github-browse-file
      :bind ("<s-home>" . github-browse-file))
    ;;(global-set-key (kbd "<s-home>") 'github-browse-file)
    ))

;; `helm-ls-git' help
;; ==================
;; C-]  -  Switch full path / basename
(req-package helm-ls-git
  :commands helm-ls-git-ls
  :bind
  (("C-c C-g" . helm-ls-git-ls)
   ("s-]" . helm-ls-git-ls)))
;; (global-set-key (kbd "C-c C-g") 'helm-ls-git-ls)
;; (global-set-key (kbd "s-]") 'helm-ls-git-ls)
;; ;;(global-set-key (kbd "C-x C-d") 'helm-browse-project)



(provide 'init-git)
;;; init-git.el ends here
