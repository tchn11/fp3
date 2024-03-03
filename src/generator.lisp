(defclass lazy-seq ()
  ((next-fn :accessor seq-next-fn
            :initarg :next-fn)))

(defun make-lazy-seq(&optional next-fn)
  (make-instance 'lazy-seq :next-fn next-fn))

(defun next(seq)
  (funcall (seq-next-fn seq)))

(defun range(n st init)
  (let ((iter -1)
        (val (- init st)))
    (make-lazy-seq
     (lambda ()
        (incf iter)
        (incf val st)
        (if (< iter n) 
           (values val nil)
           (values nil t))))))
