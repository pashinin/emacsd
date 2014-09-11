;;; init-python --- Python config
;;; Commentary:
;; https://github.com/jorgenschaefer/elpy/wiki/Configuration
;;; Code:

(require 'req-package)
(require 'python)

;; Ipython integration with fgallina/python.el
(defun my-setup-ipython ()
  "Setup ipython integration with python-mode"
  (interactive)
  (setq
   python-shell-interpreter "ipython"
   python-shell-interpreter-args "--profile=dev"
   python-shell-prompt-regexp "In \[[0-9]+\]: "
   python-shell-prompt-output-regexp "Out\[[0-9]+\]: "
   python-shell-completion-setup-code ""
   python-shell-completion-string-code "';'.join(get_ipython().complete('''%s''')[1])\n"))

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
  (setq deactivate-mark nil))

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
  (setq deactivate-mark nil))

(define-key python-mode-map (kbd "M-<right>") 'balle-python-shift-right)
(define-key python-mode-map (kbd "M-<left>")  'balle-python-shift-left)
(define-key python-mode-map (kbd "C-<up>")    'python-nav-backward-block)
(define-key python-mode-map (kbd "C-<down>")  'python-nav-forward-block)


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

(req-package jedi
  :init
  (progn
    (add-hook 'python-mode-hook 'jedi:setup)
    (setq jedi:complete-on-dot t)
    ))



;; yasnippets make indent wrong on tab
;; (yas--fallback) makes a problem
;; (yas--keybinding-beyond-yasnippet)
(defun my-python-hook ()
  "Function to run on python-mode-hook."
  (interactive)
  (smart-tabs-mode-enable)
  ;;(setq indent-tabs-mode nil) ; nil - use spaces, t - tabs
  ;;(setq tab-width 4)
  ;;(set-variable 'py-indent-offset 4)
  ;;(setq python-indent 4)
  ;;(setq python-indent-offset 4)
  ;;(setq tab-width (default-value 'tab-width))
  (define-key python-mode-map "\C-m" 'newline-and-indent)
  ;;(define-key python-mode-map "\C-m" 'python-indent-line)
  ;;(define-key python-mode-map (kbd "TAB") 'python-indent-line)
  ;;(make-variable-buffer-local 'yas-fallback-behavior)
  ;;(setq 'yas-fallback-behavior '(python-indent-line . nil))
  ;;(set (make-local-variable 'yas-fallback-behavior) '(apply ,python-indent-line))
  ;;(set 'yas-fallback-behavior '(apply ,newline-and-indent))
  (setq python-indent-trigger-commands nil)
  ;;(setq python-indent-trigger-commands '(indent-for-tab-command yas-expand yas/expand))
  )

(when (require 'init-smarttabs nil 'noerror)
  (add-hook 'python-mode-hook 'my-python-hook))


;; https://github.com/davidmiller/pony-mode
(req-package pony-mode)
;; (when (not (eq system-type 'windows-nt))

(req-package rope)

(req-package python-django)
;;python-django-open-project

(provide 'init-python)
;;; init-python.el ends here
