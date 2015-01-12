;;; init-search.el --- Searching stuff in buffers, files, filesystem
;;; Commentary:
;;
;; Search
;; 1. Text in buffers
;; 2. Text in files contents
;; 3. Files by name
;;
;;; Code:

(require 'req-package)
(require 'eieio)  ; fix https://github.com/emacs-helm/helm/issues/815
(defun class-slot-initarg (class-name slot)
  (eieio--class-slot-initarg (eieio--class-v class-name) slot))

;; Helm - search anything
;; To configure colors: M-x customize-group <RET> helm <RET>
(req-package helm
  :init
  (progn
    (setq helm-idle-delay 0.1
          helm-input-idle-delay 0.1
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-transformer-show-only-basename nil     ;; show full path, need for helm-ls-git
          helm-ff-skip-boring-files t)
    ;;(helm-set-sources)
    (global-set-key (kbd "C-x C-b") 'helm-mini)   ; usual Helm
    (global-set-key (kbd "s-[") 'helm-mini)
    (global-set-key (kbd "<S-s-insert>") 'helm-show-kill-ring)
    (global-set-key [S-f3] 'helm-do-grep)
    ;; Open in the same buffer:
    (setq helm-display-function
          (lambda (buf)
            ;;(split-window-horizontally)
            ;;(other-window 1)
            (switch-to-buffer buf)))
    ;;(helm-configuration)
    ))


;;
;;; Search text in a buffer
;;
;; C-s      `isearch-forward'
;; C-r      `isearch-backward'
;; C-S-s    `helm-swoop'           https://github.com/ShingoFukuyama/helm-swoop
(req-package helm-swoop
  :commands helm-swoop-from-isearch helm-multi-swoop-all-from-helm-swoop
  helm-multi-swoop helm-multi-swoop-all helm-swoop-back-to-last-point
  :require helm
  :bind ("C-S-s" . helm-swoop)
  :init
  (progn
    ;;(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
    (setq
     helm-swoop-split-direction 'split-window-horizontally
     helm-swoop-split-with-multiple-windows nil
     helm-swoop-speed-or-color nil
     helm-multi-swoop-edit-save t
     helm-swoop-split-with-multiple-windows nil)))


;; Search files by file names
;;
;; C-S-f3     `helm-for-files'
;;
;;(require 'helm-files)
(req-package helm-files
  :require helm
  :commands helm-do-grep-1 my-helm-do-grep helm-for-files
  :bind (;;("<s-f3>" . my-helm-do-grep)
         ("<C-S-f3>" . helm-for-files))
  :config
  (progn
    ;; do not list:
    (if (boundp 'helm-boring-file-regexp-list)
        (loop for ext in '("\\.swf$" "\\.elc$" "\\.pyc$")
              do (add-to-list 'helm-boring-file-regexp-list ext)))
    ;; helm-boring-file-regexp-list
    (setq helm-for-files-preferred-list
          '(
            ;;helm-source-buffers-list
            ;;helm-source-recentf
            ;;helm-source-bookmarks
            ;;helm-source-file-cache
            helm-source-files-in-current-dir
            helm-source-locate
            ;;helm-locate-source
            ;;(eieio--class-p helm-locate-source)
            )
          helm-locate-command "locate %s -e -A -i %s")
    ))


;; Just in case: ack, but silversearch is faster
(req-package ack-and-a-half
  :commands ack ack-and-a-half ack-and-a-half-same ack-and-a-half-find-file ack-and-a-half-find-file-same
  :config
  (progn
    (defalias 'ack 'ack-and-a-half)
    (defalias 'ack-same 'ack-and-a-half-same)
    (defalias 'ack-find-file 'ack-and-a-half-find-file)
    (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)))


;; SilverSearch - https://github.com/ggreer/the_silver_searcher
;; Install:
;;   sudo apt-get install silversearcher-ag
;;
;; Use:
;; s-f3       `helm-do-ag' - search text in all files' (under current dir) content
(req-package helm-ag
  :require helm
  :bind ("<s-f3>" . helm-do-ag)
  :config
  (progn
    (setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
    (setq helm-ag-command-option "--all-text")
    (setq helm-ag-thing-at-point 'symbol)
    (setq helm-ag-source-type 'file-line)))


(provide 'init-search)
;;; init-search.el ends here
