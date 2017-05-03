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

(setq magit-auto-revert-mode nil)
(req-package magit
  :bind ("C-s-g" . magit-status)
  :init
  (progn
    (setq
     magit-push-always-verify    nil
     magit-auto-revert-mode      nil
     magit-set-upstream-on-push  t
     magit-commit-show-diff      nil
     magit-display-buffer-function 'magit-display-buffer-traditional)
    ;; (setq magit-display-buffer-function '(switch-to-buffer))
    ;; (setq magit-last-seen-setup-instructions "1.4.0")

    ;; (setq magit-section-movement-hook '(magit-hunk-set-window-start magit-log-maybe-update-revision-buffer magit-log-maybe-show-more-commits))

    (req-package github-browse-file
      :bind ("<s-home>" . github-browse-file))
    )

  :config
  ;; Redefine display function to show magit-status in fullscreen
  (defun magit-display-buffer-traditional (buffer)
    "Display BUFFER the way this has traditionally been done."
    (display-buffer-same-window
     buffer (if (and (derived-mode-p 'magit-mode)
                     (not (memq (with-current-buffer buffer major-mode)
                                '(magit-process-mode
                                  magit-revision-mode
                                  magit-diff-mode
                                  magit-stash-mode
                                  magit-status-mode))))
                '(display-buffer-same-window)
              nil))))



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


(req-package helm-git-grep
  :init
  ;; (global-set-key (kbd "C-c g") 'helm-git-grep)
  (global-set-key (kbd "C-c g") 'helm-git-grep-at-point)
  (setq helm-git-grep-candidate-number-limit 500)
  (setq max-specpdl-size 3000)
  (defun helm-git-grep-args (exclude-file-pattern)
    "Create arguments of `helm-git-grep-process' in `helm-git-grep'."
    (delq nil
          (append
           (list "--no-pager" "grep" "--full-name" "-n" "--no-color"
                 (if helm-git-grep-ignore-case "-i" nil)
                 (helm-git-grep-showing-leading-and-trailing-lines-option))
           (nbutlast
            (apply 'append
                   (mapcar
                    (lambda (x) (list "-e" x "--and"))
                    (split-string helm-pattern " +" t))))
           (when exclude-file-pattern exclude-file-pattern))))
  )

(provide 'init-git)
;;; init-git.el ends here
