;;; init-db.el --- Work with daatabases
;;; Commentary:
;; Copyright (C) Sergey Pashinin
;; Author: Sergey Pashinin <sergey@pashinin.com>
;;
;; Used: https://github.com/kiwanami/emacs-edbi
;; Install
;;   sudo cpan RPC::EPC::Service
;;   sudo cpan DBD::Pg
;;
;; Data source: dbi:Pg:dbname=my_database;host=10.0.0.1
;; user
;; password
;;
;; Keys:
;;
;;; Code:

(require 'init-variables)
(add-to-list 'load-path (concat my-emacs-ext-dir "edbi"))
(require 'edbi)
;;(unload-feature 'edbi)

;;ctbl:table-mode-map
(define-key ctbl:table-mode-map (kbd "<right>") 'ctbl:navi-move-right)
(define-key ctbl:table-mode-map (kbd "<left>") 'ctbl:navi-move-left)


(provide 'init-db)
;;; init-db.el ends here
