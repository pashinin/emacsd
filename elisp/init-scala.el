;;; init-scala.el --- Just testing Scala
;;; Commentary:
;; Copyright (C) Sergey Pashinin
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;; Code:

(require 'scala-mode2)

;; load the ensime lisp code...
(add-to-list 'load-path "~/ensime/elisp/")
(require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(provide 'init-scala)
;;; init-scala.el ends here
