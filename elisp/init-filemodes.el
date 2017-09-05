;;; init-filemodes --- Set modes fo some files
;;; Commentary:
;;; Code:

(req-package nginx-mode
  :init
  (progn
(add-to-list 'auto-mode-alist '("/etc/nginx/\.*"             . nginx-mode))
(add-to-list 'auto-mode-alist '("\\.nginx"                   . nginx-mode))
    ))

(req-package crontab-mode
:init
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?"             . crontab-mode)))

;; big files
(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 10 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)
    ; (message "Buffer is set to read-only because it is large.  Undo also disabled.")
    ))
(add-hook 'find-file-hook 'my-find-file-check-make-large-file-read-only-hook)

;; now we can disable warning "opening a big file":
(setq large-file-warning-threshold nil)


;; auto-mode-alist
(add-to-list 'auto-mode-alist '("\\.uwsgi"                   . conf-unix-mode))
(add-to-list 'auto-mode-alist '("requirements\\.txt"         . conf-unix-mode))
;; (add-to-list 'auto-mode-alist '("\.*logstsh/conf.d/\.*\\.conf" . logstash-conf-mode))
(add-to-list 'auto-mode-alist '("\.*/etc/network/interfaces" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\.*iptables.up.rules"       . shell-script-mode))
(add-to-list 'auto-mode-alist '("\.*/etc/tor/torrc"          . shell-script-mode))
(add-to-list 'auto-mode-alist '("\.*/etc/apt/sources"        . shell-script-mode))
(add-to-list 'auto-mode-alist '("\.*/etc/amavis/conf.d\.*"   . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.j2"             . jinja2-mode))
(add-to-list 'auto-mode-alist '("\\.tex"             . latex-mode))
(add-to-list 'auto-mode-alist '("\\.jinja"             . jinja2-mode))
(add-to-list 'auto-mode-alist '("\\.ts"             . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.js"             . js2-mode))
(add-to-list 'auto-mode-alist '("\\.zsh"             . conf-space-mode))
(add-to-list 'auto-mode-alist '("\\.py\\.sample"             . python-mode))
(add-to-list 'auto-mode-alist '("\\.py\\.j2"                 . python-mode))
(add-to-list 'auto-mode-alist '("\\nginx.conf.j2"            . nginx-mode))
(add-to-list 'auto-mode-alist '("\\.conf.j2"                 . conf-unix-mode))
(add-to-list 'auto-mode-alist '("\.*/var/cfengine/\.*\\.cf"          . cfengine3-mode))


;; vimrc-mode
(define-generic-mode 'vimrc-generic-mode
  '()
  '()
  '(("^[\t ]*:?\\(!\\|ab\\|map\\|unmap\\)[^\r\n\"]*\"[^\r\n\"]*\\(\"[^\r\n\"]*\"[^\r\n\"]*\\)*$"
	 (0 font-lock-warning-face))
	("\\(^\\|[\t ]\\)\\(\".*\\)$"
	 (2 font-lock-comment-face))
	("\"\\([^\n\r\"\\]\\|\\.\\)*\""
	 (0 font-lock-string-face)))
  '("/vimrc\\'" "\\.vim\\(rc\\)?\\'")
  '((lambda ()
	  (modify-syntax-entry ?\" ".")))
  "Generic mode for Vim configuration files.")

(add-to-list 'auto-mode-alist '("\\.text\\'"     . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'"       . markdown-mode))

(provide 'init-filemodes)
;;; init-filemodes.el ends here
