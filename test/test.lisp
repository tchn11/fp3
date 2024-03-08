(load "~/quicklisp/setup.lisp")
(load "src/main.lisp")
(ql:quickload :lisp-unit)

(lisp-unit:define-test line-test
		       (lisp-unit:assert-equal '(NIL (0 0) (1 1) (2 2) (3 3) (4 4)) 
			   							(main (open-file "test/test1.txt") (range 5 1 0) t)))

(lisp-unit:define-test line-broken
		       (lisp-unit:assert-equal '(NIL (0.0 0.0) (0.5 0.5) (1.0 1.0) (1.5 1.5) (2.0 2.0) (2.5 1.5) (3.0 1.0) (3.5 0.5) (4.0 0.0) (4.5 -0.5))
			   							(main (open-file "test/test2.txt") (range 10 0.5 0) t)))

(lisp-unit:define-test degree-line
		       (lisp-unit:assert-equal '(NIL (0.0 0.0) (0.5 0.5) (1.0 1.0) (1.5 1.5) (2.0 2.0) (2.5 2.5) (3.0 3.0) (3.5 3.5) (4.0 4.0) (4.5 4.5))
			   							(main (open-file "test/test3.txt") (range 10 0.5 0) nil)))

(lisp-unit:define-test degree-not-line
		       (lisp-unit:assert-equal '(NIL (0.0 0.0) (0.5 0.48031345) (1.0 0.83282435) (1.5 1.1491487) (2.0 1.4440496) (2.5 1.7239797) (3.0 1.9925302) (3.5 2.2519724) (4.0 2.5038643) (4.5 2.4594061))
			   							(main (open-file "test/test4.txt") (range 10 0.5 0) nil)))

(lisp-unit:run-tests)
