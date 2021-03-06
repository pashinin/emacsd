;;; init-f5 --- A magic key
;;; Commentary:
;; Just my experiments
;;; Code:

(req-package init-dired-z)
(req-package init-os-misc)
;(req-package coffee-mode)
(req-package my-cpp)
(req-package my-audio)
(req-package f
  :ensure t)

(defun file-under-path (path &optional filename)
  "Return t if PATH has a FILENAME in any folder under it."
  (interactive)
  (let* ((p (expand-file-name path)))
    (if filename
        (s-starts-with? p filename)
      (let ((file (expand-file-name (or buffer-file-name default-directory))))
        (s-starts-with? p file)
        ))))
;; (file-under-path "/d")
;; (file-under-path "/d" "/d/a.txt")


(defun my-magic-python (filename)
  "Run python shell with current FILENAME."
  (cond
   ((and (or (file-under-path "/var/www")
             (file-under-path "/var/www_production"))
         (file-exists-p "/var/www/.../reload"))
    (shell-command "touch reload"))
   (t
    (python-shell-send-buffer t))
   ))

(defun git-nothing-to-commit (dir)
  (let* ((default-directory dir))
    ;; (call-process "/bin/bash" nil "*scratch*" nil "-c" "echo working dir is $PWD")
    (string-equal
     ""
     (shell-command-to-string
      "git status | grep -q \"nothing to commit\" || echo -n \"fail\""))
    ))

(defun git-is-dirty (dir)
  (not (git-nothing-to-commit dir)))

(defun git-is-modified (filename)
  (not (git-nothing-to-commit dir)))

