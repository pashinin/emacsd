;;; init-gpg  --- description
;;; Commentary:
;;; Code:

(require 'init-common)
(require 'epa-file)
(epa-file-enable)
(setq epa-file-select-keys nil)  ; 'silent to use symmetric encryption
                                 ; nil - to ask for users unless
                                 ; specified. t - to always ask for a
                                 ; user

;;(setq epa-file-cache-passphrase-for-symmetric-encryption t)
;; Not recommended to use! Use public-key encryption!

;; encrypt org tasks
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)

(defvar my-passwords-file
  (concat my-emacs-files-dir "pass.el.gpg")
  "Load my passwords from this file.
Use GPG encryption!")

(if (and (not (eq system-type 'windows-nt))
         (file-exists-p my-passwords-file))
    (load my-passwords-file))

(provide 'init-gpg)
;;; init-gpg.el ends here
