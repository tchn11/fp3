(defun get_x (point)
    (car point))

(defun get_y (point)
    (cadr point))


; Решение системы уравнений методов Гаусса-Зейделя
(defun calc-system (array n)
    (let ((max-iterations 100000)
        (epsilon 0.00001)
        (vector-old-ans (make-array n :initial-element 0))
        (vector-ans (make-array n :initial-element 0))
        (difference (+ 0.00001 1))
        (num 0))

    (loop while (> difference epsilon) do
        (loop for i below n do
            (let ((sum 0))
            (loop for j below n do
                (when (not (= i j))
                    (setq sum (+ sum (* (/ (aref array i j) (aref array i i)) (aref vector-ans j))))))
            (setf (aref vector-ans i) (- (/ (aref array i n) (aref array i i)) sum))))

        (let ((max-difference 0.0))
            (loop for i below n do
            (when (> (abs (- (aref vector-old-ans i) (aref vector-ans i))) max-difference)
                (setf max-difference (abs (- (aref vector-old-ans i) (aref vector-ans i)))))
            (setf difference max-difference)))

        (loop for i below n do
            (setf (aref vector-old-ans i) (aref vector-ans i)))

        (setf num (+ num 1))
        (assert (< num max-iterations)))

    vector-ans))
