;;; init-scala.el --- Just testing Scala
;;; Commentary:
;; Copyright (C) Sergey Pashinin
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;
;; Notes
;; =================
;; 1. Scala language - "Object-Oriented Meets Functional" (http://www.scala-lang.org/)
;; 2. SBT is the scala build tool
;; 3. Ensime is the ENhanced Scala Interaction Mode for Emacs
;;      video: What is Ensime?
;;             www.youtube.com/watch?v=cd2LV0xy9G8
;;
;;
;; Installation
;; =================
;; 1. Install SBT
;;    * Go to: http://www.scala-sbt.org/release/tutrial/Installing-sbt-on-Linux.html
;;    * Download and install .deb
;; 2. M-x list-packages - ensime, scala-mode2
;;
;; Run
;; =======
;; 1. Open .scala file
;; 2. ensime-sbt-switch (C-c C-v s)
;;
;;; Code:

;;(req-package scala-mode2)

;; Ensime
;; Can be installed from Melpa: M-x list-packages
;; (add-to-list 'load-path "~/ensime/elisp/")
(require 'req-package)
(req-package ensime
:ensure t
  :commands ensime-scala-mode-hook
  :require scala-mode2
  :config
  (progn
    ;; This step causes the ensime-mode to be started whenever
    ;; scala-mode is started for a buffer. You may have to customize this step
    ;; if you're not using the standard scala mode.
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
    ))

(provide 'init-scala)
;;; init-scala.el ends here
