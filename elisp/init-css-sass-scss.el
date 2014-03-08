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
(require 'flymake-sass)

(setq scss-compile-at-save nil
      scss-sass-options '("--cache-location" "'/tmp/sass'"))

(defun my-scss-compile-file (&optional filename)
  "Compile FILENAME (current buffer) to css and reload Firefox page."
  (interactive)
  ;; sudo npm install -g uglifycss
  (let ((css (concat (file-name-sans-extension buffer-file-name) ".css"))
        (mincss (concat (file-name-sans-extension buffer-file-name) ".min.css")))
    ;;(append 'scss-sass-options)
    (shell-command (format "sass %s %s %s" (mapconcat 'identity scss-sass-options " ") (buffer-file-name) css))
    ;; sass --cache-location /tmp/sass /sr
    ;; (format "sass %s /tmp/sass" )
    ;;--style compressed
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
        (when (string= s "// compile")
          (my-scss-compile-file)
          (firefox-reload)
          )))))

(add-hook 'after-save-hook 'sass/scss-save-hook)

(define-key scss-mode-map (kbd "s-r") 'my-scss-compile-file)


(when (require 'init-autocomplete nil 'noerror)
  (add-to-list 'ac-modes 'scss-mode)  ; Enable autocomplete in scss-mode
  )


(provide 'init-css-sass-scss)
;;; init-css-sass-scss.el ends here
