(load "src/methods.lisp")
(load "src/generator.lisp")
(load "src/inputs.lisp")

(defun main-loop (points generator line out-list input-points)
	(let ((currentx (next generator)))
    (if currentx
		(let ((points-iter
		(let ((second-point (car (last input-points))))
		      (if (> currentx (get-x second-point))
			  	(let ((new-point (read-from-files points)))
				(if new-point
					(progn
					(push new-point (cdr (last input-points)))
					(cdr input-points))
					input-points))
				input-points))))
	  (print currentx)
	  (write-string " ")
	  (let ((result
		 (if line
		     (line (coerce points-iter 'vector) currentx)
		   (degree points-iter currentx))))
	    (write result)
	    (push (list currentx result) (cdr (last out-list))))
		(main-loop points generator line out-list points-iter))
	out-list)))

(defun main (points generator line)
(let ((input-points (if line (list (read-from-files points) (read-from-files points))
							(list (read-from-files points) (read-from-files points) (read-from-files points) (read-from-files points))))
        (out-list (list nil)))
		(main-loop points generator line out-list input-points)
))

(defun run-main ()
  (main (open-file (ask "Enter filename:")) (range 8 1 0) (string= (ask "Line method? (y/n)") "y")))
