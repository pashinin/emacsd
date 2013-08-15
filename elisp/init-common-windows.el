;;; init-windows --- description
;;; Commentary:
;; Windows: will work for food
;;; Code:

;; make some beauty under Windows
(if (eq system-type 'windows-nt)
    (progn
      (setq default-directory "C:/bin/")
      (custom-set-faces
       '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 120 :width normal)))))
      ))
;;(when (equal system-type 'darwin)
;;  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
;;  (push "/opt/local/bin" exec-path))

;; fix for fucking Windows
(when (eq system-type 'windows-nt)
  (defvar w32-pass-lwindow-to-system nil)
  (defvar w32-pass-rwindow-to-system nil)
  (defvar w32-pass-apps-to-system nil)
  (defvar w32-lwindow-modifier 'super) ; Left Windows key
  (defvar w32-rwindow-modifier 'super) ; Right Windows key
  (defvar w32-apps-modifier 'nil)      ; Menu key
  ;; yes, set them once again
  (setq w32-pass-lwindow-to-system nil
        w32-pass-rwindow-to-system nil
        w32-pass-apps-to-system nil
        w32-lwindow-modifier 'super ; Left Windows key
        w32-rwindow-modifier 'super ; Right Windows key
        w32-apps-modifier 'nil)     ; Menu key

  (global-set-key (kbd "C-<up>")    'windmove-up)
  (global-set-key (kbd "C-<left>")  'windmove-left)
  (global-set-key (kbd "C-<down>")  'windmove-down)
  (global-set-key (kbd "C-<right>") 'windmove-right)
  (global-set-key (kbd "<apps>") (lookup-key global-map (kbd "M-x"))))

(provide 'init-common-windows)
;;; init-common-windows.el ends here
