;;; init-css-sass-scss.el --- CSS/SCSS/SASS styles
;;; Commentary:
;; Copyright (C) Sergey Pashinin
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;
;; sudo apt-get install ruby-full build-essential  # rubygems
;; sudo gem install sass
;; sass -v
;;
;;; Code:

(require 'init-firefox)
(require 'css-mode)
(add-hook 'css-mode-hook 'moz-minor-mode-enable)
(define-key css-mode-map (kbd "s-r") 'firefox-reload)


(require 'scss-mode)
;;(require 'flymake-sass)

(setq scss-compile-at-save nil
      scss-sass-options '("--cache-location" "'/tmp/sass'"))
(add-hook 'scss-mode-hook (lambda ()
                            (interactive)
                            (flycheck-mode -1)))


(defun my-scss-compile-file (&optional filename)
  "Compile FILENAME (current buffer) to css and reload Firefox page."
  (interactive)
  ;; sudo npm install -g uglifycss
  (let* ((css (concat (file-name-sans-extension buffer-file-name) ".css"))
         (mincss (concat (file-name-sans-extension buffer-file-name) ".min.css"))
         (scss (buffer-file-name))
         err)
    ;;(append 'scss-sass-options)
    (if (s-starts-with? "_" (buffer-name))
        (if (file-exists-p "all.scss")
            (setq css "all.css"
                  input "all.scss")))
    (setq err (shell-command-to-string
               (format "sass %s %s %s" (mapconcat 'identity scss-sass-options " ")
                       scss css)))
    (if err (error err))
    ;; sass --cache-location /tmp/sass /sr
    ;; --style compressed
    ;;(with-temp-buffer
    ;;  (insert (shell-command-to-string (format "sass %s --style compressed" (buffer-file-name))))
    ;;  (shell-command-on-region (point-min) (point-max) (format "uglifycss %s" (buffer-file-name)))
    ;;  )
    ))

(defun sass/scss-save-hook()
  "My function on saving sass/scss."
  (when (eq major-mode 'scss-mode)
    (let ((s (buffer-substring-no-properties (point-min) (+ (point-min) 10))))
      (with-temp-message s
        (when (or (string= s "// compile")
                  (s-starts-with? "_" (buffer-name)))
          (my-scss-compile-file))
        (firefox-reload)))))
(add-hook 'after-save-hook 'sass/scss-save-hook)

(define-key scss-mode-map (kbd "s-r") 'my-scss-compile-file)


;; Enable autocomplete in scss-mode
(when (require 'init-autocomplete nil 'noerror)
  (add-to-list 'ac-modes 'scss-mode))

(when (require 'init-smarttabs nil 'noerror)
  ;; scss indent is based on `css-mode'
  (add-hook 'css-mode-hook    'myHtmlStyle))


(require 'helm)
(require 'helm-css-scss)

;; Allow comment inserting depth at each end of a brace
(setq helm-css-scss-insert-close-comment-depth 2)
;; If this value is t, split window appears inside the current window
(setq helm-css-scss-split-with-multiple-windows nil)
;; Split direction. 'split-window-vertically or 'split-window-horizontally
(setq helm-css-scss-split-direction 'split-window-vertically)

;; Set local keybind map for css-mode / scss-mode
(dolist ($hook '(css-mode-hook scss-mode-hook less-css-mode-hook))
  (add-hook
   $hook (lambda ()
           (local-set-key (kbd "s-i") 'helm-css-scss)
           (local-set-key (kbd "s-I") 'helm-css-scss-back-to-last-point))))

(define-key isearch-mode-map (kbd "s-i") 'helm-css-scss-from-isearch)
(define-key helm-css-scss-map (kbd "s-i") 'helm-css-scss-multi-from-helm-css-scss)


(provide 'init-css-sass-scss)
;;; init-css-sass-scss.el ends here
