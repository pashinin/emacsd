;;; init-w3m --- description
;;; Commentary:
;;; Code:

(require 'w3m)
(require 'mime-w3m)
;;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; When trying to follow a link - have an error:
;; The link is considered to be unsafe
;;Yes, you're right. I'm using w3m - forgot to mention, sorry.
;;> Try
;;>
;;> mm-w3m-safe-url-regexp
;;Thanks!
;;Frobbing the variables
;;w3m-safe-url-regexp and mm-w3m-safe-url-regexp should help.
;; mm-text-html-renderer

;; trying to open a url - it gives:
;; "link is considered to be unsafe"
;;(setq mm-w3m-safe-url-regexp nil)  ;; everything is safe
;;(setq mm-w3m-safe-url-regexp nil)

;;(setq browse-url-browser-function 'w3m-browse-url)
(setq browse-url-browser-function 'browse-url-default-browser)
(global-set-key (kbd "s-]") 'browse-url-at-point)

(setq w3m-use-cookies t)
;;(add-hook 'mime- 'my-shell-options-enable)

(provide 'init-w3m)
;;; init-w3m.el ends here
