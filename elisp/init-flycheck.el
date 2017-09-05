;;; init-flycheck --- my settings for flycheck
;;; Commentary:
;; GNU Emacs comes with Flymake to perform on-the-fly syntax checking.
;; Flycheck is a replacement with support for more languages
;;
;; Source: https://github.com/flycheck/flycheck
;;
;;; Code:

(require 'req-package)

(req-package flycheck
  :commands global-flycheck-mode flymake-goto-prev-error flymake-goto-next-error
  :init
  (progn
    ;; Highlight whole line with error
    (setq flycheck-highlighting-mode 'lines
          flycheck-emacs-lisp-load-path load-path)

    (add-hook 'after-init-hook #'global-flycheck-mode)
    ;; (global-flycheck-mode)
    ;; CoffeeScript: creates a folder ".sass-cache" in current dir when
    ;; using flycheck

    ;; disable jshint since we prefer eslint checking
    (setq-default flycheck-disabled-checkers
                  (append flycheck-disabled-checkers
                          '(javascript-jshint)))

    ;; use eslint with web-mode for jsx files
    (flycheck-add-mode 'javascript-eslint 'js2-mode)

    ;; customize flycheck temp file prefix
    (setq-default flycheck-temp-prefix ".flycheck")

    ;; use local eslint from node_modules before global
    ;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
    (defun my/use-eslint-from-node-modules ()
      (let* ((root (locate-dominating-file
                    (or (buffer-file-name) default-directory)
                    "node_modules"))
             (eslint (and root
                          (expand-file-name "node_modules/eslint/bin/eslint.js"
                                            root))))
        (when (and eslint (file-executable-p eslint))
          (setq-local flycheck-javascript-eslint-executable eslint))))
    (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)



    (require 'flymake-python-pyflakes)
    (add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
    ;; flycheck-flake8rc is a variable defined in `flycheck.el'.
    ;; Its value is ".flake8rc"

    (require 'flymake-shell)
    (add-hook 'sh-set-shell-hook 'flymake-shell-load)

    (require 'flymake-yaml)
    (add-hook 'yaml-mode-hook 'flymake-yaml-load)

    (global-set-key (kbd "s-<") 'flycheck-next-error)
    (global-set-key (kbd "s->") 'flycheck-previous-error)
    (global-set-key (kbd "s-e") (lambda () (interactive)
                                  ;; (modify-syntax-entry ?\" ".")
                                  (let ((pos (flycheck-next-error-pos 1 t)))
                                    (if pos
                                        (progn
                                          (helm-flycheck)
                                          ;; (flycheck-list-errors)
                                          ;; (next-window)
                                          ;; (switch-to-buffer "*Flycheck errors*")
                                          )
                                      (user-error "No errors")))
                                  ))

    ;;(set-face-background 'flymake-warnline "dark slate blue")
))


(provide 'init-flycheck)
;;; init-flycheck.el ends here
