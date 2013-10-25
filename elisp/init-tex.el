;;; init-tex --- Use LaTeX if you're a real man
;;; Commentary:
;; 1. http://www.cs.berkeley.edu/~prmohan/emacs/latex.html
;;; Code:

;;TEX
;;(add-to-list 'load-path "~/.emacs.d/elpa/auctex-11.86")
(require 'tex)
(require 'tex-buf)

(if (not (eq system-type 'windows-nt))
    (load "auctex.el" nil t t))

;;(require 'auctex nil t)
;;(load "auto-complete-auctex.el")     ; not loading on windows
(eval-after-load "tex-mode" '(progn
                               ;;(load "auctex.el"	nil nil t)
                               (load "preview-latex.el" nil nil t)))

;;(require 'auto-complete-latex)
;;(require 'ac-math)
(require 'auto-complete-config nil t)
(add-to-list 'ac-modes 'latex-mode)
(setq TeX-PDF-mode t)
(TeX-PDF-mode t)
(setq latex-run-command "xelatex")

(require 'tex-site)

(if (not (eq system-type 'windows-nt))
	(load "preview-latex.el" nil t t))    ; not loading on windows

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
;;(setq-default TeX-master nil)
(setq-default TeX-master t)

;;(load "auctex.el" nil t t)
(require 'tex-mik)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;;(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;(setq reftex-plug-into-AUCTeX t)


(defun turn-on-outline-minor-mode ()
  (outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
;;(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

;;; http://www.emacswiki.org/emacs/TN
(require 'tex-buf)
(defun TeX-command-default (name)
  "Next TeX command to use. Most of the code is stolen from `TeX-command-query'."
  (with-no-warnings
    (cond ((if (string-equal name TeX-region)
               (TeX-check-files (concat name "." (TeX-output-extension))
                                (list name)
                                TeX-file-extensions)
             (TeX-save-document (TeX-master-file)))
           TeX-command-default)
          ((and (memq major-mode '(doctex-mode latex-mode))
                (TeX-check-files (concat name ".bbl")
                                 (mapcar 'car
                                         (LaTeX-bibliography-list))
                                 BibTeX-file-extensions))
           ;; We should check for bst files here as well.
           TeX-command-BibTeX)
          ((TeX-process-get-variable name
                                     'TeX-command-next
                                     TeX-command-Show))
          (TeX-command-Show))))

;;;  from wiki
(defcustom TeX-texify-Show t
  "Start view-command at end of TeX-texify?"
  :type 'boolean
  :group 'TeX-command)

(defcustom TeX-texify-max-runs-same-command 5
  "Maximal run number of the same command."
  :type 'integer
  :group 'TeX-command)

(defun TeX-texify-sentinel (&optional proc sentinel)
  "Non-interactive! Call the standard-sentinel of the current LaTeX-process.
If there is still something left do do start the next latex-command."
  (set-buffer (process-buffer proc))
  ;;(funcall TeX-texify-sentinel proc sentinel)
  (let ((case-fold-search nil))
    (when (string-match "\\(finished\\|exited\\)" sentinel)
      (set-buffer TeX-command-buffer)
      (unless (plist-get TeX-error-report-switches (intern (TeX-master-file)))
        (TeX-texify)))))

(defun TeX-texify ()
  "Get everything done."
  (interactive)
  ;;(let ((nextCmd (TeX-command-default (TeX-master-file)))
  ;;      proc)
  ;;  (if (and (null TeX-texify-Show)
  ;;           (equal nextCmd TeX-command-Show))
  ;;      (when  (called-interactively-p 'any)
  ;;        (message "TeX-texify: Nothing to be done."))
  ;;    (TeX-command nextCmd 'TeX-master-file)
  ;;    (when (or (called-interactively-p 'any)
  ;;              (null (boundp 'TeX-texify-count-same-command))
  ;;              (null (boundp 'TeX-texify-last-command))
  ;;              (null (equal nextCmd TeX-texify-last-command)))
  ;;      (mapc 'make-local-variable '(TeX-texify-sentinel TeX-texify-count-same-command TeX-texify-last-command))
  ;;      (setq TeX-texify-count-same-command 1))
  ;;    (if (>= TeX-texify-count-same-command TeX-texify-max-runs-same-command)
  ;;        (message "TeX-texify: Did %S already %d times. Don't want to do it anymore." TeX-texify-last-command TeX-texify-count-same-command)
  ;;      (setq TeX-texify-count-same-command (1+ TeX-texify-count-same-command))
  ;;      (setq TeX-texify-last-command nextCmd)
  ;;      (and (null (equal nextCmd TeX-command-Show))
  ;;           (setq proc (get-buffer-process (current-buffer)))
  ;;           (setq TeX-texify-sentinel (process-sentinel proc))
  ;;           (set-process-sentinel proc 'TeX-texify-sentinel)))))
  ;;(TeX-command (TeX-command-default (TeX-master-file)) 'TeX-master-file)
  (TeX-run-command "XeLaTeX" "xelatex -interaction=nonstopmode " (TeX-master-file))
  )

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

(add-hook 'LaTeX-mode-hook
          '(lambda ()
             (define-key LaTeX-mode-map (kbd "C-c C-a") 'TeX-texify)))

;;(setq TeX-engine 'xetex)
(eval-after-load "tex"
  '(add-to-list 'TeX-command-list
				'("XeLaTeX" "xelatex -interaction=nonstopmode %s"
				  TeX-run-command nil t :help "Run xelatex") t))
                                        ; 4th argument - "t" to give
                                        ; user a chance to edit a
                                        ; command
(setq TeX-PDF-mode t)

;; goto pdf page under cursor
;; http://superuser.com/questions/253525/emacs-auctex-how-do-i-open-the-pdf-in-evince-at-the-current-cursor-position
;;(setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
;;(setq TeX-view-program-selection '((output-pdf "Evince")))
;;(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
;;(setq TeX-source-correlate-start-server t)

;;
;; sage-mode
;;
;; Install - http://wiki.sagemath.org/sage-mode
;; sudo sage -i sage_mode
;;
;; Dev - https://bitbucket.org/gvol/sage-mode/src
;;
(add-to-list 'load-path "/usr/lib/sagemath/local/share/emacs")
(require 'sage "sage")
(setq sage-command "/usr/lib/sagemath/sage")

(provide 'init-tex)
;;; init-tex.el ends here
