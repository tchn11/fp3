(load "src/utils.lisp")

(defun line (points x)
    (let
            ((point1 (aref points (- (/ (length points) 2) 1)))
            (point2 (aref points (/ (length points) 2))))
    (+ (get_y point1) (* (- x (get_x point1)) (/ (- (get_y point2) (get_y point1)) (- (get_x point2) (get_x point1)))))))


(defun degree (points x)
  (let ((n 0)
     (system-array (make-array '(2 3) :initial-element 1.0))
     (summ-x 0)
     (summ-x-sqd 0)
     (summ-y 0)
     (summ-x-y 0))
 
   (setq n (length points))

   ;; Суммируем логарифмы x и y
   (dotimes (i n)
    (incf summ-x (log (get_x (nth i points))))
    (incf summ-y (log (get_y (nth i points)))))

   ;; Суммируем квадраты логарифмов x
   (dotimes (i n)
    (incf summ-x-sqd (* (log (get_x (nth i points))) (log (get_x (nth i points))))))

   ;; Суммируем произведения логарифмов x и y
   (dotimes (i n)
    (incf summ-x-y (* (log (get_x (nth i points))) (log (get_y (nth i points))))))

   ;; Вычисляем систему уравнений
    (setf (aref system-array 0 0) summ-x-sqd)
    (setf (aref system-array 0 1) summ-x)
    (setf (aref system-array 0 2) summ-x-y)
    (setf (aref system-array 1 0) summ-x)
    (setf (aref system-array 1 1) n)
    (setf (aref system-array 1 2) summ-y)
    (let ((ans (calc-system system-array 2)))

    ;; Создаем функцию результата
    (* (exp (aref ans 1)) (expt x (aref ans 0))))))
