;;; init-os-misc --- description
;;; Commentary:
;;; Code:

(require 'dired)

(defun toggle-fullscreen ()
  "Maximize Emacs window."
  (interactive)
  (if (eq system-type 'windows-nt)
      (if (fboundp 'w32-send-sys-command) ;; if we really have this function
          (w32-send-sys-command 61488))
    (when (fboundp 'x-send-client-message)
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
      )))
;; all created frames - fullscreen
;;(add-to-list 'default-frame-alist '(fullscreen . maximized))

(defun emacs-process-p (pid)
  "If PID is the process ID of an Emacs process, return t, else nil.
Also returns nil if PID is nil."
  (when pid
    (let* ((cmdline-file (concat "/proc/" (int-to-string pid) "/cmdline")))
      (when (file-exists-p cmdline-file)
        (with-temp-buffer
          (insert-file-contents-literally cmdline-file)
          (goto-char (point-min))
          (search-forward "emacs" nil t)
          pid)))))

(defadvice desktop-owner (after pry-from-cold-dead-hands activate)
  "Don't allow dead emacsen to own the desktop file."
  (when (not (emacs-process-p ad-return-value))
    (setq ad-return-value nil)))


;; -----

(defun run-daemonized-command (cmd &optional buf)
  "Run a system command CMD even after you kill Emacs.
Write output to BUF."
  (async-shell-command (concat "nohup " cmd " >/dev/null 2>&1") buf))

(defun run-daemonized-command-no-buf (cmd)
  "Run a shell command CMD deatached from process.
Do not show any buffers."
  (interactive)
  (let ((buf (generate-new-buffer "**async-command**")))
    (run-daemonized-command cmd buf)
    (run-with-timer 3 nil (lambda (buf) (kill-buffer buf)) buf)))

(defun my-restart-emacs ()
  "Kill Emacs and run script to restart Emacs."
  (interactive)
  (if (not (eq system-type 'windows-nt))
      (run-daemonized-command "/bin/sh ~/.emacs.d/gnulinux/wait_and_start_emacs.sh"))
  (kill-emacs))

(defun my-notify-popup (title msg &optional icon sound)
  "Show a popup if we're on X, or echo it otherwise.
TITLE is the title of the message, MSG is the
context.  Optionally, you can provide an ICON and a SOUND to be
played."
  (interactive)
  (save-window-excursion
    (run-daemonized-command-no-buf (concat "play " sound)))
  (if (eq window-system 'x)
      (shell-command (concat "notify-send "
                             (if icon (concat "-i " icon) "")
                             " '" title "' '" msg "'"))
    (message (concat title ": " msg))))

;; (my-notify-popup "title2" "msg2" "~/.emacs.d/bindata/icons/email_envelope.png" "/usr/share/sounds/gnome/default/alerts/drip.ogg")

(defun is-64bit-os ()
  "Return t if we are under 64 bit OS."
  (interactive)
  (if (eq system-type 'windows-nt)
      (file-directory-p "C:/Program files (x86)")
    nil))

;; C:\Program Files (x86)\WinCDEmu\vmnt64.exe D:\ubuntu-13.04-server-amd64.iso
(defun mount-iso (filename)
  "Mount ISO image FILENAME."
  (interactive)
  (let (p cmd)
    (cond
     ((eq system-type 'windows-nt)
      (setq p (if (is-64bit-os) "C:/Program Files (x86)/WinCDEmu/vmnt64.exe"
                "C:/Program Files (x86)/WinCDEmu/vmnt.exe"))
      (if (not (file-exists-p p)) (error "Install WinCDEmu"))
      (setq p (shell-quote-argument p))
      (shell-command (concat p " " (shell-quote-argument filename))))
     (t
      ;;(error "Don't know the system to use mounting")
      ;;fuseiso example.iso example
      (setq cmd (concat "fuseiso " (shell-quote-argument filename)))
      (shell-command cmd)
      ))))


(defcustom var-libreoffice-exe nil
  "Explicitly point to LibreOffice executable."
  :group 'my-vars)

(defun libreoffice-exec ()
  "Return a full path to LibreOffice executable."
  (interactive)
  (if var-libreoffice-exe
      var-libreoffice-exe
    (let (files res)
      (if (eq system-type 'windows-nt)
          (progn
            (setq files (list
                         "C:/Program Files (x86)/LibreOffice 4/program/soffice.exe"
                         "C:/Program Files (x86)/LibreOffice 4.0/program/soffice.exe"))
            (dolist (element files res)
              (if (file-exists-p element)
                  (setq res element))))
        "libreoffice"))))

;; doesn't work on windows
(defun libreoffice-convert (filename format)
  "Convert fucking doc FILENAME to FORMAT."
  (interactive)
  (message "converting")
  (let (office cmd)
    (setq office (libreoffice-exec))

    (setq cmd (concat (shell-quote-argument office)
                      " --headless"
                      " --invisible"
                      " --convert-to " format
                      " "
                      ;;" --outdir D:/"
                      (shell-quote-argument filename)
                      ;;filename
                      ))
    (message (shell-command-to-string cmd))
    ;;(message cmd)
    ;;(kill-ring-save cmd)
    ))

(defun files-stats (files)
  "Return a list of (extension . count).
FILES - a list of files to analyze.
Case of extension string is lowered."
  (interactive)
  (let ((res '()) ext count)
    (dolist (el files res)
      (if (file-directory-p el)
          (setq ext "DIR")
        (setq ext (downcase (or (file-name-extension el) ""))))
      ;;(assoc "ext" res)       ;    (ext . count)
      (setq count (or (cdr (assoc ext res))
                      0))
      (setq res (delq (assoc ext res) res))
      (add-to-list 'res `(,ext . ,(+ count 1)))
      )))
;; (length (files-stats (list "asd" "aasd.a" "/tmp")))

(defun files-ogg-1jpg (stats)
  "Return t if all files in STATS are ogg + 1 jpg.
STATS is returned by `files-stats'."
  (interactive)
  (when (= (length stats) 2)
    (when (and (assoc "ogg" stats)
               (assoc "jpg" stats))
      (= (cdr (assoc "jpg" stats)) 1)
      )))
;; (files-stats (list "asd.jpg" "aasd.ogG"))

(defun get-first-image-from-files (files)
  "Return the first filename from FILES that is an image.
That ends with .jpg or .png."
  (interactive)
  (catch 'loop
    (let (res ext)
      (dolist (el files res)
        ;;(info "(elisp) Examples of Catch")
        (setq ext (downcase (or (file-name-extension el) "")))
        (when (or (string= ext "jpg")
                  (string= ext "jpeg"))
          (setq res el)
          (throw 'loop el)
          )))))
;; (get-first-image-from-files (list "asd" "asd.jpg" "aasd.ogG"))

(defun get-files-by-extension (files ext)
  "Return a sublist from FILES where extension is EXT."
  (interactive)
  (let (res e)
    (dolist (el files res)
      (setq e (downcase (or (file-name-extension el) "")))
      (when (string= e ext)
        (if (not res)
            (setq res (list el))
          (add-to-list 'res el))
    ))))
;; (get-files-by-extension (list "asd" "asd.jpg" "aasd.ogG" "aa.ogg") "ogg")

(provide 'init-os-misc)
;;; init-os-misc.el ends here
