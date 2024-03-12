(load "src/utils.lisp")

(defun line (points x)
  (let
      ((point1 (aref points (- (/ (length points) 2) 1)))
       (point2 (aref points (/ (length points) 2))))
    (+ (get-y point1) (* (- x (get-x point1)) (/ (- (get-y point2) (get-y point1)) (- (get-x point2) (get-x point1)))))))


(defun degree (points x)
  (let ((n (length points))
	(summ-x 0)
	(summ-x-sqd 0)
	(summ-y 0)
	(summ-x-y 0))

    ;; Суммируем логарифмы x и y
    (dotimes (i n)
      (incf summ-x (log (get-x (nth i points))))
      (incf summ-y (log (get-y (nth i points)))))

    ;; Суммируем квадраты логарифмов x
    (dotimes (i n)
      (incf summ-x-sqd (* (log (get-x (nth i points))) (log (get-x (nth i points))))))

    ;; Суммируем произведения логарифмов x и y
    (dotimes (i n)
      (incf summ-x-y (* (log (get-x (nth i points))) (log (get-y (nth i points))))))

    ;; Вычисляем систему уравнений
    (let ((system-array (make-array '(2 3)
				    :initial-contents (list (list summ-x-sqd summ-x summ-x-y) (list summ-x n summ-y)))))
      (let ((ans (calc-system system-array 2)))

	(* (exp (aref ans 1)) (expt x (aref ans 0)))))))
