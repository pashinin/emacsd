;;; my-audio.el --- Functions to work with audio
;;; Commentary:
;; Copyright (C) Sergey Pashinin
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;; Code:

(defun sound-bitrate (filename)
  "Return ffmpeg -i FILENAME."
  (interactive)
  (let (res p1 p2)
    (setq res (shell-command-to-string (concat "ffmpeg -i \"" filename "\"")))
    (with-temp-buffer
      (insert res)
      (goto-char (point-max))
      (while (not (looking-at "bitrate"))
        (backward-char))
      (setq p1 (+ (point) 9))
      (while (not (looking-at " kb"))
        (forward-char))
      (string-to-number (buffer-substring p1 (point)))
      )))

(defun my-ogg-quality-for-mp3 (filename)
  "Return 0..10 OGG quality for mp3 FILENAME."
  (interactive)
  (let ((b (sound-bitrate filename)))
    (cond
     ((> b 300) 9)
     ((> b 250) 8)
     ((> b 180) 7)
     (t 6)
     )))

(defun convert-mp3-ogg (filename &optional quality)
  "Convert mp3 FILENAME to OGG with QUALITY 1..10.
If quality is omitted then chosen automatically."
  (interactive)
  (let (cmd basename basenameext p dst tmpmp3)
    (setq p (file-name-directory filename))
    (setq basenameext (file-name-nondirectory (or filename (buffer-file-name))))
    (setq basename (file-name-sans-extension basenameext))
    (setq dst (concat p basename ".ogg"))

    (if (file-exists-p dst) (message "Already converted")
      (progn
        ;; copy to /tmp
        (shell-command (concat "cp -f \"" filename "\" /tmp/"))
        (setq tmpmp3 (concat "/tmp/" basenameext))
        ;; extract cover art:
        (shell-command (concat
                        "avconv -y -i \"" tmpmp3
                        "\" -an -vcodec copy /tmp/cover.jpg"))

        ;; remove mp3 shitty comments that web-sites like to include:
        (shell-command-to-string (concat "eyeD3 --to-v1.1 \"" tmpmp3 "\""))
        (shell-command-to-string (concat "eyeD3 --remove-v2 --set-user-url-frame=\"\" --remove-comments --remove-images \"" tmpmp3 "\""))
        (shell-command (concat "/home/xdev/.emacs.d/gnulinux/cleanmp3tags.py \"" tmpmp3 "\""))

        (setq cmd (concat
                   "avconv -i \""
                   ;;filename
                   tmpmp3
                   "\" -acodec libvorbis -y "
                   (if quality
                       (concat "-aq " (number-to-string quality))
                     (if (fboundp 'my-ogg-quality-for-mp3)
                         (concat "-aq " (number-to-string
                                         (my-ogg-quality-for-mp3 filename))) "-aq 6"))
                   " \"" dst "\""))
        ;;(message cmd)
        (shell-command-to-string cmd)

        (when (file-exists-p "/tmp/cover.jpg")
          (shell-command (concat "~/.emacs.d/gnulinux/oggart \"" dst "\" /tmp/cover.jpg"))
          (shell-command-to-string "rm /tmp/cover.jpg"))
        (shell-command-to-string (concat "rm \"" tmpmp3 "\""))
        ))))

(provide 'my-audio)
;;; my-audio.el ends here
