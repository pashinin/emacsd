;;; init-windows-buffers --- movement, ido,...
;;; Commentary:
;;; Code:

;; Ido mode with fuzzy matching
;;(require 'ido)
(when (require 'ido nil 'noerror)
  (require 'ido-vertical-mode)


  (setq ido-enable-flex-matching t) ;; enable fuzzy matching
  ;; IDO becomes very hectic when creating a new file. If you don't type the
  ;; new file name fast enough, it searches for existing files in other
  ;; directories with the same name and opens them instead. The following
  ;; setting disables that feature:
  (setq ido-auto-merge-work-directories-length -1)
  (defun my-ido-setup-hook ()
    (define-key
      ido-buffer-completion-map
      " "
      'ido-restrict-to-matches))

  (add-hook 'ido-setup-hook 'my-ido-setup-hook)

  (ido-mode 1)
  (ido-vertical-mode 1)
  )

;; Helm - choose buffer like a man
;; To configure colors: M-x customize-group <RET> helm <RET>
(defun my-helm-do-grep ()
  "Grep recursively."
  (interactive)
  (helm-do-grep-1 `(,default-directory)
                  '(4)
                  nil
                  '("*.*")
                  ;;'("*.clj" "*.cljs")
                  ))


(when (require 'helm nil 'noerror)
  (setq helm-idle-delay 0.1
        helm-input-idle-delay 0.1
        helm-ff-transformer-show-only-basename nil     ;; show full path, need for helm-ls-git
        helm-c-locate-command "locate-with-mdfind %.0s %s")
  ;; do not list:
  ;;(loop for ext in '("\\.swf$" "\\.elc$" "\\.pyc$")
  ;;      do (add-to-list 'helm-c-boring-file-regexp-list ext))
  ;;(define-key global-map [(alt t)] 'helm-for-files)
  ;;(global-set-key (kbd "<C-x C-b>") 'helm-for-files)
  (global-set-key (kbd "C-x C-b") 'helm-mini)   ; usual Helm
  (global-set-key (kbd "s-[") 'helm-mini)
  (global-set-key (kbd "<S-s-insert>") 'helm-show-kill-ring)
  (global-set-key [S-f3] 'helm-do-grep)
  (global-set-key [s-f3] 'my-helm-do-grep)
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


  ;; https://github.com/ShingoFukuyama/helm-swoop
  (require 'helm-swoop)
  (setq
   helm-swoop-split-direction 'split-window-horizontally
   helm-swoop-split-with-multiple-windows nil)
  (global-set-key (kbd "C-S-s") 'helm-swoop)
  (global-set-key (kbd "M-i") 'helm-swoop)
  (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
  (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
  (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

  ;; When doing isearch, hand the word over to helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t)

  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows nil)

  ;; Split direction. 'split-window-vertically or 'split-window-horizontally
  (setq helm-swoop-split-direction 'split-window-vertically)

  ;; If nil, you can slightly boost invoke speed in exchange for text color
  (setq helm-swoop-speed-or-color nil)
  )

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
