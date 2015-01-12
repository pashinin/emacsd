;;; init-git --- Git config
;;; Commentary:
;;
;; C-s-g      `magit-status'
;; l l        short log
;; E          Rebase
;; M-n, M-p   reorder commits
;;
;; Windows (cygwin) has a bug (when using Magit "stash apply stash@{0}"):
;; it destroys brackets "{", "}" - so need to escape them
;; https://github.com/magit/magit/issues/522
;;
;;; Code:

(require 'req-package)

(req-package magit
  :bind ("C-s-g" . magit-status)
  :config
  (progn
    (setq magit-set-upstream-on-push t)
    (setq magit-status-buffer-switch-function 'switch-to-buffer)
    (req-package github-browse-file
      :bind ("<s-home>" . github-browse-file))
    ))

(req-package github-browse-file
  :bind ("<s-home>" . github-browse-file))

;; `helm-ls-git' help
;; ==================
;; C-]  -  Switch full path / basename
(req-package helm-ls-git
  :commands helm-ls-git-ls
  :bind
  (("C-c C-g" . helm-ls-git-ls)
   ("s-]" . helm-ls-git-ls)))


;(req-package helm-git-grep
;  :init
;  (global-set-key (kbd "C-c g") 'helm-git-grep))

(provide 'init-git)
;;; init-git.el ends here
