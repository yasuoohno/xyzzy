(defun list-wrong-builtin-function-definition (pkg)
  (let ((fns nil)
        (defs nil))
    (do-external-symbols (sym pkg)
      (when (fboundp sym)
        (when (si:*builtin-function-p (symbol-function sym))
          (push sym fns))
        (when (member 'si::builtin-function-argument (symbol-plist sym))
          (push sym defs))))
    (list (set-difference fns defs)
          (set-difference defs fns))))

(deftest test-defun-builtin-1 ()
  "builtin.l �Œ�`����Ă��Ȃ� builtin �֐������݂��Ȃ�����"
  (values-list
   (mapcar #'car
           (mapcar #'list-wrong-builtin-function-definition
                   '(:lisp :system :editor))))
  => nil
  => nil
  => nil)

(deftest test-defun-builtin-2 ()
  "builtin.l �Œ�`����Ă���� builtin �֐������݂��Ȃ�����"
  (values-list
   (mapcar #'cadr
           (mapcar #'list-wrong-builtin-function-definition
                   '(:lisp :system :editor))))
  => nil
  => nil
  => nil)