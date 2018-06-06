;;; init-tex --- Use LaTeX if you're a real man
;;; Commentary:
;; 1. http://www.cs.berkeley.edu/~prmohan/emacs/latex.html
;; tex-buf ?
;;; Code:

;;TEX
;;(add-to-list 'load-path "~/.emacs.d/elpa/auctex-11.86")
(require 'req-package)

(req-package tex    ;; == auctex
  :ensure auctex
  :config
  (progn
    ;;(setq TeX-engine 'xetex)
    (eval-after-load "tex"
      '(add-to-list 'TeX-command-list
                    '("XeLaTeX" "xelatex -interaction=nonstopmode -shell-escape %s"
                      TeX-run-command nil t :help "Run xelatex") t))
                                        ; 4th argument - "t" to give
                                        ; user a chance to edit a
                                        ; command
    (eval-after-load 'latex '(add-to-list 'LaTeX-verbatim-environments "minted"))

    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (setq reftex-plug-into-AUCTeX t)

    (setq-default TeX-master t)
    (setq TeX-PDF-mode t
          TeX-auto-save t
          TeX-parse-self t
          reftex-toc-split-windows-horizontally t)
))

(req-package tex-buf
;:ensure t
  :config
  (setq TeX-save-query nil))
(req-package tex-site
  :ensure auctex)
(req-package tex-mik
  :ensure auctex)

(req-package preview-latex
;:ensure t
  :require tex-mode
  :config
  (progn
    ))

;;(require 'auto-complete-latex)
;;(require 'ac-math)
;; (req-package auto-complete-config
;; ;:ensure t
;;   ;; :require auto-complete
;;   :init
;;   (add-to-list 'ac-modes 'latex-mode))


(req-package tex-mode
;:ensure t
  :require flycheck
  :config
  (progn
    (setq latex-run-command "xelatex")

    (defun turn-on-outline-minor-mode ()
      (flycheck-mode 0)
      (outline-minor-mode 1)
      (TeX-source-correlate-mode 1))

    (add-hook 'LaTeX-mode-hook 'visual-line-mode)
    ;; (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

    ;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    ;; (setq reftex-plug-into-AUCTeX t)
    (add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
    ))








;;(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else
;;; http://www.emacswiki.org/emacs/TN

(defun my-tex-run-tex ()
  "Run TeX on current document."
  (interactive)
  (my-tex-run-command "XeLaTeX" 'recenter))

(defun my-tex-run-command (cmd &optional recenter)
  (let ((buf (current-buffer)))
    (save-buffer)
    (TeX-command-menu cmd)
    ;; herbert: no output buffer by default
    (setq recenter nil)
    ;; /herbert
    (if recenter
        (condition-case nil
            (with-current-buffer buf
              (TeX-recenter-output-buffer nil))
          (error nil)))))

;; goto pdf page under cursor
;; http://superuser.com/questions/253525/emacs-auctex-how-do-i-open-the-pdf-in-evince-at-the-current-cursor-position
;;(setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
;;(setq TeX-view-program-selection '((output-pdf "Evince")))
;;(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;;(setq TeX-source-correlate-start-server t)


(req-package latex
;:ensure t
  ;; :require init-smarttabs
  :config
  (add-hook 'LaTeX-mode-hook      'my-smarttabs-spaces-autoinednt))


;; sage-mode
;; Links:
;; 1. http://wiki.sagemath.org/sage-mode
;; 2. Downloads: https://bitbucket.org/gvol/sage-mode/downloads
;; 3. https://bitbucket.org/gvol/sage-mode/src
;;
;; Install:
;; sudo sage -i https://bitbucket.org/gvol/sage-mode/downloads/sage_mode-20140407.spkg
;; sudo sage -i sage_mode
;;
;;
(add-to-list 'load-path "/usr/lib/sagemath/local/share/emacs")
;; (req-package sage
;; ;:ensure t
;;   :config
;;   (setq sage-command "/usr/lib/sagemath/sage"))

(provide 'init-tex)
;;; init-tex.el ends here
