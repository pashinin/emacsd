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
 '(face-font-family-alternatives
   (quote
    (("arial black" "arial" "DejaVu Sans")
     ("arial" "DejaVu Sans")
     ("verdana" "DejaVu Sans"))))
 '(font-lock-keywords-case-fold-search t t)
 '(global-font-lock-mode t nil (font-lock))
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
 '(wg-restore-position t)
 '(wg-switch-to-first-workgroup-on-find-session-file t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t (:weight bold))))
 '(helm-candidate-number ((t (:background "deep sky blue" :foreground "black"))))
 '(helm-selection ((t (:foreground "lime green" :weight bold))))
 '(helm-source-header ((t (:foreground "gray" :weight normal :height 1.3 :family "Sans Serif"))))
 '(helm-visible-mark ((t (:background "#005500" :foreground "black"))))
 '(mode-line ((t (:background "#073642" :foreground "dodger blue" :box (:line-width 1 :color "#839496") :weight normal))))
 '(mode-line-buffer-id ((t (:foreground "coral" :weight bold))))
 '(mode-line-highlight ((t (:foreground "navajo white" :box nil :weight bold))))
 '(org-agenda-date-today ((t (:inherit org-agenda-date :foreground "lawn green" :slant normal :weight bold))) t))

;;==========================================================

(setq load-path (cons "~/.emacs.d" load-path))
(setq load-path (cons "~/.emacs.d/elisp" load-path))
;;(setq bbdb-file "~/bbdb")    ; "~/.bbdb"

(require 'init-variables)      ;; my emacs extensions paths,
(require 'init-packages)

;;(if (not (eq system-type 'windows-nt))
(require 'init-server)         ;; start Emacs as a server
(require 'init-common)         ;; basic params and colors

(if (eq system-type 'windows-nt) (toggle-fullscreen))

(when t ; nil - for debug
  (when (and (require 'init-gpg nil 'noerror) internet-ok)
    (require 'init-irc)
    ;;(require 'init-mail)
    )
  (require 'init-windows-buffers)    ;; ido, helm...
  (require 'init-bbdb)

  (require 'init-auto-insert)

  (require 'init-org)
  (require 'init-jabber nil 'noerror)
  (require 'init-dired nil 'noerror)
  (require 'init-shell)

  (require 'init-emms nil 'noerror)
  (require 'init-python)
  (require 'init-filemodes)
  (require 'init-tramp)
  (require 'init-xiki)
  (require 'init-git)
  (require 'init-os-misc)          ; "notify" function and so on...
  (require 'init-php-html-js-css)

  (require 'init-ctags)
  (require 'init-flycheck)
  (require 'init-smarttabs)
  (require 'init-autocomplete)
  (require 'init-yasnippet) ; after smarttabs! Or smarttabs eats TAB key

  (require 'init-tex nil 'noerror)  ;; loading tex.el before can reset TeX-PDF-mode setting
  (require 'auto-complete-yasnippet)
  (require 'init-capture nil 'noerror)
  (require 'init-f5)
  (require 'init-workgroups nil 'noerror)
  (require 'init-bookmarks)
  )
