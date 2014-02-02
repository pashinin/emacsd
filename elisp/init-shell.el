;;; init-shell --- Shells
;;; Commentary:
;;; Code:

(require 'term)

;; Tramp can't work well with zsh
;;(when (not (eq system-type 'windows-nt))
;;  (setq shell-file-name "zsh"
;;        explicit-shell-file-name shell-file-name)
;;  (setenv "SHELL" shell-file-name))

;;; Shell mode
(require 'ansi-color)
(setq ansi-color-names-vector
      ["black" "tomato" "PaleGreen2" "gold1"
       "DeepSkyBlue1" "MediumOrchid1" "cyan" "white"])
;;(setq ansi-color-map (ansi-color-make-color-map))

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;(add-hook 'shell-mode-hook '(lambda ()
;;	(set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)


;; This assumes that Cygwin is installed in C:\cygwin (the
;; default) and that C:\cygwin\bin is not already in your
;; Windows Path (it generally should not be).
(when (eq system-type 'windows-nt)
  (setq exec-path (cons "C:/cygwin/bin" exec-path))
  (setenv "PATH" (concat "C:\\cygwin\\bin;" (getenv "PATH"))))

;; LOGNAME and USER are expected in many Emacs packages. Check these
;; environment variables.
(if (and (null (getenv "USER"))
		 (getenv "USERNAME"))
	(setenv "USER" (getenv "USERNAME")))

(if (and (getenv "LOGNAME")  ;;  Bash shell defines only LOGNAME
		 (null (getenv "USER")))
	(setenv "USER" (getenv "LOGNAME")))

(if (and (getenv "USER")
		 (null (getenv "LOGNAME")))
	(setenv "LOGNAME" (getenv "USER")))


;; Remove C-m (^M) characters that appear in output
;;(add-hook 'comint-output-filter-functions
;;		  'comint-strip-ctrl-m)

;; multi-shell - http://www.emacswiki.org/emacs/multi-shell.el
;; TODO: use when
(require 'multi-shell)
(require 'init-shell-term)

;; run system shell in buffer's dir
(defun run-system-shell ()
  "Run system termianl in current buffer's dir."
  (interactive)
  (save-window-excursion
    (let ((buf (generate-new-buffer "async")))
      (async-shell-command "nohup gnome-terminal >/dev/null 2>&1")
      (run-with-timer 10 nil (lambda (buf) (kill-buffer buf)) buf))))
;;(global-set-key (kbd "s-`")    'shell)

(defun my-clear-shell-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 1))
    (comint-truncate-buffer)))

(defun my-shell-options-enable ()
  "My personal shell-mode options hook-function."
  (interactive)
  (toggle-truncate-lines 1)
  (ansi-color-for-comint-mode-on)
  (local-set-key (kbd "C-d") 'comint-delchar-or-maybe-eof)
  (local-set-key "\C-cl" 'my-clear-shell-buffer)

  ;;(setq ansi-color-names-vector
  ;;      ["black" "tomato" "PaleGreen2" "gold1"
  ;;       "DeepSkyBlue1" "MediumOrchid1" "cyan" "white"])
  ;;(setq ansi-term-color-vector
  ;;      (vconcat `(unspecified, base02, red, green, yellow, red,
  ;;                              magenta, cyan, base2)))
  ;;(setq ansi-color-map (ansi-color-make-color-map))
  )
(add-hook 'shell-mode-hook 'my-shell-options-enable)

(defun run-sml-shell ()
  "Run system termianl in current buffer's dir."
  (interactive)
  (let (b)
    (save-window-excursion
      (setq b (run-sml "sml" "" "")))
    (switch-to-buffer b)))

(global-set-key (kbd "s-`")    'multi-shell-new)
(global-set-key (kbd "C-s-`")  'run-system-shell)
(global-set-key (kbd "M-s-`")  'run-sml-shell)

;;(require 'geiser)
;;(require 'inf-mongo)

(provide 'init-shell)
;;; init-shell.el ends here
