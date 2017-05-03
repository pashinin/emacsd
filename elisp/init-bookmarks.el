;;; init-bookmarks --- bookmarks to files and dirs
;;; Commentary:
;;; Code:

(require 'init-variables)
(require 'bm)

(setq bmkp-last-as-first-bookmark-file (concat my-emacs-files-dir "bookmarks"))
;; bookmarks
(defun my-bookmarks-list-same-buffer ()
  "Open *Bookmarks* in current buffer."
  (interactive)
  (bookmark-bmenu-list)
  (switch-to-buffer "*Bookmark List*"))
(global-set-key (kbd "s-b") 'my-bookmarks-list-same-buffer)

(global-set-key (kbd "<s-return>") 'bm-toggle)
(global-set-key (kbd "<s-next>")   'bm-next)
(global-set-key (kbd "<s-prior>")  'bm-previous)

(require 'bookmark+)

(provide 'init-bookmarks)
;;; init-bookmarks.el ends here
