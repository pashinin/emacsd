;;; init-emms --- EMMS
;;; Commentary:
;; http://www.emacswiki.org/emacs/init-emms.el
;; Manual - http://www.gnu.org/software/emms/manual/
;;; Code:

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

;;(emms-devel)
(emms-standard)

;; When asked for emms-play-directory,
;; always start from this one
(setq emms-source-file-default-directory "/usr/data/disk_3/Music/SORT/")

;;(emms-setup 'default emms-source-file-default-directory)

(setq emms-player-mpd-server-name "localhost")
(setq emms-player-mpd-server-port "6600")

;; Encoding
;; Set default-file-name-coding-system to the correct encoding of your
;; file names. It might even work to set it to undecided and let Emacs
;; guess.

(emms-default-players)

(add-hook 'emms-player-started-hook 'emms-show)
(setq emms-show-format "NP: %s")

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

(provide 'init-emms)
;;; init-emms.el ends here
