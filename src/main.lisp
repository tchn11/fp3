(load "src/methods.lisp")
(load "src/generator.lisp")
(load "src/inputs.lisp")

(defun main (points generator line)
  (let ((currentx (next generator))
        (input-points (if line (list (read-from-files points) (read-from-files points))
							(list (read-from-files points) (read-from-files points) (read-from-files points) (read-from-files points))))
        (out-list (list nil)))
    (loop while currentx do
		(let ((second-point (car (last input-points))))
		      (when (> currentx (get-x second-point))
			  	(let ((new-point (read-from-files points)))
				(when new-point
				(setq input-points (cdr input-points))
				(push new-point (cdr (last input-points)))))))
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
	(main (open-file (ask "Enter filename:")) (range 8 1 0) (string= (ask "Line method? (y/n)") "y")))
