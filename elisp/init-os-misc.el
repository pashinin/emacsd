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

;;(defun my-compress-pictures ()
;;  "Make a .djvu file from all or marked pictures."
;;  (interactive)
;;  (when (eq major-mode 'dired-mode)
;;    ;; create a file with list of images
;;    (let ((tmpfile (make-temp-file "makedjvu-" nil ".txt"))
;;          (files (dired-get-marked-files)))
;;      ;;(message (dired-get-marked-files))
;;      (with-temp-buffer
;;        (dolist (elt files)
;;          (insert elt "\n"))
;;        (write-file tmpfile)))
;;    ;; feed it to script making djvu
;;  ))

(defun is-64bit-os ()
  "Return t if we are under 64 bit OS."
  (interactive)
  (if (eq system-type 'windows-nt)
      (file-directory-p "C:/Program files (x86)")
    nil))

;;C:\Program Files (x86)\WinCDEmu\vmnt64.exe D:\ubuntu-13.04-server-amd64.iso
(defun mount-iso (filename)
  "Mount ISO image FILENAME."
  (interactive)
  (let (p cmd)
    (if (eq system-type 'windows-nt)
        (setq p (if (is-64bit-os) "C:/Program Files (x86)/WinCDEmu/vmnt64.exe"
                  "C:/Program Files (x86)/WinCDEmu/vmnt.exe"))
      (setq p (if (is-64bit-os) "C:/Program Files (x86)/WinCDEmu/vmnt64.exe"  ; TODO: change for GNU/Linux
                "C:/Program Files (x86)/WinCDEmu/vmnt.exe")))
    (if (not (file-exists-p p))
        (if (eq system-type 'windows-nt)
            (error "Install WinCDEmu")
          (error "Install mounting program")))
    (setq p (shell-quote-argument p))
    (setq cmd (concat p " " (shell-quote-argument filename)))
    (shell-command cmd)))

(provide 'init-os-misc)
;;; init-os-misc.el ends here
