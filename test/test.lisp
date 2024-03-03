(load "~/quicklisp/setup.lisp")
(load "src/main.lisp")
(ql:quickload :lisp-unit)

(defun generate_line (n)
	(list (list 1 n) (list 2 n) (list 3 n) (list 4 n)))

(defun generate_answer (n)
	(list nil (list 0 n) (list 1 n) (list 2 n) (list 3 n) (list 4 n) (list 5 n)))

(lisp-unit:define-test line_test
		       (lisp-unit:assert-equal '(NIL (0 0) (1 1) (2 2) (3 3) (4 4)) 
			   							(main '((1 1) (2 2)) (range 5 1 0) t)))

(lisp-unit:define-test line_broken
		       (lisp-unit:assert-equal '(NIL (0.0 0.0) (0.5 0.5) (1.0 1.0) (1.5 1.5) (2.0 2.0) (2.5 1.5) (3.0 1.0) (3.5 0.5) (4.0 0.0) (4.5 -0.5))
			   							(main '((1 1) (2 2) (3 1)) (range 10 0.5 0) t)))

(lisp-unit:define-test degree_line
		       (lisp-unit:assert-equal '(NIL (0.0 0.0) (0.5 0.5) (1.0 1.0) (1.5 1.5) (2.0 2.0) (2.5 2.5) (3.0 3.0) (3.5 3.5) (4.0 4.0) (4.5 4.5))
			   							(main '((1 1) (2 2) (3 3)) (range 10 0.5 0) nil)))

(lisp-unit:define-test degree_not_line
		       (lisp-unit:assert-equal '(NIL (0.0 0.0) (0.5 1.0964527) (1.0 1.1814332) (1.5 1.234165) (2.0 1.273) (2.5 1.3039625) (3.0 1.3298188) (3.5 1.3520796) (4.0 1.3716638) (4.5 1.3891736))
			   							(main '((1 1) (2 2) (3 1)) (range 10 0.5 0) nil)))

; Property - based

(lisp-unit:define-test parralel_line
				(let ((rand (random 10)))
		       (lisp-unit:assert-equal (generate_answer rand)
			   							(main (generate_line rand) (range 6 1 0) t))))

(lisp-unit:run-tests)
