;;; init-cedet --- todo
;;; Commentary:
;;; Code:

;;(add-to-list 'load-path (concat my-emacs-ext-dir "extensions/cedet-1.1/common"))
(require 'cedet)

;;; ede
;(global-semantic-fo
(setq semantic-default-submodes
      '(;; cache(?)
        global-semanticdb-minor-mode

        global-semantic-highlight-edits-mode
        global-semantic-idle-local-symbol-highlight-mode
        ;; global-cedet-m3-minor-mode

        ;; code helpers
        global-semantic-idle-scheduler-mode
        global-semantic-idle-summary-mode
        global-semantic-idle-completions-mode

        ;; eye candy
        global-semantic-decoration-mode
        global-semantic-highlight-func-mode
        global-semantic-highlight-edits-mode
        global-semantic-stickyfunc-mode

        ;; debugging semantic itself
        ;;global-semantic-show-parser-state-mode 1   ;; show the parsing state in the mode line
        ;;global-semantic-show-unmatched-syntax-mode 1
        ))
;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; speedbar
;; http://www.emacswiki.org/emacs/SrSpeedbar
(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq speedbar-mode-hook '(lambda ()
                            (interactive)
                            (other-frame 0)))
;;(when window-system          ; start speedbar if we're using a window system
;;  (speedbar t))

;;(setq speedbar-use-images nil)
(setq speedbar-show-unknown-files t)

(defvar global-semantic-folding-mode)
(setq global-semantic-folding-mode t)
;;(global-semantic-folding-mode t)


(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;; Enable Semantic
(semantic-mode 1)

(define-key js3-mode-map "." 'semantic-complete-self-insert)



;; Open speedbar and focus on it
(defun my-show-speedbar ()
  (interactive)
  (sr-speedbar-toggle)
  (sr-speedbar-select-window))
(global-set-key "\C-\\" 'my-show-speedbar)

;;(require 'sr-speedbar)

(provide 'init-cedet)
;;; init-cedet.el ends here
