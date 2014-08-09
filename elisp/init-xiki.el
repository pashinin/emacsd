;;; init-xiki --- description
;;; Commentary:
;;
;; How?
;; 1. Install xiki: https://github.com/trogdoro/xiki
;;    git clone git://github.com/trogdoro/xiki.git
;;    cd xiki
;;    sudo gem install bundler   # <- no "sudo" if using rvm
;;    sudo bundle                # <- no "sudo" if using rvm
;;    sudo ruby etc/command/copy_xiki_command_to.rb /usr/bin/xiki
;; 2. Install el4r
;;    sudo gem install el4r
;;    http://www.rubyist.net/~rubikitch/computer/el4r/index.en.html#label:10
;; 3.(add-to-list 'load-path "/var/lib/gems/1.9.1/gems/trogdoro-el4r-1.0.7/data/emacs/site-lisp")
;;   (require 'el4r)
;;   (el4r-boot)
;; When el4r is started, ~/.el4r/init.rb is automatically evaled by the
;; context of el4r. When it is the context of el4r; you can access the
;; EmacsLisp functions and variables in addition to usual Ruby. you can
;; define EmacsLisp functions.
;;
;;; Code:


;;(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(add-to-list 'load-path "/var/lib/gems/1.9.1/gems/trogdoro-el4r-1.0.7/data/emacs/site-lisp")
;;(require 'el4r)  ; EmacsLisp for Ruby - EmacsRuby engine

(require 'req-package)
(req-package el4r
  :commands el4r-boot)

;;(el4r-boot)

(provide 'init-xiki)
;;; init-xiki.el ends here
