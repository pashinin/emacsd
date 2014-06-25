;;; init-colorscheme --- Set some colors
;;; Commentary:
;;; Code:

(when (require 'color-theme-sanityinc-solarized nil 'noerror)
  (load-theme 'sanityinc-solarized-dark))

;; terminal colors
;; #268bd2 - directory
(setq ansi-term-color-vector
	  [unspecified "black" "red3" "green3" "yellow3" "#268bd2"
				   "magenta3" "cyan3" "white"])

;; Cursor
(blink-cursor-mode -1)
(set-cursor-color "coral") ; it doesn't work for emacsclient, so make a function
(set-border-color "dark orange")
(set-mouse-color "dark orange")
(set-default 'cursor-type 'bar)  ;; box bar

(defun frame-colors (frame)
  "Custom behaviours for new FRAME."
  (with-selected-frame frame
    (set-cursor-color "coral")
    (set-face-foreground 'region "dim gray")
    (set-face-background 'region "black")

    ;;(set-face-background 'hl-line "#374738")
    ))
(frame-colors (selected-frame))
(add-hook 'after-make-frame-functions 'frame-colors)

;; Set region background color
(set-face-foreground 'region "black")
(set-face-background 'region "#9999BB")

(set-face-background 'default "#002b36")
(set-face-background 'default "#1C1F27")


;;(set-face-background 'mode-line "#403048")
(set-face-background 'mode-line "#272738")
(set-face-background 'mode-line "#373748")
(set-face-background 'mode-line-inactive "#272738")
(set-face-background 'mode-line-inactive "#373748")
(set-face-foreground 'mode-line "#C4C9C8")
(set-face-foreground 'mode-line "#C4C9F8")

(set-face-attribute 'mode-line nil :box nil)
(set-face-attribute 'mode-line-inactive nil :box nil)

(set-face-attribute 'vertical-border nil :foreground "#484a4e")
(set-face-background 'fringe "#272738")  ; Borders for buffers ("padding")

;;(set-face-background 'modeline-inactive "#99aaff")
;;(set-face-background 'fringe "#809088")      ; between buffers


;; active buffer - modeline borders
;;(custom-set-faces
;; '(mode-line ((t (:box (:line-width 1 :color "#888888")))))
;; '(mode-line-inactive ((t (:box (:line-width 1 :color "#555555")))))
;;)
;; (set-face-background 'hl-line "seashell2") ;; Choose a good color
;;(set-face-background 'hl-line "#374738")

;; Colors for pairs {} () []
;;(set-face-background 'show-paren-match (face-background 'default))
(set-face-background 'show-paren-match "#ffe")
(set-face-foreground 'show-paren-match "#55a")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

(provide 'init-colorscheme)
;;; init-colorscheme.el ends here
