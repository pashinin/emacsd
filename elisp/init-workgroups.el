;;; init-workgroups --- Configure workgroups2 extension
;;; Commentary:
;;; Code:

(require 'init-variables)
;; (update-file-autoloads (concat my-emacs-ext-dir "workgroups2/src/workgroups2.el"))
(add-to-list 'load-path (concat my-emacs-ext-dir "workgroups2/src"))
(add-to-list 'load-path (concat my-emacs-ext-dir "workgroups2/tests"))
;;(update-directory-autoloads (concat my-emacs-ext-dir "workgroups2/src"))
(require 'ert-my-utils)
;; (desktop-save-mode 1)   ; may have issues with workgroups

;; TEST
(setq wg-pickel-pickelable-types
      '(integer
        float
        symbol
        string
        cons
        vector
        hash-table
        window-configuration
        buffer
        marker
        ;;frame
        ;;window
        ;;process
        ))

;;(delq 'wg-serialize-speedbar-buffer wg-special-buffer-serdes-functions)

(setq wg-pickel-object-serializers
      '((integer    . identity)
        (float      . identity)
        (string     . identity)
        (symbol     . wg-pickel-symbol-serializer)
        (cons       . wg-pickel-cons-serializer)
        (vector     . wg-pickel-vector-serializer)
        (hash-table . wg-pickel-hash-table-serializer)
        (window-configuration   . wg-pickel-window-configuration-serializer)
        ;;(window-configuration   . identity)
        (buffer     . wg-pickel-buffer-serializer)
        (marker     . wg-pickel-marker-serializer)
        (frame      . wg-pickel-frame-serializer)
        (window     . identity)
        (process    . identity)))

(setq wg-pickel-object-deserializers
      '((s . wg-pickel-deserialize-uninterned-symbol)
        (c . wg-pickel-deserialize-cons)
        (v . wg-pickel-deserialize-vector)
        (h . wg-pickel-deserialize-hash-table)
        (b . wg-pickel-deserialize-buffer)
        (m . wg-pickel-deserialize-marker)
        (f . wg-pickel-deserialize-frame)))



;; (wg-pickel (selected-window))
;; (wg-pickel (window-prev-buffers (selected-window)))
;; (wg-pickel (car (window-prev-buffers (selected-window))))
;; (wg-unpickel (wg-pickel (car (window-prev-buffers (selected-window)))))

;; (window-next-buffers (selected-window))
;; (window-prev-buffers (selected-window))

;; (wg-pickel (current-buffer))
;; (wg-unpickel (wg-pickel (current-buffer)))

;; (set-window-configuration (current-window-configuration))
;; (wg-pickel (current-window-configuration))
;; (wg-unpickel (wg-pickel (current-window-configuration)))
;; (wg-pickel (ecb-current-window-configuration))
;; (wg-unpickel (wg-pickel (ecb-current-window-configuration)))
;; (wg-unpickel (wg-pickel (current-frame-configuration)))
;; (wg-pickel (current-frame-configuration))
;; (wg-pickel (selected-frame))
;; (wg-unpickel (wg-pickel (selected-frame)))
;; (mapcar 'wg-pickel-frame-serializer (frame-list))
;; (wg-unpickel (wg-pickel (current-buffer)))
;; (wg-buffer-uid (current-buffer))
;; (wg-find-bufobj (current-buffer) (wg-buf-list))
(defun wg-pickel-frame-serializer (&optional frame)
  "Return FRAME's serialization."
  (unless frame
    (setq frame (selected-frame)))
  (list 'f
        ;; Hint for this "if" statement:
        ;; http://stackoverflow.com/questions/21151992/why-emacs-as-daemon-gives-1-more-frame-than-is-opened
        (if (string-equal "initial_terminal" (terminal-name frame))
            nil
          (wg-frame-to-wconfig frame))))

(defun wg-pickel-deserialize-frame (p)
  "Return a restored buffer from it's UID."
  ;;(frame-list)
  (when p
    ;;(make-frame)
    ;;p
    ;;wg-restore-frame
    ;;(wg-restore-buffer (wg-find-buf-by-uid uid))
    ))
;; (wg-pickel (selected-frame))
;; (wg-unpickel (wg-pickel (selected-frame)))

;;(window-configuration
;; 3)
;;(buffer
;; 1)
;;(frame
;; 2)
;;;;(t (type-of obj))
;;;;(t
;;;; ;;(message (type-of obj))
;;;; obj)

;; (wg-frame-to-wconfig)
;; (make-frame)
;; (wg-save-frames)
;; (wg-session-parameter (wg-current-session t) 'frame-list)
;; (wg-restore-frames)

;; ==================================================
;; ==================================================

(require 'workgroups2)
;;  :commands workgroups-mode wg-reload-session wg-save-session
;;  wg-switch-to-workgroup wg-switch-to-previous-workgroup
;;  :bind (("<pause>" . wg-reload-session)
;;         ("C-S-<pause>" . wg-save-session)
;;         ("s-z" . wg-switch-to-workgroup)
;;         ("s-/" . wg-switch-to-previous-workgroup))
    ;; WG file:
(setq
 wg-session-file (concat my-emacs-files-dir "workgroups")
 wg-open-this-wg nil
 wg-use-default-session-file nil
 wg-mode-line-decor-left-brace "["
 wg-mode-line-decor-right-brace "]"
 wg-mode-line-only-name t           ; show only current WG name
 wg-display-nowg t                ; if no workgroups - display nothing
 wg-mode-line-use-faces t           ; colorize mode line
 wg-use-faces t                     ; colorize messages
 ;;wg-mode-line-only-name nil
 ;;wg-restore-associated-buffers nil

 wg-flag-modified nil
 wg-emacs-exit-save-behavior           nil
 wg-workgroups-mode-exit-save-behavior nil
 wg-mess-with-buffer-list nil
 )
;; (window-next-buffers (selected-window))
;; next-buffer

(global-set-key (kbd "<pause>")     'wg-reload-session)
(global-set-key (kbd "C-S-<pause>") 'wg-save-session)
(global-set-key (kbd "s-z")         'wg-switch-to-workgroup)
(global-set-key (kbd "s-/")         'wg-switch-to-previous-workgroup)

;; Keyboard shortcuts - load, save, switch
;;(global-set-key (kbd "<pause>")     'wg-reload-session)
;;(global-set-key (kbd "C-S-<pause>") 'wg-save-session)
;;(global-set-key (kbd "s-z")         'wg-switch-to-workgroup)
;;(global-set-key (kbd "s-/")         'wg-switch-to-previous-workgroup)
    ;;;;(global-set-key (kbd "<s-f1>") (lambda () (interactive) (my-switch-wg-to "mail" )))
    ;;;;(global-set-key (kbd "<s-f2>") (lambda () (interactive) (my-switch-wg-to "music")))


;; Define my functions
(defun my-switch-wg-to (workgroup)
  "Switch to WORKGROUP (name) or return to previous one."
  (interactive)
  (if (equal (wg-workgroup-name (wg-current-workgroup)) workgroup)
      (wg-switch-to-previous-workgroup)
    (wg-switch-to-workgroup workgroup))
  (message (wg-workgroup-name (wg-current-workgroup))))

(defun test-and-load-workgroups ()
  "Load workgroups if it's not a Capture frame."
  (interactive)
  (workgroups-mode 1)
  (with-selected-frame (selected-frame)
    (when (not (equal "capture" (frame-parameter nil 'name)))
      (wg-reload-session)
      (select-frame-set-input-focus (selected-frame)))
    (select-frame-set-input-focus (selected-frame))))

(defun load-workgroups-if-needed()
  (run-with-idle-timer 0.5 nil 'test-and-load-workgroups))

(defun set-my-frame-title (frame)
  "Set FRAME title format."
  (interactive)
  (setq frame-title-format '("" "%b - Emacs " emacs-version))

  ;; sudo apt-get install ttf-anonymous-pro
  ;;(set-frame-font "Anonymous pro-12")
  ;;(set-frame-font "Ubuntu mono-12")
  ;;(set-frame-font "LiberationMono-11")
  ;;(set-frame-font "Inconsolata")
  ;;(set-frame-font "DejaVu Sans Mono")
  ;;(set-frame-parameter frame 'font "Monospace-11")
  )

(add-hook 'after-make-frame-functions 'set-my-frame-title)
;; (workgroups-mode 1)



(provide 'init-workgroups)
;;; init-workgroups.el ends here
