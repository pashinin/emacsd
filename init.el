;;; .emacs --- My Config
;;; Commentary:
;;; Code:

(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-start nil)
 '(ac-trigger-key "TAB")
 '(ac-use-menu-map t)
 '(bmkp-last-as-first-bookmark-file "/home/xdev/.emacs.d/bookmarks")
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(company-idle-delay 0.1)
 '(company-minimum-prefix-length 1)
 '(cua-rectangle-mark-key (kbd "<C-S-return>"))
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(ecb-options-version "2.40")
 '(ede-project-directories (quote ("/home/xdev/.emacs.d")))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(elfeed-feeds (quote ("http://www.yaplakal.com/news.xml")))
 '(emms-mode-line-mode-line-function (quote emms-mode-line-icon-function))
 '(face-font-family-alternatives
   (quote
    (("arial black" "arial" "DejaVu Sans")
     ("arial" "DejaVu Sans")
     ("verdana" "DejaVu Sans"))))
 '(inhibit-startup-screen t)
 '(magit-commit-arguments (quote ("--gpg-sign=3C0D84EA2D933E47")))
 '(markdown-indent-on-enter t)
 '(package-selected-packages
   (quote
    (cmake-mode csharp-mode cargo dockerfile-mode racer toml-mode flycheck-rust rust-mode ac-html helm-ack ag auctex helm-dash god-mode restart-emacs ggtags helm-gtags neotree helm-bm xah-elisp-mode zencoding-mode zenburn-theme zeal-at-point yari yaml-mode wrap-region windsize web-mode w3m w3 volatile-highlights virtualenv twittering-mode sr-speedbar sourcemap soundklaus soundcloud sos sml-mode smex smeargle smart-tabs-mode smart-tab sass-mode sage-shell-mode req-package pyvirtualenv python-django pysmell pymacs puppet-mode pony-mode persp-projectile paxedit openwith notmuch nose nlinum nginx-mode mustache-mode multi-term moz-controller markdown-mode+ magit lua-mode logstash-conf kite json-mode js3-mode js2-refactor jquery-doc jinja2-mode jedi-direx jabber ipython image-dired+ iedit idomenu ido-vertical-mode helm-swoop helm-projectile-all helm-projectile helm-package helm-ls-git helm-git-grep helm-git helm-css-scss helm-ag gitignore-mode github-browse-file geiser fuzzy full-ack frame-cmds flymake-yaml flymake-shell flymake-python-pyflakes flymake-puppet flymake-coffee flycheck find-file-in-repository f expand-region evil esup ess ensime emmet-mode elpy elisp-slime-nav elfeed ecb dirtree dired-ranger dired-narrow dired-filter dired-details+ dart-mode ctags crontab-mode comment-dwim-2 color-theme-sanityinc-solarized color-theme coffee-mode butler buffer-move bookmark+ bm bbdb bash-completion auto-compile apache-mode anaphora ack-and-a-half ack ace-window ace-jump-buffer ac-js2 ac-helm)))
 '(preview-gs-options
   (quote
    ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(safe-local-variable-values
   (quote
    ((c-noise-macro-with-parens-names "IF_LINT")
     (eval when
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
 '(send-mail-function nil)
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
 '(ace-jump-face-foreground ((t (:background "dim gray" :foreground "white"))))
 '(bm-face ((t (:background "dark slate blue" :foreground "gray59"))))
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
 '(magit-diff-none ((t (:inherit diff-context :foreground "dim gray"))))
 '(match ((t (:background "dark slate gray"))))
 '(mode-line ((t (:background "#403048" :foreground "#C4C9C8" :weight normal))))
 '(mode-line-buffer-id ((t (:foreground "coral" :weight bold))))
 '(mode-line-highlight ((t (:foreground "navajo white" :box nil :weight bold))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#073642" :foreground "#586e75" :weight normal))))
 '(org-agenda-date-today ((t (:inherit org-agenda-date :foreground "lawn green" :slant normal :weight bold))))
 '(region ((t (foreground: "black" :background "dim gray" :inverse-video t))))
 '(vertical-border ((((type tty)) (:inherit mode-line-inactive))))
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
(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'load-path "~/.emacs.d/elisp/extensions/")
;;(setq bbdb-file "~/bbdb")    ; "~/.bbdb"
(require 'init-variables)
(require 'init-packages)
;(require 'init-server)
(require 'init-common)

(require 'init-colorscheme)
;;(if (eq system-type 'windows-nt) (toggle-fullscreen))

(require 'init-windows-buffers)
;(require 'init-bbdb)
;(require 'init-auto-insert)
(require 'init-org)
;(require 'init-jabber)
(require 'init-dired)
;(require 'init-shell)
;(require 'init-emms)
(require 'init-filemodes)

;;(when nil ;; (not travis)
;; (when (and (require 'init-gpg nil 'noerror))
;; ;;  (require 'init-irc))
;;   ;;  (require 'init-mail-gnus)
;;   ;;  ;;(require 'init-mail-wl)
;;   ;;  ;; Please set `wl-message-id-domain' to get valid Message-ID string
;;   )

(require 'init-lisp)
(require 'init-tramp)
;(require 'init-xiki)
(require 'init-git)
;(require 'init-os-misc)          ; "notify" function and so on...
(require 'init-css-sass-scss)
(require 'init-js-coffee)
(require 'init-web-mode)
(require 'init-cpp)
(require 'init-navigation)
;(require 'init-cedet)
;(require 'init-flycheck)
(require 'init-tex)  ;; loading tex.el before can reset TeX-PDF-mode setting
;;;;(req-package auto-complete-yasnippet)
;(require 'init-capture)
(require 'init-f5)
;(require 'init-scala)
(require 'init-bookmarks)
(require 'init-python)
(require 'init-gettext)
(require 'init-navigation)        ; move to variables, functions, classes
(require 'init-search)            ; search text: in buffers, files, dirs
(require 'init-autocomplete)
(require 'init-tab)               ; TAB key
(require 'init-yaml)

;;)

;;(when (display-graphic-p)
;; (require 'init-workgroups nil 'noerror)
;;(req-package init-workgroups)
;; (workgroups-mode 0)

(req-package-finish)
(provide 'init)
;;; init.el ends here
