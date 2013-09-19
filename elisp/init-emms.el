;;; init-emms --- EMMS
;;; Commentary:
;; http://www.emacswiki.org/emacs/init-emms.el
;; Manual - http://www.gnu.org/software/emms/manual/
;; http://emacser.com/emms.htm
;;; Code:

(unless (file-exists-p "~/.emacs.d/emms")
  (make-directory "~/.emacs.d/emms"))

(require 'emms-setup)
(require 'emms-player-mpg321-remote)
(require 'emms-player-mpd)

;;; Require
(require 'emms-mark)
(require 'emms-last-played)
(require 'emms-playlist-mode)
(require 'emms-source-file)
(require 'emms-playlist-sort)
(require 'emms)
(require 'emms-i18n)  ; autodetect musci files id3 tags encodeing

;;(emms-devel)
(emms-standard)

;; When asked for emms-play-directory, start from this one:
(setq emms-source-file-default-directory "/usr/data/disk_3/Music/SORT/")

(setq emms-player-mpd-server-name "localhost")
(setq emms-player-mpd-server-port "6600")

;; Encoding
;; Set default-file-name-coding-system to the correct encoding of your
;; file names. It might even work to set it to undecided and let Emacs
;; guess.

(emms-default-players)

(add-hook 'emms-player-started-hook 'emms-show)
;;(setq emms-show-format "NP: %s")
(setq emms-show-format "%s")

;; Want to use alsa with mpg321 ?
(setq emms-player-mpg321-parameters '("-o" "alsa"))

(setq emms-last-played-format-alist
      '(((emms-last-played-seconds-today) . "%a %H:%M")
	(604800                           . "%a %H:%M") ; this week
	((emms-last-played-seconds-month) . "%d")
	((emms-last-played-seconds-year)  . "%m/%d")
	(t                                . "%Y/%m/%d")))


(setq emms-playlist-buffer-name "*Music*")
(global-set-key (kbd "<C-XF86AudioPlay>") 'emms-pause)

;; my customizable playlist format
(defun bigclean-emms-info-track-description (track)
  "Return a description of the current TRACK."
  (let ((artist (emms-track-get track 'info-artist))
        (title (emms-track-get track 'info-title))
        (album (emms-track-get track 'info-album))
        (ptime (emms-track-get track 'info-playing-time)))
    (if title
        (format
         "%-35s %-40s %-35s %5s:%-5s"
         (if artist artist "")
         (if title title "")
         (if album album "")
         (/ ptime 60)
         (% ptime 60)))))
;;(setq emms-track-description-function
;;      'bigclean-emms-info-track-description)

(defun emms-my-hook ()
  "Run this in `emms-playlist-mode'."
  (interactive)
  (local-set-key (kbd "j") 'isearch-forward)
  )
;; (isearch-forward)
(add-hook 'emms-playlist-mode-hook 'emms-my-hook)


(provide 'init-emms)
;;; init-emms.el ends here
