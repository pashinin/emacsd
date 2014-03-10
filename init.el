;;; .emacs --- My Config
;;; Commentary:
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start nil)
 '(ac-trigger-key "TAB")
 '(ac-use-menu-map t)
 '(bmkp-last-as-first-bookmark-file "~/.emacs_files/bookmarks")
 '(column-number-mode t)
 '(cua-rectangle-mark-key (kbd "<C-S-return>"))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(emms-mode-line-mode-line-function (quote emms-mode-line-icon-function))
 '(face-font-family-alternatives
   (quote
    (("arial black" "arial" "DejaVu Sans")
     ("arial" "DejaVu Sans")
     ("verdana" "DejaVu Sans"))))
 '(inhibit-startup-screen t)
 '(preview-gs-options
   (quote
    ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(safe-local-variable-values
   (quote
    ((eval when
           (and
            (buffer-file-name)
            (file-regular-p
             (buffer-file-name))
            (string-match-p "^[^.]"
                            (buffer-file-name)))
           (emacs-lisp-mode)
           (unless
               (featurep
                (quote package-build))
             (let
                 ((load-path
                   (cons ".." load-path)))
               (require
                (quote package-build))))
           (package-build-minor-mode)))))
 '(term-default-bg-color "#000000")
 '(term-default-fg-color "#dddd00")
 '(tool-bar-mode nil)
 '(tramp-default-host "localhost")
 '(tramp-default-user "root")
 '(tramp-encoding-shell "/bin/bash")
 '(wg-mode-line-decor-left-brace "[")
 '(wg-mode-line-decor-right-brace "]")
 '(wg-restore-position t)
 '(wg-switch-to-first-workgroup-on-find-session-file t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bm-face ((t (:background "dark green" :foreground "gray59"))))
 '(bold ((t (:weight bold))))
 '(dired-symlink ((t (:inherit font-lock-keyword-face :weight normal))))
 '(ediff-current-diff-C ((t (:background "#888833" :foreground "black"))))
 '(ediff-even-diff-C ((t (:background "gray20" :foreground "dark gray"))))
 '(ediff-fine-diff-B ((t (:background "#22aa22" :foreground "black"))))
 '(ediff-odd-diff-C ((t (:background "midnight blue" :foreground "White"))))
 '(font-lock-keyword-face ((t (:foreground "#859900" :weight bold))))
 '(helm-candidate-number ((t (:background "deep sky blue" :foreground "black"))))
 '(helm-selection ((t (:foreground "lime green" :weight bold))))
 '(helm-source-header ((t (:foreground "gray" :weight normal :height 1.3 :family "Sans Serif"))))
 '(helm-swoop-target-word-face ((t (:background "dark slate blue" :foreground "#ffffff"))))
 '(helm-visible-mark ((t (:background "#005500" :foreground "black"))))
 '(match ((t (:background "dark slate gray"))))
 '(mode-line-buffer-id ((t (:foreground "coral" :weight bold))))
 '(mode-line-highlight ((t (:foreground "navajo white" :box nil :weight bold))))
 '(org-agenda-date-today ((t (:inherit org-agenda-date :foreground "lawn green" :slant normal :weight bold))) t)
 '(web-mode-html-attr-name-face ((t (:foreground "medium sea green"))))
 '(web-mode-html-attr-value-face ((t (:inherit font-lock-string-face :foreground "gold3"))))
 '(web-mode-html-tag-face ((t (:foreground "chartreuse4"))))
 '(wg-brace-face ((t (:foreground "deep sky blue" :weight normal))))
 '(wg-command-face ((t (:inherit font-lock-function-name-face :weight normal))))
 '(wg-divider-face ((t (:weight normal))))
 '(wg-filename-face ((t (:inherit font-lock-keyword-face :weight normal))))
 '(wg-mode-line-face ((t (:inherit font-lock-doc-face :foreground "deep sky blue" :weight normal))))
 '(wg-other-workgroup-face ((t (:inherit font-lock-string-face :weight normal)))))


(setq load-path (cons "~/.emacs.d/elisp" load-path))
;;(setq bbdb-file "~/bbdb")    ; "~/.bbdb"

(require 'init-variables)
(require 'init-packages)
;;(ignore-errors

(require 'init-server)         ;; start Emacs as a server
(require 'init-common)         ;; basic params and colors

(if (eq system-type 'windows-nt) (toggle-fullscreen))

(when t
  (when (and (require 'init-gpg nil 'noerror) internet-ok)
    (require 'init-irc)
    (require 'init-mail-gnus)
    (require 'init-mail-wl)
    ;; Please set `wl-message-id-domain' to get valid Message-ID string
    )
  (require 'init-windows-buffers)    ;; ido, helm...
  (require 'init-bbdb)

  (require 'init-auto-insert)

  (require 'init-org)
  (require 'init-jabber nil 'noerror)
  (require 'init-dired nil 'noerror)
  ;;(require 'init-lisp)
  (require 'init-shell)

  (require 'init-emms nil 'noerror)
  (require 'init-filemodes)
  (require 'init-tramp)
  (require 'init-xiki)
  (require 'init-git)
  (require 'init-os-misc)          ; "notify" function and so on...
  (require 'init-css-sass-scss)
  (require 'init-js-coffee)
  (require 'init-web-mode)

  (require 'init-ctags)
  ;;(require 'init-cedet)
  (require 'init-flycheck)
  (require 'init-autocomplete)

  (require 'init-tex nil 'noerror)  ;; loading tex.el before can reset TeX-PDF-mode setting
  ;;(require 'auto-complete-yasnippet)
  (require 'init-capture nil 'noerror)
  (require 'init-f5)
  ;;(require 'init-scala)
  (require 'init-bookmarks)
  (require 'init-python)
  (require 'init-gettext)

  (require 'init-smarttabs)
  (require 'init-yasnippet)
  )

(require 'init-workgroups nil 'noerror)
