(load "src/methods.lisp")
(load "src/generator.lisp")
(load "src/inputs.lisp")

(defun main (points generator line)
    (let ((num (next generator))
        (input_points points)
        (tmp_points points)
        (out_list (list nil)))
        (when line
            (setq input_points (list (car points) (cadr points)))
            (setq tmp_points (cdr points)))
        (loop while num do
            (when line
                (let ((first_point (cadr input_points)))
                    (when (and (cadr tmp_points) (> num (get_x first_point)))
                        (setq input_points (list (car tmp_points) (cadr tmp_points)))
                        (setq tmp_points (cdr tmp_points)))))
            (print num)
            (write-string " ")
            (let ((result
                (if line
                    (line (coerce input_points 'vector) num)
                    (degree input_points num))))
                (write result)
                (push (list num result) (cdr (last out_list))))
            (setq num (next generator)))
        out_list))

(defun run_main ()
    (if (string= (ask "Input from files? (y/n)") "y")
        (main (read_from_files (ask "Enter filename:")) (range 8 1 0) (string= (ask "Line method? (y/n)") "y"))
        (main (read_from_input (parse-integer (ask "Enter number of points:"))) (range 8 1 0) (string= (ask "Line method? (y/n)") "y"))))
