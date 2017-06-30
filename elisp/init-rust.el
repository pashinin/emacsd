

(require 'req-package)


(req-package rust-mode
  :mode "\\.rs\\'"
  :config (progn (defun rust-mode-indent-line ()
             (interactive)
             (let ((indent
                    (save-excursion
                      (back-to-indentation)
                      ;; Point is now at beginning of current line
                      (let* ((level (rust-paren-level))
                             (baseline
                              ;; Our "baseline" is one level out from the indentation of the expression
                              ;; containing the innermost enclosing opening bracket.  That
                              ;; way if we are within a block that has a different
                              ;; indentation than this mode would give it, we still indent
                              ;; the inside of it correctly relative to the outside.
                              (if (= 0 level)
                                  0
                                (or
                                 (when rust-indent-method-chain
                                   (rust-align-to-method-chain))
                                 (save-excursion
                                   (rust-rewind-irrelevant)
                                   (backward-up-list)
                                   (rust-rewind-to-beginning-of-current-level-expr)
                                   (+ (current-column) rust-indent-offset))))))
                        (cond
                         ;; Indent inside a non-raw string only if the the previous line
                         ;; ends with a backslash that is inside the same string
                         ((nth 3 (syntax-ppss))
                          (let*
                              ((string-begin-pos (nth 8 (syntax-ppss)))
                               (end-of-prev-line-pos (when (> (line-number-at-pos) 1)
                                                       (save-excursion
                                                         (forward-line -1)
                                                         (end-of-line)
                                                         (point)))))
                            (when
                                (and
                                 ;; If the string begins with an "r" it's a raw string and
                                 ;; we should not change the indentation
                                 (/= ?r (char-after string-begin-pos))

                                 ;; If we're on the first line this will be nil and the
                                 ;; rest does not apply
                                 end-of-prev-line-pos

                                 ;; The end of the previous line needs to be inside the
                                 ;; current string...
                                 (> end-of-prev-line-pos string-begin-pos)

                                 ;; ...and end with a backslash
                                 (= ?\\ (char-before end-of-prev-line-pos)))

                              ;; Indent to the same level as the previous line, or the
                              ;; start of the string if the previous line starts the string
                              (if (= (line-number-at-pos end-of-prev-line-pos) (line-number-at-pos string-begin-pos))
                                  ;; The previous line is the start of the string.
                                  ;; If the backslash is the only character after the
                                  ;; string beginning, indent to the next indent
                                  ;; level.  Otherwise align with the start of the string.
                                  (if (> (- end-of-prev-line-pos string-begin-pos) 2)
                                      (save-excursion
                                        (goto-char (+ 1 string-begin-pos))
                                        (current-column))
                                    baseline)

                                ;; The previous line is not the start of the string, so
                                ;; match its indentation.
                                (save-excursion
                                  (goto-char end-of-prev-line-pos)
                                  (back-to-indentation)
                                  (current-column))))))

                         ;; A function return type is indented to the corresponding function arguments
                         ((looking-at "->")
                          (save-excursion
                            (backward-list)
                            (or (rust-align-to-expr-after-brace)
                                (+ baseline rust-indent-offset))))

                         ;; A closing brace is 1 level unindented
                         ((looking-at "[]})]") (- baseline rust-indent-offset))

                         ;; Doc comments in /** style with leading * indent to line up the *s
                         ((and (nth 4 (syntax-ppss)) (looking-at "*"))
                          (+ 1 baseline))

                         ;; When the user chose not to indent the start of the where
                         ;; clause, put it on the baseline.
                         ((and (not rust-indent-where-clause)
                               (rust-looking-at-where))
                          baseline)

                         ;; If we're in any other token-tree / sexp, then:
                         (t
                          (or
                           ;; If we are inside a pair of braces, with something after the
                           ;; open brace on the same line and ending with a comma, treat
                           ;; it as fields and align them.
                           (when (> level 0)
                             (save-excursion
                               (rust-rewind-irrelevant)
                               (backward-up-list)
                               ;; Point is now at the beginning of the containing set of braces
                               (rust-align-to-expr-after-brace)))

                           ;; When where-clauses are spread over multiple lines, clauses
                           ;; should be aligned on the type parameters.  In this case we
                           ;; take care of the second and following clauses (the ones
                           ;; that don't start with "where ")
                           (save-excursion
                             ;; Find the start of the function, we'll use this to limit
                             ;; our search for "where ".
                             (let ((function-start nil) (function-level nil))
                               (save-excursion
                                 ;; If we're already at the start of a function,
                                 ;; don't go back any farther.  We can easily do
                                 ;; this by moving to the end of the line first.
                                 (end-of-line)
                                 (rust-beginning-of-defun)
                                 (back-to-indentation)
                                 ;; Avoid using multiple-value-bind
                                 (setq function-start (point)
                                       function-level (rust-paren-level)))
                               ;; When we're not on a line starting with "where ", but
                               ;; still on a where-clause line, go to "where "
                               (when (and
                                      (not (rust-looking-at-where))
                                      ;; We're looking at something like "F: ..."
                                      (looking-at (concat rust-re-ident ":"))
                                      ;; There is a "where " somewhere after the
                                      ;; start of the function.
                                      (rust-rewind-to-where function-start)
                                      ;; Make sure we're not inside the function
                                      ;; already (e.g. initializing a struct) by
                                      ;; checking we are the same level.
                                      (= function-level level))
                                 ;; skip over "where"
                                 (forward-char 5)
                                 ;; Unless "where" is at the end of the line
                                 (if (eolp)
                                     ;; in this case the type parameters bounds are just
                                     ;; indented once
                                     (+ baseline rust-indent-offset)
                                   ;; otherwise, skip over whitespace,
                                   (skip-chars-forward "[:space:]")
                                   ;; get the column of the type parameter and use that
                                   ;; as indentation offset
                                   (current-column)))))

                           (progn
                             (back-to-indentation)
                             ;; Point is now at the beginning of the current line
                             (if (or
                                  ;; If this line begins with "else" or "{", stay on the
                                  ;; baseline as well (we are continuing an expression,
                                  ;; but the "else" or "{" should align with the beginning
                                  ;; of the expression it's in.)
                                  ;; Or, if this line starts a comment, stay on the
                                  ;; baseline as well.
                                  (looking-at "\\<else\\>\\|{\\|/[/*]")

                                  ;; If this is the start of a top-level item,
                                  ;; stay on the baseline.
                                  (looking-at rust-top-item-beg-re)

                                  (save-excursion
                                    (rust-rewind-irrelevant)
                                    ;; Point is now at the end of the previous line
                                    (or
                                     ;; If we are at the start of the buffer, no
                                     ;; indentation is needed, so stay at baseline...
                                     (= (point) 1)
                                     ;; ..or if the previous line ends with any of these:
                                     ;;     { ? : ( , ; [ }
                                     ;; then we are at the beginning of an expression, so stay on the baseline...
                                     (looking-back "[(,:;?[{}]\\|[^|]|" (- (point) 2))
                                     (looking-back ">>" (- (point) 2))
                                     ;; or if the previous line is the end of an attribute, stay at the baseline...
                                     (progn (rust-rewind-to-beginning-of-current-level-expr) (looking-at "#")))))
                                 baseline

                               ;; Otherwise, we are continuing the same expression from the previous line,
                               ;; so add one additional indent level
                               (+ baseline rust-indent-offset))))))))))

               (when indent
                 ;; If we're at the beginning of the line (before or at the current
                 ;; indentation), jump with the indentation change.  Otherwise, save the
                 ;; excursion so that adding the indentations will leave us at the
                 ;; equivalent position within the line to where we were before.
                 (if (<= (current-column) (current-indentation))
                     (indent-line-to indent)
                   (save-excursion (indent-line-to indent)))))))
  )



(provide 'init-rust)
;;; init-rust.el ends here
