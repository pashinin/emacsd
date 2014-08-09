;;; init-browser.el --- Control your browser
;;; Commentary:
;;
;; Mostly about intercation with Firefox and Chromium. When you do
;; web-development you want a browser to update css style / reload page
;; / run javascript each time you save a particular .css / .html file.
;;
;; There are extensions for that which with
;;
;;; Code:

(require 'req-package)

;; Mozrepl
;; https://github.com/bard/mozrepl/wiki
;;
;; Examples
;; (moz-goto-content-and-run-cmd "console.log('hello world');")
;;
(req-package moz
  :commands moz-minor-mode
  :init
  (progn
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

    ))


;;
;; Moz-controller (Firefox)
;;
;; https://github.com/RenWenshan/emacs-moz-controller
(req-package moz-controller
  :commands moz-controller-tab-next moz-controller-view-page-source)

;;
;; Kite (Webkit) - Emacs front end for the WebKit Inspector
;; https://github.com/jscheid/kite
;;
;; Start Chromium as:
;;  chromium-browser --remote-debugging-port=9222
;;
;; Edit .desktop file on Ubuntu:
;;  ~/.local/share/applications/chromium-browser-my.desktop
(req-package kite)

(provide 'init-browser)
;;; init-browser.el ends here
