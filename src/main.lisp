(load "src/methods.lisp")
(load "src/generator.lisp")
(load "src/inputs.lisp")

(defun main (points generator line)
  (let ((currentx (next generator))
        (input-points points)
        (tmp-points points)
        (out-list (list nil)))
    (when line
      (setq input-points (list (car points) (cadr points)))
      (setq tmp-points (cdr points)))
    (loop while currentx do
	  (when line
	    (let ((second-point (cadr input-points)))
	      (when (and (cadr tmp-points) (> currentx (get-x second-point)))
		(setq input-points (list (car tmp-points) (cadr tmp-points)))
		(setq tmp-points (cdr tmp-points)))))
	  (print currentx)
	  (write-string " ")
	  (let ((result
		 (if line
		     (line (coerce input-points 'vector) currentx)
		   (degree input-points currentx))))
	    (write result)
	    (push (list currentx result) (cdr (last out-list))))
	  (setq currentx (next generator)))
    out-list))

(defun run-main ()
  (if (string= (ask "Input from files? (y/n)") "y")
      (main (read-from-files (ask "Enter filename:")) (range 8 1 0) (string= (ask "Line method? (y/n)") "y"))
    (main (read-from-input (parse-integer (ask "Enter number of points:"))) (range 8 1 0) (string= (ask "Line method? (y/n)") "y"))))
