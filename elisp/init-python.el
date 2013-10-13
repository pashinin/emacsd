;;; init-python --- Python config
;;; Commentary:
;;; Code:

(setq epy-install-dir "~/.emacs.d/elisp/")

;; For Emacs >= 24.3 see https://github.com/milkypostman/melpa/issues/688
;;(when (emacs-major-version emacs-minor-version

(require 'python)
;;(require 'epy-editing)
;;  automatically add spaces around operators on input (x=5 -> x = 5)
;; http://www.emacswiki.org/emacs/SmartOperator
;;(require 'smart-operator)

;; Open Next Line
;;http://www.emacswiki.org/emacs/OpenNextLine
;;(require 'open-next-line)


;; Eproject project management with emacs
                                        ;(require 'eproject)

;; Other useful stuff

;; Highlight indentation
;;(require 'highlight-indentation)
;;(add-hook 'python-mode-hook 'highlight-indentation)

;;(require 'epy-bindings)
(global-set-key (kbd "s-x") 'clipboard-kill-region) ;;cut
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save) ;;copy
(global-set-key (kbd "s-v") 'clipboard-yank) ;;paste

;; calc-mode more comfortable
(global-set-key (kbd "M-c") 'calc-dispatch)

;; Ctrl+tab mapped to Alt+tab
(define-key function-key-map [(control tab)] [?\M-\t])

;;(global-set-key [f10] 'flymake-goto-prev-error)
;;(global-set-key [f11] 'flymake-goto-next-error)

;; Rope bindings
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "\C-ci" 'rope-auto-import)
            (define-key python-mode-map "\C-c\C-d" 'rope-show-calltip)))

;;(setq skeleton-pair t)
;;(global-set-key "(" 'skeleton-pair-insert-maybe)
;;(global-set-key "[" 'skeleton-pair-insert-maybe)
;;(global-set-key "{" 'skeleton-pair-insert-maybe)
;;(global-set-key "\"" 'skeleton-pair-insert-maybe)

  ;;;; Just python
;;(add-hook 'python-mode-hook
;;          (lambda ()
;;            (define-key python-mode-map "'" 'skeleton-pair-insert-maybe)))


(defun setup-ropemacs ()
  "Setup the ropemacs harness"
  (message "****************************")
;;  (if (and (getenv "PYTHONPATH") (not (string= (getenv "PYTHONPATH") "")))
;;      (message "true")
;;    (message "false"))
;;  (message "****************************")

;;; If PYTHONPATH is set and not an empty string
  ;;  (if (and (getenv "PYTHONPATH") (not (string= (getenv "PYTHONPATH") "")))
  ;;      ;; append at the end with separator
  ;;      (setenv "PYTHONPATH"
  ;;            (concat
  ;;             (getenv "PYTHONPATH") path-separator
  ;;             (concat epy-install-dir "python-libs/")))
  ;;    ;; else set it without separator
  ;;    (setenv "PYTHONPATH"
  ;;          (concat epy-install-dir "python-libs/"))
  ;;    )

  ;;  (pymacs-load "ropemacs" "rope-")
  ;;
  ;;  ;; Stops from erroring if there's a syntax err
  ;;  (setq ropemacs-codeassist-maxfixes 3)
  ;;
  ;;  ;; Configurations
  ;;  (setq ropemacs-guess-project t)
  ;;  (setq ropemacs-enable-autoimport t)
  ;;
  ;;
  ;;  (setq ropemacs-autoimport-modules '("os" "shutil" "sys" "logging"
  ;;                                    "django.*"))
  ;;


  ;; Adding hook to automatically open a rope project if there is one
  ;; in the current or in the upper level directory
  ;;(add-hook 'python-mode-hook
  ;;          (lambda ()
  ;;            (cond ((file-exists-p ".ropeproject")
  ;;                   (rope-open-project default-directory))
  ;;                  ((file-exists-p "../.ropeproject")
  ;;                   (rope-open-project (concat default-directory "..")))
  ;;                  )))

  )

;;; Ipython integration with fgallina/python.el
(defun my-setup-ipython ()
  "Setup ipython integration with python-mode"
  (interactive)

  (setq
   python-shell-interpreter "ipython"
   python-shell-interpreter-args "--profile=dev"
   python-shell-prompt-regexp "In \[[0-9]+\]: "
   python-shell-prompt-output-regexp "Out\[[0-9]+\]: "
   python-shell-completion-setup-code ""
   python-shell-completion-string-code "';'.join(get_ipython().complete('''%s''')[1])\n")
  )
;;
;;;;=========================================================
;;;; Flymake additions, I have to put this one somwhere else?
;;;;=========================================================
;;
;;(defun flymake-create-copy-file ()
;;  "Create a copy local file"
;;  (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                     'flymake-create-temp-inplace)))
;;    (file-relative-name
;;     temp-file
;;     (file-name-directory buffer-file-name))))
;;
;;(defun flymake-command-parse (cmdline)
;;  "Parses the command line CMDLINE in a format compatible
;;       with flymake, as:(list cmd-name arg-list)
;;
;;The CMDLINE should be something like:
;;
;; flymake %f python custom.py %f
;;
;;%f will be substituted with a temporary copy of the file that is
;; currently being checked.
;;"
;;  (let ((cmdline-subst (replace-regexp-in-string "%f" (flymake-create-copy-file) cmdline)))
;;    (setq cmdline-subst (split-string-and-unquote cmdline-subst))
;;    (list (first cmdline-subst) (rest cmdline-subst))
;;    ))
;;
;;
;;(when (load-file (concat epy-install-dir "extensions/flymake-patch.el"))
;;  (setq flymake-info-line-regex
;;        (append flymake-info-line-regex '("unused$" "^redefinition" "used$")))
;;  (load-library "flymake-cursor"))
;;
;;(defun epy-setup-checker (cmdline)
;;  (add-to-list 'flymake-allowed-file-name-masks
;;               (list "\\.py\\'" (apply-partially 'flymake-command-parse cmdline)))
;;  )
;;
;;
;;; Python or python mode?
;;(eval-after-load 'python
;;  '(progn
;;     ;;==================================================
;;     ;; Ropemacs Configuration
;;     ;;==================================================
;;     (setup-ropemacs)
;;
;;     ;;==================================================
;;     ;; Virtualenv Commands
;;     ;;==================================================
;;     (autoload 'virtualenv-activate "virtualenv"
;;       "Activate a Virtual Environment specified by PATH" t)
;;     (autoload 'virtualenv-workon "virtualenv"
;;       "Activate a Virtual Environment present using virtualenvwrapper" t)
;;
;;
;;     ;; Not on all modes, please
;;     ;; Be careful of mumamo, buffer file name nil
;;     (add-hook 'python-mode-hook (lambda () (if (buffer-file-name)
;;                                              (flymake-mode))))
;;
;;     ;; when we swich on the command line, switch in Emacs
;;     ;;(desktop-save-mode 1)
;;     (defun workon-postactivate (virtualenv)
;;       (require 'virtualenv)
;;       (virtualenv-activate virtualenv)
;;       (desktop-change-dir virtualenv))
;;     )
;;  )

;;;; Cython Mode
;;(autoload 'cython-mode "cython-mode" "Mode for editing Cython source files")
;;(add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))
;;(add-to-list 'auto-mode-alist '("\\.pxd\\'" . cython-mode))
;;(add-to-list 'auto-mode-alist '("\\.pxi\\'" . cython-mode))
;;
;;;; Py3 files
;;;(add-to-list 'auto-mode-alist '("\\.py3\\'" . python-mode))
                                        ;
;;(add-hook 'python-mode-hook '(lambda ()
;;     (define-key python-mode-map "\C-m" 'newline-and-indent)))
;;(add-hook 'ein:notebook-python-mode-hook
;;    (lambda ()
;;      (define-key python-mode-map "\C-m" 'newline)))


(defun balle-python-shift-left ()
  (interactive)
  (let (start end bds)
    (if (and transient-mark-mode
             mark-active)
        (setq start (region-beginning) end (region-end))
      (progn
        (setq bds (bounds-of-thing-at-point 'line))
        (setq start (car bds) end (cdr bds))))
    (python-indent-shift-left start end))
  (setq deactivate-mark nil)
  )

(defun balle-python-shift-right ()
  (interactive)
  (let (start end bds)
    (if (and transient-mark-mode
             mark-active)
        (setq start (region-beginning) end (region-end))
      (progn
        (setq bds (bounds-of-thing-at-point 'line))
        (setq start (car bds) end (cdr bds))))
    (python-indent-shift-right start end))
  (setq deactivate-mark nil)
  )

(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "M-<right>")
              'balle-python-shift-right)
            (define-key python-mode-map (kbd "M-<left>")
              'balle-python-shift-left)
            ;;(epy-setup-ipython)
            ))










;; Pedro Kroger provided in his blog post about Configuring Emacs as a
;; Python IDE a very useful hook when adding the usual pdb statements
;; somewhere.
;;;;(defun annotate-pdb ()
;;;;  (interactive)
;;;;  (highlight-lines-matching-regexp "import i?pdb")
;;;;  (highlight-lines-matching-regexp "i?pdb.set_trace()"))
;;;;(add-hook 'python-mode-hook 'annotate-pdb)



;; does magic (install via MELPA)
(when (not (eq system-type 'windows-nt))
  (require 'pony-mode)             ;; causes error on Windows


;; However, there's an annoying issue when editing templates. As long as it
;; isn't fixed we add an workaround:
;; https://github.com/davidmiller/pony-mode/issues/55
;;(defun pony-indent ()
;;  "Indent current line as Jinja code"
;;  (interactive)
;;  (beginning-of-line)
;;  (let ((indent (pony-calculate-indent)))
;;    (if (< indent 0)
;;        (setq indent 0))
;;    (indent-line-to indent)))

)



;; python-shell-send-buffer
;; reload modules when C-c C-c (executing file)
(defun py-reload-file (buf)
  "Reload buffer's file in Python interpreter."
  (let ((file (buffer-file-name buf)))
    (if file
        (progn
          ;; Maybe save some buffers
          ;;(save-some-buffers (not py-ask-about-save) nil)
          (let ((reload-cmd
                 (if (string-match "\\.py$" file)
                     (let ((f (file-name-sans-extension
                               (file-name-nondirectory file))))
                       (format "if globals().has_key('%s'):\n    reload(%s)\nelse:\n    import %s\n"
                               f f f))
                   (format "execfile(r'%s')\n" file))))
            ;;(save-excursion
            ;;(set-buffer (get-buffer-create
            (with-current-buffer (get-buffer-create "*Python Command*")
              ;;(generate-new-buffer-name " *Python Command*")))
              (insert reload-cmd)
              ;;(py-execute-base (point-min) (point-max))
              )
            )))))

(defadvice py-execute-region
  (around reload-in-shell activate)
  "After execution, reload in Python interpreter."
  (save-window-excursion
    (let ((buf (current-buffer)))
      ad-do-it
      (py-reload-file buf))))

;;(defadvice python-shell-send-buffer
;;  (around reload-in-shell activate)
;;  "After execution, reload in Python interpreter."
;;  (save-window-excursion
;;    (let ((buf (current-buffer)))
;;      ad-do-it
;;      (py-reload-file buf))))


(setq python-python-command "ipython")

(provide 'init-python)
;;; init-python.el ends here
