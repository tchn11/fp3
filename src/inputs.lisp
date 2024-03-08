
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

(defun open-file (filename)
  (open filename
		      :direction :input
		      :if-does-not-exist :error))

(defun read-from-files (stream)
  (let ((input-string (read-line stream nil :eof)))
      (if (string= input-string "EOF")
        nil
        (map 'list #'(lambda (x) (parse-integer x))
          (split-by-one-space (string-trim '(#\Newline #\Return) input-string))))))

(defun read-from-input () 
  (map 'list #'(lambda (x) (parse-integer x))
          (split-by-one-space (string-trim '(#\Newline #\Return) (read-line-cons)))))
