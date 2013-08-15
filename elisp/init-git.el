;;; init-git --- Git config
;;; Commentary:
;;; Code:

;;(autoload 'magit-status "magit" nil t)
(require 'magit)
(define-key global-map "\C-xg" 'magit-status)

(setq ediff-prefer-iconified-control-frame nil)  ; these 2 are for magit merge help
(setq ediff-prefer-long-help-message t)          ; window not to shrink to 1 column


(setq ediff-split-window-function (if (> (frame-width) 150)
                                      'split-window-horizontally
                                    'split-window-vertically))
(setq magit-set-upstream-on-push t)

;; windows shell has a bug (when using Magit "stash apply stash@{0}"):
;; it destroys brackets "{", "}" - so need to escape them
;; https://github.com/magit/magit/issues/522
(if (eq system-type 'windows-nt)
    (defadvice magit-run-git (before magit-run-git-win-curly-braces (&rest args) activate)
      "Escape {} on Windows"
      (setcar (nthcdr 2 args)
              (replace-regexp-in-string "{\\([0-9]+\\)}" "\\\\{\\1\\\\}" (elt args 2)))))

;;(defun my-magit-rebase-mode ()
;;  ""
;;  (interactive)
;;  (local-set-key (kbd "M-f") 'newline-and-indent)
;;  (local-set-key (kbd "M-b") 'newline-and-indent))

(provide 'init-git)
;;; init-git.el ends here
