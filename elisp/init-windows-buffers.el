;;; init-windows-buffers --- movement, ido,...
;;; Commentary:
;;; Code:

;; Ido mode with fuzzy matching
(require 'req-package)
(require 'ido)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; IDO becomes very hectic when creating a new file. If you don't
;; type the new file name fast enough, it searches for existing
;; files in other directories with the same name and opens them
;; instead. The following setting disables that feature:
(setq ido-auto-merge-work-directories-length -1)
(defun my-ido-setup-hook ()
  (define-key
    ido-buffer-completion-map
    " "
    'ido-restrict-to-matches))
(add-hook 'ido-setup-hook 'my-ido-setup-hook)
(ido-mode 1)

(req-package ido-vertical-mode
  :require ido
  :config
  (progn
    (ido-vertical-mode 1)))




;; Resize buffers
;; Resizes by 8 columns or 4 rows by default. Change that by setting
(req-package windsize
  :config
  (progn
    (setq windsize-rows 1
          windsize-cols 1)
    (let ((prefix "<s-S"))
      (if (eq system-type 'windows-nt)
          (setq prefix "<M-S"))  ; change key prefix for Windows
      (global-set-key (kbd (concat prefix "-left>"))  'windsize-left)
      (global-set-key (kbd (concat prefix "-right>")) 'windsize-right)
      (global-set-key (kbd (concat prefix "-up>"))    'windsize-up)
      (global-set-key (kbd (concat prefix "-down>"))  'windsize-down)))
  )


(req-package buffer-move
  :bind (("<C-S-s-up>" . buf-move-up)
	 ("<C-S-s-down>" . buf-move-down)
	 ("<C-S-s-left>" . buf-move-left)
	 ("<C-S-s-right>" . buf-move-right)))

(provide 'init-windows-buffers)
;;; init-windows-buffers.el ends here
