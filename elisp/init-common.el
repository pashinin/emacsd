;;; init-common --- my functions
;;; Commentary:
;;; Code:

(require 'init-variables)
(require 'req-package)

;; Save history of minibuffer commands
(require 'savehist)
(setq savehist-file (concat my-emacs-files-dir "savehist"))  ; before activating mode
(savehist-mode 1)


(require 'init-common-windows)     ; change some variables for fucking Windows


;;--------------------------------------------------------------------
;; Common
(menu-bar-mode 0)              ; Hide menu: File, Edit, Options...
(tool-bar-mode 0)              ; hide buttons
(scroll-bar-mode -1)           ; hide scrollbars
(setq-default fill-column 72)  ; 80-char margin

(req-package wrap-region
  ;;(add-hook 'ruby-mode-hook 'wrap-region-mode)   ; for specific mode
  :init
  (wrap-region-global-mode t))                     ; for all buffers

;; move cursor from buffer to buffer - super + arrows
(require 'windmove)  ; part of Emacs
(windmove-default-keybindings 's)
;; (windmove-default-keybindings 'M)

;;; Scroll buffer by 1 line - M-f, M-b
(global-set-key "\M-b" (lambda () (interactive) (scroll-down 1)))
(global-set-key "\M-f" (lambda () (interactive) (scroll-up 1)))

(column-number-mode 1)   ; display not only current line but also a column

;; display line numbers
(require 'linum)
(setq linum-format "%4d")
(global-linum-mode 0)
;;(global-linum-mode 1)       ;; slows down org-mode
(req-package nlinum
  :init
  (progn
    (global-nlinum-mode 0)
    (setq nlinum-format "%d ")))

;; some settings
(setq inhibit-startup-message t)        ; Prevent the startup message
(setq scroll-step 1)       ;; scroll by 1 line
(global-hl-line-mode 1)    ;; highlight current line

(fset 'yes-or-no-p 'y-or-n-p)   ;; "y", "n" instead of "yes", "no"

;;(when (require 'multiple-cursors nil 'noerror)
(req-package multiple-cursors
  :commands set-rectangular-region-anchor mc/edit-lines
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C-<" . mc/mark-previous-like-this)
         ("C->" . mc/mark-next-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ("s-SPC" . set-rectangular-region-anchor)))

(req-package expand-region
  :bind ("C-=" . er/expand-region))
;;(global-set-key (kbd "C-=") 'er/expand-region))  ;; select next logical block

;;;; when splitting - focus on new
(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))

;; Upper/lower case ( C-x C-u  |  C-x C-l)
;; don't warn these commands
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;(if (require 'page-break-lines nil 'noerror)
;;    (global-page-break-lines-mode))

;; Whitespaces
;;(require 'whitespace)
;;(setq whitespace-space 'underline)
(global-set-key (kbd "C-_") 'whitespace-mode)   ; show spaces
(defun whack-whitespace (arg)
  "Delete all white space from point to the next word.  With prefix ARG
    delete across newlines as well.  The only danger in this is that you
    don't have to actually be at the end of a word to make it work.  It
    skips over to the next whitespace and then whacks it all to the next
    word."
  (interactive "P")
  (let ((regexp (if arg "[ \t\n]+" "[ \t]+")))
    (re-search-forward regexp nil t)
    (replace-match "" nil nil)))
(global-set-key (kbd "s-_") 'whack-whitespace)   ; kill spaces to next word

;; reload file contents
(global-set-key (kbd "M-<kp-1>")    'revert-buffer)

;; undo/redo windows manipulation with "C-c left", "C-c right"
(winner-mode 1)

(delete-selection-mode 1)   ; delete seleted text when typing
(show-paren-mode t)         ; highlight brackets

;; Insert output of command (shell or M-x) into current buffer
;; That should be handled by Xiki extension to free a couple of key
;; bindings. Then comment this code:
;;(defun my-insert-mx-output ()
;;  (interactive)
;;  (universal-argument)
;;  (execute-extended-command 0)
;;  ;;(kbd "C-u 0")
;;  )
;;
;;;; doesn't work:
;;(defun my-insert-shell-output (cmd)
;;  (interactive "sEnter cmd: ")
;;  (universal-argument)
;;  (insert (shell-command cmd)))
;;(global-set-key (kbd "<M-menu>") 'my-insert-mx-output)
;;(global-set-key (kbd "<C-menu>") 'my-insert-shell-output)


(if (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode 0))

;; Make buffer names unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward     ;; filename:dirname
      uniquify-separator ":")

;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Backup-Copying.html
(setq make-backup-files nil   ;; nil - do not make backup garbage files (file.txt~)
      backup-directory-alist '(("." . (concat my-emacs-files-dir "file_backups")))
      backup-by-copying nil
      backup-by-copying-when-mismatch t)

;; This snippet will temporarily make Emacs believes that there is no
;; active process when you kill it, and therefore you won't get the
;; annoying prompt.
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (dflet ((process-list ())) ad-do-it))

;; Unicode
;;(setq default-buffer-file-coding-system 'utf-8-unix)
(setq buffer-file-coding-system 'utf-8-unix
      default-file-name-coding-system 'utf-8-unix
      default-keyboard-coding-system 'utf-8-unix
      default-process-coding-system '(utf-8-unix . utf-8-unix))

;;(setenv "LC_ALL"     "en_US.UTF-8")
(set-language-environment 'UTF-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)
;;(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; MS Windows clipboard is UTF-16LE
;;(set-clipboard-coding-system 'utf-16le-dos)

;; when opening a file - try these encodings (bottom-up):
(prefer-coding-system 'cp866)
(prefer-coding-system 'koi8-r-unix)
(prefer-coding-system 'windows-1251-dos)
(prefer-coding-system 'utf-8-unix)

(global-set-key "\C-l" 'goto-line)   ; Goto-line key

;; lines wrapping
(setq truncate-lines nil)  ;; disable line wrap
(setq truncate-partial-width-windows t)
(global-set-key [f12] 'toggle-truncate-lines) ; F12 to toggle line wrap

;; disable backups for editing "sudo su.."
(setq backup-enable-predicate
	  (lambda (name)
		(and (normal-backup-enable-predicate name)
			 (not
			  (let ((method (file-remote-p name 'method)))
				(when (stringp method)
				  (member method '("su" "sudo"))))))))

;; keys for russian layout (C-s == C-ы)
;;(global-set-key (kbd "C-п") (lookup-key global-map (kbd "C-g")))
;;(global-set-key (kbd "C-ч C-ы") (lookup-key global-map (kbd "C-x C-s")))
;;(global-set-key (kbd "C-ч C-с") (lookup-key global-map (kbd "C-x C-c")))
;;(global-set-key (kbd "C-ч C-у") (lookup-key global-map (kbd "C-x C-e")))

(defun kill-current-buffer ()
  "Kill current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(defun kill-buffer-close-window ()
  "Kill current buffer and delete window."
  (interactive)
  (kill-buffer (current-buffer))
  (delete-window))

(global-set-key (kbd "<s-backspace>") 'kill-current-buffer)
(global-set-key (kbd "<s-delete>")    'kill-buffer-close-window)

(defun my-run-ack ()
  "Run ack-grep in current buffer."
  (interactive)
  (save-window-excursion
    (call-interactively 'rgrep))
  ;;(compile-goto-error
  (switch-to-buffer "*grep*"))
(global-set-key [S-f3] 'my-run-ack)
(global-set-key [C-f3] 'find-name-dired)
;; (find-name-dired)


;;
;; What to do on save?
;;
(defvar my-flag-delete-trailing-spaces t
  "If t trailing spaces will be removed on saving a file.")
(defun toggle-delete-trailing-spaces ()
  ""
  (interactive)
  (setq my-flag-delete-trailing-spaces (not my-flag-delete-trailing-spaces))
  (if my-flag-delete-trailing-spaces
      (message "Remove fucking trailing spaces when saving a file")
    (message "Do not touch spaces on save")))
(global-set-key (kbd "C-s-s") 'toggle-delete-trailing-spaces)

(defun unix-newlines-no-spaces ()
  "Convert current text file to a better format.
1. make unix lines endings \\n
2. delete spaces you don't need"
  (save-window-excursion
    (set-buffer-file-coding-system 'utf-8-unix)
    (if my-flag-delete-trailing-spaces
        (delete-trailing-whitespace))))
(add-hook 'before-save-hook 'unix-newlines-no-spaces)





;;
;; code borrowed from http://emacs-fu.blogspot.com/2010/01/duplicating-lines-and-commenting-them.html
;;(defun djcb-duplicate-line (&optional commentfirst)
;;  "comment line at point; if COMMENTFIRST is non-nil, comment the
;;original"
;;  (interactive)
;;  (beginning-of-line)
;;  (push-mark)
;;  (end-of-line)
;;  (let ((str (buffer-substring (region-beginning) (region-end))))
;;    (when commentfirst
;;      (comment-region (region-beginning) (region-end)))
;;    ;;(insert-string
;;    (insert
;;     (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
;;    (forward-line -1)))
;;
;;;; duplicate a line
;;(global-set-key (kbd "C-c y") 'djcb-duplicate-line)

;; duplicate a line and comment the first
;;(global-set-key (kbd "C-c c")(lambda()(interactive)(djcb-duplicate-line t)))

;; Mark whole line
(defun mark-line (&optional arg)
  "Marks a line"
  (interactive "p")
  (beginning-of-line)
  (push-mark (point) nil t)
  (end-of-line))

(global-set-key (kbd "C-c l") 'mark-line)


(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)
      ))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          ;;(forward-line -2)     ;; fix it -1 (down) or -2 (up)

          )
        )
      (forward-line -1)
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg))
  (if (not (and mark-active transient-mark-mode))
      (forward-line -1)
    )
  )

(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

(defun toggle-current-window-dedication ()
  (interactive)
  (let* ((window    (selected-window))
         (dedicated (window-dedicated-p window)))
    (set-window-dedicated-p window (not dedicated))
    (message "Window %sdedicated to %s"
             (if dedicated "no longer " "")
             (buffer-name))))

(global-set-key (kbd "<s-kp-enter>") 'toggle-current-window-dedication)


;; https://github.com/nonsequitur/smex
;; IDO to your recently and most frequently used "M-x" commands
(req-package smex
  :commands smex
  :init
  (progn
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "<menu>") 'smex)
    (global-set-key (kbd "M-x") 'helm-M-x)
    (global-set-key (kbd "<menu>") 'helm-M-x)
    ))

(electric-pair-mode 1)

(req-package undo-tree
  :commands global-undo-tree-mode
  :init
  (global-undo-tree-mode 1))

;(require 'ace-jump-mode)
;(autoload
;  'ace-jump-mode
;  "ace-jump-mode"
;  "Emacs quick move minor mode"
;  t)
;;(define-key global-map (kbd "C-s") 'isearch-forward)
;;(define-key global-map (kbd "C-S-s") 'ace-jump-mode)
;; isearch-forward


;; sudo add-apt-repository ppa:jerzy-kozera/zeal-ppa
;; sudo apt-get update
;; sudo apt-get install zeal
;;(req-package zeal-at-point
;;  :commands zeal-at-bind
;;  :point ("<s-f1>" . zeal-at-point)
;;  :config
;;  (add-to-list 'zeal-at-point-mode-alist '(python-mode . "python")))


(setq byte-compile-warnings '(not nresolved
                                  free-vars
                                  callargs
                                  redefine
                                  obsolete
                                  noruntime
                                  cl-functions
                                  interactive-only
                                  ))

(req-package init-os-misc
  :commands my-restart-emacs
  :bind ("<s-pause>" . my-restart-emacs))

(require 'ert)


(req-package dash
  :init
  (dash-enable-font-lock))

(req-package evil
  :init
  (progn
    ;;(setq evil-)
    ))

;; https://github.com/remyferre/comment-dwim-2
(req-package comment-dwim-2
  :init
  (global-set-key (kbd "M-;") 'comment-dwim-2))

(req-package markdown-mode
  :config
  (global-set-key (kbd "M-;") 'comment-dwim-2)
  (define-key markdown-mode-map (kbd "C-b") 'markdown-insert-bold)
  (define-key markdown-mode-map (kbd "RET") 'newline-and-indent))

(req-package find-file-in-repository
  :init
  ;;(global-set-key (kbd "C-x C-f") 'find-file-in-repository)
  ;;(global-unset-key (kbd "C-x C-f"))
  (global-set-key (kbd "C-x C-f") 'ido-find-file)
  )

(add-hook 'cfengine3-mode-hook (lambda ()
                                 (interactive)
                                 (flycheck-mode -1)))

(setq helm-dash-docsets-path "/usr/data/local2/.docsets")
;; (setq helm-dash-docsets)


(provide 'init-common)
;;; init-common.el ends here
