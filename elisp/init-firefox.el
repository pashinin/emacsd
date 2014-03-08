;;; init-firefox.el --- control Firefox
;;; Commentary:
;; Copyright (C) Sergey Pashinin
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;
;; https://github.com/bard/mozrepl/wiki
;;
;;; Code:

;;(require 'moz)

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(defun moz-minor-mode-enable ()
  "Enable connection with Firefox."
  (moz-minor-mode 1))

(defun firefox-reload ()
  "Reload current tab in Firefox."
  (interactive)
  (comint-send-string (inferior-moz-process)
                      "BrowserReload();"))

(defun moz-goto-content-and-run-cmd (cmd)
  "Js command CMD to run."
  (comint-send-string (inferior-moz-process)
                      (concat "repl.enter(content);"
                              cmd
                              "repl.back();")))
;; (moz-goto-content-and-run-cmd "console.log('hello2');")
;; (moz-goto-content-and-run-cmd "console.log('window');")



(provide 'init-firefox)
;;; init-firefox.el ends here
