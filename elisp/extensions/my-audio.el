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

(defun sound-length (filename)
  "Return sound FILENAME length in seconds (approx)."
  (interactive)
  (let (res p1 p2)
    (setq res (shell-command-to-string
               (concat
                "avconv -i \"" filename
                "\" 2>&1 | awk '/Duration/ { print substr($2,0,length($2)-1) }'")))
    (if (= (length res) 0)
        (error (concat "Can't detect sound length " filename)))
    (with-temp-buffer
      (insert res)
      (goto-char 0)
      (+ (* (string-to-number (buffer-substring 1 3)) 3600)
         (* (string-to-number (buffer-substring 4 6)) 60)
         (string-to-number (buffer-substring 7 9)))
      )))

(defun sound-length-diff (filename1 filename2)
  "Return difference (in seconds) of lengths of files.
FILENAME1, FILENAME2 - mp3/ogg filenames."
  (interactive)
  (abs (- (sound-length filename1)
          (sound-length filename2))))

(defun my-ogg-quality-for-mp3 (filename)
  "Return 0..10 OGG quality for mp3 FILENAME."
  (interactive)
  (let ((b (sound-bitrate filename)))
    (cond
     ((> b 300) 9)
     ((> b 250) 8)
     ((> b 190) 7)
     ((> b 130) 6)
     (t 5)
     )))

(defun ogg-add-cover (image ogg)
  "Add/Replace album art IMAGE to OGG filename."
  (interactive)
  (shell-command-to-string (concat "~/.emacs.d/gnulinux/oggart "
                                   (shell-quote-argument ogg) " " image)))

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
        ;;(shell-command (concat "avconv -y -i \"" tmpmp3 "\" -an -vcodec copy /tmp/cover.jpg"))
        (with-temp-message ""
          (shell-command (concat "eyeD3 --write-images=/tmp \"" tmpmp3 "\" > /dev/null"))

          ;; remove mp3 shitty comments that web-sites like to include:
          (shell-command-to-string (concat "eyeD3 --to-v1.1 \"" tmpmp3 "\""))
          (shell-command-to-string (concat "eyeD3 --remove-v2 --set-user-url-frame=\"\" --remove-comments --remove-images \"" tmpmp3 "\""))
          (shell-command-to-string (concat "/home/xdev/.emacs.d/gnulinux/cleanmp3tags.py \"" tmpmp3 "\"")))

        (setq cmd (concat
                   "avconv -i \""
                   tmpmp3
                   "\" -acodec libvorbis -y "
                   ;;" -ar 44100 "
                   (if quality
                       (concat "-aq " (number-to-string quality))
                     (if (fboundp 'my-ogg-quality-for-mp3)
                         (concat "-aq " (number-to-string
                                         (my-ogg-quality-for-mp3 filename))) "-aq 5"))
                   " \"" dst "\""))
        (shell-command-to-string cmd)


        (let (files cover res tmp)
          (setq files (list "FRONT_COVER.jpeg"
                            "FRONT_COVER.jpg"
                            "OTHER.jpeg"
                            "OTHER.jpg"))
          (setq cover (dolist (el files res)
                        (setq tmp (concat "/tmp/" el))
                        (if (file-exists-p tmp) (setq res tmp))))
          (if cover
              (when (file-exists-p cover)
                ;;(shell-command-to-string (concat "~/.emacs.d/gnulinux/oggart "
                ;;                                 (shell-quote-argument dst) " " cover))
                (ogg-add-cover cover dst)
                (shell-command-to-string (concat "rm " cover))
                )))

        ;; check length
        (when (> (sound-length-diff tmpmp3 dst) 3)  ; more than 3s
          (shell-command (concat "rm " (shell-quote-argument dst)))
          (error (concat "Corrupted sound file " filename)))

        (shell-command-to-string (concat "rm \"" tmpmp3 "\""))
        ))))

(defun make-art-image (img &optional maxsize)
  "Return filename of created album art image for ogg file.
Makes a JPG-image IMG of size less than MAXSIZE Kb."
  (interactive)
  (if (not (file-exists-p img))
      (error (concat "No file: " img)))
  (let (msize size w h p
        (miw 300)
        (mih 300)
        (dst "/tmp/image_new.jpg"))
    (setq msize (or maxsize 50000.0))
    (setq size (string-to-number
                (shell-command-to-string (concat "stat -c %s "
                                                 (shell-quote-argument img)))))
    (setq p (round (* (/ msize (float size)) 400.0)))
    (setq p (- 100 p))
    ;; (round (* (/ 5 (float 10)) 100))
    (if (< p 100)
        (progn
          (shell-command (concat "convert "
                                 (shell-quote-argument img)
                                 " -resize " (number-to-string p) "% "
                                 dst))

                       dst)
      img)
    ))

(provide 'my-audio)
;;; my-audio.el ends here
