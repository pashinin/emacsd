;;; init-bookmarks --- bookmarks to files and dirs
;;; Commentary:
;;; Code:

(require 'init-variables)
(require 'bm)
;;(require 'bookmark+-1)

(setq bmkp-last-as-first-bookmark-file (concat my-emacs-files-dir "bookmarks"))
;; bookmarks
(defun my-bookmarks-list-same-buffer ()
  "Open *Bookmarks* in current buffer."
  (interactive)
  (bookmark-bmenu-list)
  (switch-to-buffer "*Bookmark List*"))
(global-set-key (kbd "s-b") 'my-bookmarks-list-same-buffer)

(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

(provide 'init-bookmarks)
;;; init-bookmarks.el ends here