(defun do-magic-with-file (&optional filename flag1)
  "Do something useful with a given FILENAME.
If not given - use current buffer file or file under the cursor.
FLAG1 - is to do more fun.  Is set when <C-f5>."
  (interactive)
  (if (not filename)
      (let* ((f (buffer-file-name))
             (pashinin "/usr/data/local2/src/xdev/src/pashinin/"))
        (cond
         ((file-under-path pashinin)
          (if (yes-or-no-p "Publish pashinin.com?")
              (if (git-nothing-to-commit pashinin)
                  (message "nothing")
                (message "pashinin.com is dirty! Commit!"))
            (message "fu then")))

         ;; fundamental
         ((eq major-mode 'fundamental-mode)
          ;;(do-magic-with-file (buffer-file-name)))
          (do-magic-with-file (file-truename (buffer-file-name))))

         ;; Markdown
         ;; 1. https://github.com/joeyespo/grip
         ((eq major-mode 'markdown-mode)
          (let ((cmd (executable-find "mdown")))
            (unless cmd
              (error "Install Github's markdown - https://github.com/joeyespo/grip
sudo pip install grip")
              )
            (let ((markdown-command "mdown"))
              (shell-command (format "grip %s --export /tmp/md.html" (buffer-file-name)))
              (browse-url-of-file "/tmp/md.html")
              ;;(markdown-preview)
              )))

         ;; lisp
         ((eq major-mode 'emacs-lisp-mode)
          (byte-compile-file (buffer-file-name)))

         ((eq major-mode 'js3-mode)
          (if (fboundp 'inferior-moz-process)
              (comint-send-string (inferior-moz-process)
                                  "BrowserReload();")))

         ;; ((eq major-mode 'coffee-mode)

         ;;  (if flag1
         ;;      (let ((cmd (format "uglifyjs - -o %s"
         ;;                         (concat (file-name-sans-extension buffer-file-name) ".min.js"))))
         ;;        (coffee-compile-buffer)
         ;;        (with-current-buffer coffee-compiled-buffer-name
         ;;          (shell-command-on-region (point-min) (point-max) cmd)))
         ;;    ;; uglifyjs pkg.name.js --screw-ie8 --output pkg.name.min.js
         ;;    (if (fboundp 'coffee-compile-buffer)
         ;;        (coffee-compile-buffer))))

         ((eq major-mode 'sass-mode)
          (save-window-excursion
            (if (fboundp 'sass-output-buffer)
                (sass-output-buffer))))

         ;; dired
         ((eq major-mode 'dired-mode)
          (let ((f (dired-get-filename t t))
                (files (dired-get-marked-files))
                ext ext1)
            (save-window-excursion
              ;; TODO: analyze - what is selected in dired-mode
              (cond
               ((and f (= (length files) 1))  ; only 1 file
                (do-magic-with-file f))
               ((> (length files) 1)          ; more than 1 file selected
                (let ((stats (files-stats files))
                      img art)
                  (cond
                   ((files-many-plus-one stats "avi" "jpg")
                    (message "cover"))
                   ((files-many-plus-one stats "mkv" "jpg")
                    (message "cover"))
                   ((files-many-plus-one stats "ogg" "jpg")
                    (when (yes-or-no-p "Make this an album art for all OGG files?")
                      (setq img (get-first-image-from-files files))
                      (setq art (make-art-image img))
                      (dolist (el (get-files-by-extension files "ogg"))
                        (message el)
                        (ogg-add-cover art el))))
                   (t
                    (message "Do magic on each file...")
                    (mapc 'do-magic-with-file files))
                   )))
               (t
                (message "Nothing selected!") ; nothing selected!
                ))))
          (save-window-excursion (with-temp-message "" (revert-buffer))))

         ;; TeX
         ((and (fboundp 'latex-mode)
               (eq major-mode 'latex-mode))
          (my-tex-run-tex))

         ;; C++
         ((or (eq major-mode 'c++-mode)
              (eq major-mode 'c-mode)) (my-magic-cpp f))

         ;; Rust
         ((or
           (eq major-mode 'rust-mode)
           ;; (eq major-mode 'c-mode)
           )

          (save-window-excursion
            (compile "cargo build")
            )
          ;; (f-traverse-upwards
          ;;  (lambda (path)
          ;;    (f-exists? (f-expand ".git" path)))
          ;;  (f-dirname f))
          ;; (message "asd")
          )

         ;; Python
         ((eq major-mode 'python-mode) (my-magic-python f))

         ;; EMMS playlist
         ((eq major-mode 'emms-playlist-mode)
          ;; if on last line - add a new file to the playlist
          (let* ((current-track (emms-playlist-track-at (point)))
                 (next-track (emms-playlist-track-at (+ (line-end-position) 1)))
                 (f-current (cdr (assoc 'name current-track)))
                 (f-next (cdr (assoc 'name next-track)))
                 (resfile (or (do-magic-with-file f-current) "")))
            ;;(emms-playlist-track-at (end-of-line)
            ;;(emms-insert-file (do-magic-with-file f))

            (if (and (string= f-next resfile))
                (message "Already have it")
              ;;(emms-add-file resfile)
              (save-excursion
                (forward-line 1)
                (emms-insert-file resfile)
                ))))

         ;; .rst - ReStructured docs
         ;;
         ;; Run "make html" to generate documentation
         ((eq major-mode 'rst-mode)
          (let* ((d (file-name-directory (expand-file-name (buffer-file-name))))
                 (makefile (concat d "Makefile")))
            ;; sphinx-build
            ;; (if (not (executable-find "sphinx-build"))
            ;;     (error "Run sudo -H pip install sphinx sphinx_rtd_theme"))
            (if (file-exists-p makefile)
                (shell-command-to-string (concat "make -C " d " html"))
              (error "Can't find Makefile for RST project!"))
            ))

         ;; - Unknown mode -
         (t (message "Don't know what to do in this mode!"))
         ))


    ;; The following part of code executes when this function gets a
    ;; specific `filename' to work with.
    ;;
    ;; But just in case if `filename' is not good enough - take
    ;; `buffer-file-name'
    (let* ((f (or filename (buffer-file-name)))
           ;; (ffull (or filename (buffer-file-name)))
           (d (file-name-directory  (expand-file-name f)))
           (ext (downcase (or (file-name-extension f) ""))))

      ;; Remove garbage: thumbs.db files
      (if (file-exists-p (concat d "desktop.ini"))
          (shell-command-to-string (concat "rm \"" d "desktop.ini\"")))

      (if (file-directory-p f)
          (progn
            ;;(setq ext-regexp (make-regex-of-extensions (list ext)))
            ;;(dired-mark-files-regexp ext-regexp)
            (cond
             ((string= f "locale")
              (message "Rebuild locales and reload uwsgi.")
              ;; if no folders - create new localization
              ;; django-admin.py makemessages -l en
              ;; else - update "django-admin.py makemessages --all"
              (shell-command "django-admin.py makemessages --all")
              )
             (t
              (message f))
             )
            )

        ;; At this step we know that "f" variable is not a directory
        (progn

          (cond
           ;; if .cpp or .c - compile it with `my-magic-cpp'
           ((or (string= ext "cpp")
                (string= ext "c")) (my-magic-cpp f))

           ;; (7z, zip, rar) - as defined in `is-archive-ext'
           ((is-archive-ext f)     (message "archive"))

           ((string= ext "iso")    (mount-iso f))
           ((string= ext "rc")     (my-magic-rc-file f))
           ((string= ext "el")     (byte-compile-file f))

           ;; .sh
           ((string= ext "sh")
            ;;(byte-compile-file f)
            (capture-run-daemonized-command-no-buf
             (concat "gnome-terminal --geometry=125x35+575+222 "
                     "--working-directory=" d))
            ;;(message d)
            )

           ;; mp3 TODO:
           ;; if filename contains backtick - error happens
           ((or (string= ext "mp3")
                (string= ext "m4a")) (convert-mp3-ogg f))
           ((or (string= ext "doc")
                (string= ext "docx"))
            (libreoffice-convert f "odt"))

           ;; Makefile
           ((string= f "Makefile")
            (message "makefile stuff")
            )

           ;; ((or (string= ext "")
           ;;      (string= ext "m4a")) (convert-mp3-ogg f))
           ;; (shell-command (concat "make -C " d " html")))))

           (t
            (cond
             ((file-under-path "~/.emacs.d/snippets")
              (message "Reloading Emacs snippets...")
              (yas-reload-all))
             ((string= "reload" f)
              (message "Reloading...")
              (if (file-exists-p "reload")
                  (shell-command "touch reload")))
             (t
              (message (concat
                        "Don't know what to do with this file(s): "
                        f
                        ext)))
             ))))))))
;;(mapconcat nil '("" "home" "alex " "elisp" "erc") "/")

(defun do-magic-current-dir (&optional dir recursive child)
  "Do magic with all files recursively in current dir.
Or in specified DIR.
If RECURSIVE - call recursively.
CHILD - function called from other."
  (interactive)
  ;;dir
  (let ((d dir) files ext)
    (if (not dir) (setq d default-directory))
    (setq files (directory-files d t "\\.*"))
    (setq files (nthcdr 2 files))
    (dolist (el files)
      (message el)
      (sleep-for 1)
      (if (and (file-directory-p el)
               recursive)
          (do-magic-current-dir el)
        (do-magic-with-file el))
      )
    )
  (if (not dir)
      (when (eq major-mode 'dired-mode)
        (save-window-excursion (with-temp-message "" (revert-buffer)))))
  )

(defun do-magic-recursively ()
  "Do magic with all files recursively in current dir."
  (interactive)
  (do-magic-current-dir nil t))

(defun do-magic-action1 (&optional filename)
  "Do something else with a given FILENAME."
  (interactive)
  (if (not filename)
      (progn
        ;; lisp
        (when (eq major-mode 'emacs-lisp-mode)
          (byte-compile-file (buffer-file-name)))

        (when (eq major-mode 'dired-mode)
          (let ((f (dired-get-filename t t))
                (files (dired-get-marked-files))
                ext ext1)
            (save-window-excursion
              (if (and f (= (length files) 1))
                  (do-magic-with-file f)
                (mapc 'do-magic-with-file files))
              ))
          (save-window-excursion (with-temp-message "" (revert-buffer))))

        ;; tex
        (when (fboundp 'latex-mode)
          (when (eq major-mode 'latex-mode)
            (my-tex-run-tex)
            ))

        (let ((f (buffer-file-name)))
          ;; C++
          (when (eq major-mode 'c++-mode)
            (my-magic-cpp f))

          ;; Python
          (when (eq major-mode 'python-mode)
            (my-magic-python f))
          ))
    (let (ext ext1 f d)
      (setq f (or filename (buffer-file-name)))
      (setq d (file-name-directory f))
      (if (file-exists-p (concat d "desktop.ini"))
          (shell-command-to-string (concat "rm \"" d "desktop.ini\"")))
      (if (file-directory-p f)
          (progn
            ;;(setq ext-regexp (make-regex-of-extensions (list ext)))
            ;;(dired-mark-files-regexp ext-regexp)
            (message f))
        (progn
          (setq ext (downcase (or (file-name-extension f) "")))
          (cond ((or (string= ext "cpp")
                     (string= ext "c")) (my-magic-cpp f))
                ((is-archive-ext f)     (message "archive"))
                ((string= ext "iso")    (mount-iso f))
                ((string= ext "rc")     (my-magic-rc-file f))
                ((string= ext "el")     (byte-compile-file f))
                ((or (string= ext "mp3")
                     (string= ext "m4a")) (convert-mp3-ogg f))
                ((or (string= ext "doc")
                     (string= ext "docx"))
                 (libreoffice-convert f "odt"))
                )
          ))
      )
    ))

(defun do-magic-action2 (&optional filename)
  "Do something else with a given FILENAME."
  (interactive)
  (if (not filename)
      (progn
        ;; lisp
        (when (eq major-mode 'emacs-lisp-mode)
          (byte-compile-file (buffer-file-name)))

        (when (eq major-mode 'dired-mode)
          (let ((f (dired-get-filename t t))
                (files (dired-get-marked-files))
                ext ext1)
            (save-window-excursion
              (if (and f (= (length files) 1))
                  (do-magic-with-file f)
                (mapc 'do-magic-with-file files))
              ))
          (save-window-excursion (with-temp-message "" (revert-buffer))))

        ;; tex
        (when (fboundp 'latex-mode)
          (when (eq major-mode 'latex-mode)
            (my-tex-run-tex)
            ))

        (let ((f (buffer-file-name)))
          ;; C++
          (when (eq major-mode 'c++-mode)
            (my-magic-cpp f))

          ;; Python
          (when (eq major-mode 'python-mode)
            ;;(my-magic-python f)
            ;; Reload UWSGI
            ;; find empty "reload" file and "touch" it
            )
          ))
    (let (ext ext1 f d)
      (setq f (or filename (buffer-file-name)))
      (setq d (file-name-directory f))
      (if (file-exists-p (concat d "desktop.ini"))
          (shell-command-to-string (concat "rm \"" d "desktop.ini\"")))
      (if (file-directory-p f)
          (progn
            ;;(setq ext-regexp (make-regex-of-extensions (list ext)))
            ;;(dired-mark-files-regexp ext-regexp)
            (message f))
        (progn
          (setq ext (downcase (or (file-name-extension f) "")))
          (cond ((or (string= ext "cpp")
                     (string= ext "c")) (my-magic-cpp f))
                ((is-archive-ext f)     (message "archive"))
                ((string= ext "iso")    (mount-iso f))
                ((string= ext "rc")     (my-magic-rc-file f))
                ((string= ext "el")     (byte-compile-file f))
                ((or (string= ext "mp3")
                     (string= ext "m4a")) (convert-mp3-ogg f))
                ((or (string= ext "doc")
                     (string= ext "docx"))
                 (libreoffice-convert f "odt"))
                )
          ))
      )
    ))

;; default F5 action
(global-set-key (kbd "<f5>")     'do-magic-with-file)
(global-set-key (kbd "<S-f5>")   'do-magic-current-dir)
(global-set-key (kbd "<s-S-f5>") 'do-magic-recursively)

;; additional action 1 (M-f5)
(global-set-key (kbd "<M-f5>")   'do-magic-action1)

(defun git-repo-http ()
  "Return http url for current repo or nil."
  (interactive)
  (let ((u (s-trim (shell-command-to-string "git config --get remote.origin.url"))))
    (setq u (s-replace "git@" "https://" u))
    (setq u (s-replace "github.com:" "github.com/" u))
    u))


(defun test-in-my-vm ()
  "Try to find git repo and test it in a VM."
  (interactive)
  (let ((default-directory "~/.emacs.d/scripts/"))
    (insert (shell-command-to-string
             (concat "virsh snapshot-revert ubuntu-testbox clean-running --force")))
    (insert (shell-command-to-string (concat "fab ll:'" (git-repo-http) "'")))
    ;;(insert (git-repo-http))
    ;;
    ;;(message (shell-command-to-string "ls"))
    ))


;; run tests
;;(global-set-key (kbd "<C-f5>") 'test-in-my-vm)
(global-set-key (kbd "<C-f5>") '(lambda () (interactive) (do-magic-with-file nil t)))

(provide 'init-f5)
;;; init-f5.el ends here
