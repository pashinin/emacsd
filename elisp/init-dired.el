;;; init-dired --- Dired config
;;; Commentary:
;; install "dired-details+" using MELPA (hide file info browsing dir using "(")
;;; Code:

(require 'req-package)
(req-package dired
  :init
  (progn
    (setq dired-listing-switches "-alh")   ; human readable size (Kb, Mb, Gb)
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
      (local-set-key (kbd "s-h")    'dired-omit-mode)

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
      (setq dired-omit-files
            (concat dired-omit-files "\\|^__pycache__$"))
      ;;(setq dired-omit-files
      ;;      (concat dired-omit-files "\\|^.+.js$"))
      (setq dired-omit-files
            (concat dired-omit-files "\\|^.+.map$"))
      (dired-omit-mode 1)
      (if (not (eq system-type 'windows-nt))
          (if (fboundp 'dired-hide-details-mode)
              (dired-hide-details-mode)))  ; hide all info, only filenames
      )

    (add-hook 'dired-mode-hook 'my-dired-options-enable)
    (define-key dired-mode-map (kbd "M-r") 'dired-point-to-random-file)
    ))
(req-package dired-extension)
(req-package dired-x          ; omitting files possibility
  :commands dired-jump
  ;;(global-set-key (kbd "s-\\") 'dired-jump) ;; Jump to parent dir or dir from file
  ;;:bind ("s-\\" . dired-jump)
  :init
  (progn
    (global-set-key (kbd "s-\\") 'dired-jump)
    ;; move to other opened dired window on renaming?
    (setq dired-dwim-target t)
    (defun my-toggle-dired-dwim ()
      "Switch 'rename-move' mode in dired.
Rename into the same dir or to the dir of other dired-window."
      (interactive)
      (setq dired-dwim-target (not dired-dwim-target)))
    ))

(req-package dired-details
  :commands dired-details-hide)
(setq-default dired-details-hidden-string "---")
(if (eq system-type 'windows-nt)
    (req-package dired-details+))         ; for Windows
;;(req-package dired+)

(req-package init-openwith)
(req-package init-dired-marks)
(req-package init-image-dired)
(req-package init-dired-z)


;; Reload dired after making changes
(--each '(dired-do-rename
          dired-do-copy
          dired-create-directory
          wdired-abort-changes)
  (eval `(defadvice ,it (after revert-buffer activate)
           (revert-buffer))))


;;
;; KEYS and default settings
;;
(when (eq system-type 'windows-nt)
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



(defun goto-random-line ()
  "Go to a random line in this buffer."
  (interactive)
  (goto-char (point-min))
  (forward-line (1+ (random (count-lines (point-min) (point-max))))))

(defun dired-point-to-random-file ()
  "Move the cursor to a random file in `dired-mode'."
  (interactive)
  ;;(dired-next-line 1)
  (goto-random-line))


;; Make dired show directories first, then files
(when nil
  (defun mydired-sort ()
    "Sort dired listings with directories first."
    (save-excursion
      (let (buffer-read-only)
        (forward-line 2) ;; beyond dir. header
        (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
      (set-buffer-modified-p nil)))

  (defadvice dired-readin
      (after dired-after-updating-hook first () activate)
    "Sort dired listings with directories first before adding mark."
    (mydired-sort)))

(require 'dired-async)

;;(req-package dirtree)

;;(req-package direx-grep)

;;(req-package direx)
;;(require 'direx)

;; http://ranger.nongnu.org/
(req-package direx-ranger)


(provide 'init-dired)
;;; init-dired.el ends here
