;;; init-capture --- Capture video from screen
;;; Commentary:
;;; Code:

(require 'init-variables)

(add-to-list 'load-path (concat my-emacs-ext-dir "capture/src"))
(when (require 'capture nil 'noerror)

  (defcustom my-default-wallpaper
    "1920/wallpaper.png" "My default wallpaper."
    :group 'my-vars)

  (defcustom my-1280-wallpaper
    "1920/wallpaper1280.png" "Background filename for capturing 1280px video."
    :group 'my-vars)

  (defcustom my-854-wallpaper
    "1920/wallpaper854.png" "Background filename for capturing 854-420px video."
    :group 'my-vars)

  (defun set-default-wallpaper ()
    "Set your desktop wallpaper to `capture-default-wallpaper'."
    (interactive)
    (set-desktop-background
     (concat capture-background-path my-default-wallpaper)))

  ;; my own variables
  (setq
   capture-background-path "/usr/data/local1/screencasts/01.my_wallpaper/"
   my-default-wallpaper "1920/wallpaper.png"
   my-1280-wallpaper "1920/wallpaper1280.png"
   my-854-wallpaper "1920/wallpaper854.png")
  (setq capture-video-dest-dir "~/screencasts/SORT/")
  (when (eq system-type 'windows-nt)
    (setq
     capture-background-path "/usr/data/local1/screencasts/01.my_wallpaper/"
     capture-video-dest-dir "D:/screencasts/SORT/"
     capture-video-temp-dir "D:/temp/"))    ; (getenv "Temp")
  ;;(file-exists-p "D:/screencasts/SORT/")

  (global-set-key (kbd "<s-f12>") 'capture-run-mode)

  (defcustom my-capture-args ""
    "Additional params for ffmpeg (avconv)."
    :group 'my-vars)

  (setq my-capture-args
        (if (eq system-type 'windows-nt)
            (concat " -rtbufsize 500000"
                    " -b:v 1M "
                    " -qmin 0 -qmax 50"
                    " -threads 2")
          (concat " -q 1 "
                  " -b 8500000"
                  " -bt 8000000"
                  " -preset ultrafast -threads 2")))

  (defun my-capture-presets ()
    "Make my presets for capturing."
    (interactive)
    (capture-presets-clear)
    (capture-add-preset 524 333 854 480 15 "webm" "" "854px (no audio)")
    (capture-add-preset 0   0   854 480 15 "webm" "" "854px (top left)")
    (capture-add-preset 0   0  1280 720 15 "webm" my-capture-args "1280px (top left)")
    (capture-add-preset 640 0  1280 720 15 "webm" my-capture-args "1280px (top right)")
    ;;(capture-add-preset 454 74 1280 720 15 "webm" my-capture-args "1280px (default)")
    (capture-add-preset 504 194 1280 720 15 "webm" my-capture-args "1280px (default)")
    )
  (my-capture-presets)
  ;; example
  ;;(capture-add-preset 454 74 1280 720 15 "webm"
  ;;                    "-rtbufsize 500000 -b:v 1M -qmin 0 -qmax 50 -threads 2"
  ;;                    "1280px (+mic)"
  ;;                    ;;(list "Webcam C270 Analog Mono")
  ;;                    ;;(list "Microphone (Realtek High Defini")
  ;;                    nil
  ;;                    (concat capture-background-path my-1280-wallpaper))


  (defun capture-before-capture ()
    "Run this function before starting capturing."
    (interactive)
    (suspend-frame)
    )

  (defun capture-after-capture ()
    "Run this function after we stopped capturing video."
    (interactive)
    (set-desktop-background
     (concat capture-background-path my-default-wallpaper)))
  ;; (capture-after-capture)

  (defun emacs-frame-854 ()
    "Create an Emacs frame that fits 854 pixel width."
    (interactive)
    (let ((frameold (selected-frame))
          (frame (make-frame '((name . "capture")
                               (title . "Emacs")
                               (top . 340) (left . 527)
                               (width . 92) (height . 23)))))
      (with-selected-frame frame
        (switch-to-buffer (get-buffer-create "*scratch*")))
      (with-selected-frame frameold
        (suspend-frame))))

  (defun firefox-frame-854 ()
    "Create a Firefox window that fits 854 pixel width."
    (interactive)
    (if (eq system-type 'windows-nt)
        (async-start (lambda ()
                       (call-process "C:/Program Files (x86)/Mozilla Firefox/firefox.exe"))
                     (lambda (res)))
      (shell-command "firefox -private -new-window about:blank"))
    (sleep-for 1)
    (if (not (eq system-type 'windows-nt))
        (shell-command
         (concat "wmctrl -r :ACTIVE: -e 0,524," (number-to-string (- 333 31)) ",854,482")))
    )

  (defun terminal-854 ()
    "Create a terminal window of 854px width."
    (interactive)
    (capture-run-daemonized-command-no-buf
     "gnome-terminal --geometry=94x25+526+332"))

  (defun terminal-1280 ()
    "Create a terminal for 720p video."
    (interactive)
    (capture-run-daemonized-command-no-buf
     "gnome-terminal --geometry=125x35+575+222"))
)

(provide 'init-capture)
;;; init-capture.el ends here
