;;; init-dired --- Dired config
;;; Commentary:
;; install "dired-details+" using MELPA (hide file info browsing dir using "(")
;;; Code:

(require 'dired-extension)
(require 'dired-x)                     ; omitting files possibility
(require 'dired-details)
(if (eq system-type 'windows-nt)
    (require 'dired-details+))         ; for Windows
;;(require 'dired+)
(require 'init-openwith)
(require 'init-dired-marks)
(require 'init-image-dired)
(require 'init-dired-z)

(setq dired-listing-switches "-alh")   ; human readable size (Kb, Mb, Gb)

;; move to other opened dired window on renaming?
(setq dired-dwim-target t)
(defun my-toggle-dired-dwim ()
  "Switch 'rename-move' mode in dired.
Rename into the same dir or to the dir of other dired-window."
  (interactive)
  (setq dired-dwim-target (not dired-dwim-target)))


;;
;; KEYS and default settings
;;

(global-set-key (kbd "s-\\") 'dired-jump) ;; Jump to parent dir or dir from file

(if (eq system-type 'windows-nt)
    (defun dired-explorer ()
      "Open Windows Explorer in current directory."
      (interactive)
      (if (eq major-mode 'dired-mode)
          (shell-command (concat "explorer \"" (replace-regexp-in-string "/" "\\\\" (dired-current-directory)) ""))
        (let ((path (file-name-directory (buffer-file-name))))
          (setq path (replace-regexp-in-string "/" "\\\\" path))
          (shell-command (concat "explorer \"" path "\""))))))

(if (eq system-type 'windows-nt)
    (global-set-key (kbd "s-d")    'dired-explorer)
  (global-set-key (kbd "s-d")    'dired-nautilus))

;; Solves UTF-8 problems that "find ... -ls" has
(setq find-ls-option '("-print0 | xargs -0 ls -alhd" . ""))

;;(setq-default dired-omit-mode t)
;;(add-hook 'dired-mode-hook '(lambda () (toggle-truncate-lines 1)))
(defun my-dired-options-enable ()
  "My personal hook-function for `dired-mode'."
  (interactive)
  (toggle-truncate-lines 1)    ; do not wrap lines

  ;; marks
  (local-set-key (kbd "<kp-7>") 'dired-mark)
  (local-set-key (kbd "<kp-9>") 'dired-unmark)
  (local-set-key (kbd "* +")    'my-dired-mark-all-current-ext)
  (local-set-key (kbd "* -")    'my-dired-unmark-all-current-ext)
  (local-set-key (kbd "* 0")    'dired-unmark-all-marks)
  (local-set-key (kbd "* RET")  'my-dired-mark-all)

  (local-set-key (kbd "q")      'dired-jump)
  ;;(if (eq system-type 'windows-nt)
  ;;    (local-set-key (kbd "s-d")    'dired-explorer)
  ;;  (local-set-key (kbd "s-d")    'dired-nautilus))
  (local-set-key (kbd "<C-kp-divide>") 'my-toggle-dired-dwim)
  (local-set-key (kbd "<kp-8>") 'dired-previous-line)
  (local-set-key (kbd "<kp-5>") 'dired-next-line)
  (local-set-key (kbd "<kp-4>") 'left-char)
  (local-set-key (kbd "<kp-6>") 'right-char)

  (local-set-key (kbd "Z") 'my-dired-compress)


  ;; move buffer up/down
  (local-set-key (kbd "<M-kp-8>") "\C-u1\M-v")
  (local-set-key (kbd "<M-kp-5>") "\C-u1\C-v")
  ;;(local-set-key (kbd "C-s-c") 'my-compress-pictures)

  (setq dired-omit-files "^#\\|~$")
  (setq dired-omit-files
        (concat dired-omit-files "\\|^\\.\\([^.].+\\)?$"))
  (setq dired-omit-files
        (concat dired-omit-files "\\|^session\.\\([^.]\\{9,10\\}[^.].+\\)?$"))
  (dired-omit-mode 1)
  (if (not (eq system-type 'windows-nt))
      (if (fboundp 'dired-hide-details-mode)
          (dired-hide-details-mode)))  ; hide all info, only filenames
  )

(add-hook 'dired-mode-hook 'my-dired-options-enable)

(defun goto-random-line ()
  "Go to a random line in this buffer."
  (interactive)
  (goto-line (1+ (random (buffer-line-count)))))

(defun buffer-line-count ()
  "Return the number of lines in this buffer."
  (count-lines (point-min) (point-max)))

(defun dired-point-to-random-file ()
  "Move the cursor to a random file in `dired-mode'."
  (interactive)
  (dired-next-line 1)
  (goto-random-line)
  )
(define-key dired-mode-map (kbd "s-r") 'dired-point-to-random-file)

(provide 'init-dired)
;;; init-dired.el ends here
