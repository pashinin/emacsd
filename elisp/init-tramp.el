;;; init-tramp --- description
;;; Commentary:
;;; Code:

(require 'tramp)

(setq tramp-default-method "ssh")
;; for debug:
;;(setq
;; tramp-verbose 10
;; tramp-debug-buffer t)
;;(setq debug-on-error t)

(add-to-list 'backup-directory-alist
			 (cons tramp-file-name-regexp nil))

(setq tramp-remote-process-environment ())
(let ((process-environment tramp-remote-process-environment))
  (setenv "HISTORY" nil)
  (setenv "LC_ALL" "en_US.utf8")
  (setq tramp-remote-process-environment process-environment))
;; on Ubuntu:
;; "locale --all-locales"   - shows your locales

;;; with these lines I had an error browsing dir via tramp:
;;; wrong type argument: integer-or-marker-p, nil
;;(add-to-list 'tramp-remote-process-environment "LANG=en_US.utf8"     'append)
;;(add-to-list 'tramp-remote-process-environment "LC_ALL=en_US.utf8"   'append)

;; shell via Tramp - bug:
;; ^[]0;root@server: /^Groot@server:/#
;; http://superuser.com/questions/31533/how-do-i-fix-my-prompt-in-emacs-shell-mode
;; http://stackoverflow.com/questions/704616/something-wrong-with-emacs-shell

;; I came across exact same problem and it is due to PROMPT_COMMAND. I
;; like the xterm title. So I added following line in ~/.emacs_bash
;; export PROMPT_COMMAND=""


;; http://idlebox.net/2011/apidocs/emacs-23.3.zip/tramp/tramp_4.html#SEC23
;;(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*") ; ???
;;; \\(?:^\\| ^M\\)[^#$%>\n]*[#$%>] *\\(\e\\[[0-9;]*[a-zA-Z] *\\)*
;;(setq tramp-shell-prompt-pattern "\\^\\[^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")
;;(setq tramp-shell-prompt-pattern "")
;;(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>→] *\\(\[[0-9;]*[a-zA-Z] *\\)*")
;; TODO: check if current user uses zsh
;;(setq tramp-shell-prompt-pattern "^[^$>→]*[#$%>→] *\\(\[[0-9;]*[a-zA-Z] *\\)*")

(provide 'init-tramp)
;;; init-tramp.el ends here
