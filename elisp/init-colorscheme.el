;;; init-colorscheme --- Set some colors
;;; Commentary:
;;; Code:

(require 'req-package)

(req-package color-theme-sanityinc-solarized
  :init
  (load-theme 'sanityinc-solarized-dark)
  (set-cursor-color "coral")

  (set-face-attribute 'mode-line nil :box nil)
  (set-face-attribute 'mode-line-inactive nil :box nil)
  (set-face-attribute 'vertical-border nil :foreground "#484a4e")
  (set-face-background 'fringe "#272738")  ; Borders for buffers ("padding")

  ;; Colors for pairs {} () []
  ;;(set-face-background 'show-paren-match (face-background 'default))
  (set-face-background 'show-paren-match "#ffe")
  (set-face-foreground 'show-paren-match "#55a")
  (set-face-attribute 'show-paren-match nil :weight 'extra-bold)

  ;; (set-face-background 'magit-diff-context-highlight "#002b36")
  ;; ;; (set-face-background 'magit-diff-added-highlight "#336633")
  ;; (set-face-background 'magit-diff-added-highlight "#032633")
  )

;; Cursor
(blink-cursor-mode -1)
(set-cursor-color "coral") ; it doesn't work for emacsclient, so make a function
(set-border-color "dark orange")
(set-mouse-color "dark orange")
(set-default 'cursor-type 'bar)  ;; box bar
;; (set-face-background 'fringe "red")



(defun frame-colors (frame)
  "Custom behaviours for new FRAME."
  (with-selected-frame frame
    ;; (set-frame-font "Ubuntu mono-12")
    ;; (set-frame-font "DejaVu Sans Mono-12")
    (set-cursor-color "coral")
    (set-face-foreground 'region "dim gray")
    (set-face-background 'region "black")
    ;;(set-face-background 'default "#002b36")
    (set-face-background 'fringe "#002b36")
    ;;(face-background 'default)
    ;;(set-face-background 'default "#002b36")
    ;;(set-face-background 'default "#1C1F27")
    ;;(set-face-background 'default "#1C1F27")
    ;;(set-face-background 'hl-line "#374738")
    ;;(set-frame-parameter frame 'border-width 10)

    ;; Text selection (color, background color):
    (set-face-attribute 'region nil :background "#666")
    (set-face-attribute 'region nil :background "#303030" :foreground "#afafaf")

    ;;(when (display-graphic-p)
    ;;(set-face-background 'default "#002b36")
    ;;(set-face-background 'default "#1C1F27")

    ;;(set-face-background 'mode-line "#403048")
    (set-face-background 'mode-line "#272738")
    (set-face-background 'mode-line "#373748")
    (set-face-background 'mode-line-inactive "#272738")
    (set-face-background 'mode-line-inactive "#373748")
    (set-face-foreground 'mode-line "#C4C9C8")
    (set-face-foreground 'mode-line "#C4C9F8")

    ;;(set-face-background 'modeline-inactive "#99aaff")
    ;;(set-face-background 'fringe "#809088")      ; between buffers

    ;; active buffer - modeline borders
    ;;(custom-set-faces
    ;; '(mode-line ((t (:box (:line-width 1 :color "#888888")))))
    ;; '(mode-line-inactive ((t (:box (:line-width 1 :color "#555555")))))
    ;;)
    ;; (set-face-background 'hl-line "seashell2") ;; Choose a good color
    ;;(set-face-background 'hl-line "#374738")
    ))
;;(set-frame-parameter (selected-frame) 'internal-border-width 0)
(frame-colors (selected-frame))

(add-hook 'after-make-frame-functions 'frame-colors)

(provide 'init-colorscheme)
;;; init-colorscheme.el ends here
