;;; init-windows-buffers --- movement, ido,...
;;; Commentary:
;;; Code:

;;(require 'init-ibuffer nil 'noerror)
;;(require 'init-ibuffer)
;; improve buffer switching (but really we will use Helm)

;; Ido mode with fuzzy matching
;;(require 'ido)
(when (require 'ido nil 'noerror)
  (ido-mode t)
  (setq ido-enable-flex-matching t) ;; enable fuzzy matching
  ;; IDO becomes very hectic when creating a new file. If you don't type the
  ;; new file name fast enough, it searches for existing files in other
  ;; directories with the same name and opens them instead. The following
  ;; setting disables that feature:
  (setq ido-auto-merge-work-directories-length -1))

;; Helm - choose buffer like a man
;; To configure colors: M-x customize-group <RET> helm <RET>
;;(require 'helm)
(if (require 'helm nil 'noerror)
    (progn
      (setq helm-idle-delay 0.1)
      (setq helm-input-idle-delay 0.1)
      (setq helm-c-locate-command "locate-with-mdfind %.0s %s")
      ;; do not list:
      ;;(loop for ext in '("\\.swf$" "\\.elc$" "\\.pyc$")
      ;;      do (add-to-list 'helm-c-boring-file-regexp-list ext))
      ;;(define-key global-map [(alt t)] 'helm-for-files)
      ;;(global-set-key (kbd "<C-x C-b>") 'helm-for-files)
      (global-set-key (kbd "C-x C-b") 'helm-mini)   ; usual Helm
      (global-set-key (kbd "<S-s-insert>") 'helm-show-kill-ring)
      ;; TODO: helm for GIT
      ;; colors:
      ;;(setq helm-candidate-number '((t (:background "deep sky blue" :foreground "black"))))
      ;;(set-face helm-selection        '(t (:foreground "black" :weight bold)))

      ;; To open Helm in any other way (in the same buffer) - edit
      ;; "helm-display-function" variable:
      ;; Open in the same buffer:
      (setq helm-display-function
            (lambda (buf)
              ;;(split-window-horizontally)
              ;;(other-window 1)
              (switch-to-buffer buf)))
  ))

;; Resize buffers
(when (require 'windsize nil 'noerror)
  ;; Resizes by 8 columns or 4 rows by default. Change that by setting
  (setq windsize-rows 1
        windsize-cols 1)
  (let ((prefix "<s-S"))
    (if (eq system-type 'windows-nt)
        (setq prefix "<M-S"))  ; change key prefix for Windows
      (global-set-key (kbd (concat prefix "-left>"))  'windsize-left)
      (global-set-key (kbd (concat prefix "-right>")) 'windsize-right)
      (global-set-key (kbd (concat prefix "-up>"))    'windsize-up)
      (global-set-key (kbd (concat prefix "-down>"))  'windsize-down)))


;;(require 'buffer-move)
(when (require 'windsize nil 'noerror)
  (global-set-key (kbd "<C-S-s-up>")     'buf-move-up)
  (global-set-key (kbd "<C-S-s-down>")   'buf-move-down)
  (global-set-key (kbd "<C-S-s-left>")   'buf-move-left)
  (global-set-key (kbd "<C-S-s-right>")  'buf-move-right))

(provide 'init-windows-buffers)
;;; init-windows-buffers.el ends here
