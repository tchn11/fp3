
(defun read-line-cons ()
  (read-line))

(defun ask (string)
  (write-string string)
  (terpri)
  (read-line-cons))

(defun split-by-one-space (string)
  (loop for i = 0 then (1+ j)
	as j = (position #\Space string :start i)
	collect (subseq string i j)
	while j))

(defun read-from-files (filename)
  (let ((points (list nil))
        (stream (open filename
		      :direction :input
		      :if-does-not-exist :error)))
    (let ((input-string (read-line stream nil :eof)))
      (loop while (not (string= input-string "EOF")) do
            (push (split-by-one-space (string-trim '(#\Newline #\Return) input-string)) (cdr (last points)))
            (setq input-string (read-line stream nil :eof))))
    (close stream)
    (stable-sort
     (map 'list #'(lambda (x)
		    (list (parse-integer (car x)) (parse-integer (cadr x))))
	  (remove-if-not (lambda (x) x) points))
     #'(lambda (x y) (< (car x) (car y))))))

(defun read-from-input (n)
  (let ((points (list nil)))
    (dotimes (i n)
      (push (split-by-one-space (read-line-cons)) (cdr (last points))))
    (stable-sort
     (map 'list #'(lambda (x)
		    (list (parse-integer (car x)) (parse-integer (cadr x))))
	  (remove-if-not (lambda (x) x) points))
     #'(lambda (x y) (< (car x) (car y))))))
