(in-package #:fincl-base)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun t->string (x)
    (format nil "~a" x))
  (defparameter *words* nil)
  (defun join-str (with &rest rest)
    (reduce #'(lambda (x y) (concatenate 'string x with y)) rest)))


(defmacro make-forth-word (name &rest word-def)
  `(list ,name ',@word-def))

(defmacro def-word (name &rest def)
  ;; A macro that defines a forth word and pushes it
  ;; onto the word list
  (let ((word-class-name (gensym))
	(name-string (t->string name))
	;(length (length (t->string name)))
	(def-string def))
    `(let ((,word-class-name (make-forth-word ,name-string
					      ,@def-string)))
       (push ,word-class-name *words*)
       ,word-class-name)))

(defmacro see-word (word-name)
  (let ((name-string (gensym "name"))
	(x (gensym "x")))
    `(let ((,name-string (t->string ',word-name)))
       (loop :for ,x :in *words*
	  :until (string= ,name-string (car ,x))
	  :finally (return
		     (join-str " " (concatenate 'string ',word-name ":")
			       (apply #'join-str " "
				      (mapcar #'t->string
					      (car (cdr ,x))))))))))

(defun find-word (name)
  (loop
     :for x :in *words*
     :when (equal name (car x))
     :do (return (cadr x))))

(def-word "foo" (1 2 3 + + \.))
;;;¤¿¡±¢–

(defvar *stack*
  nil
  "The global data stack")

(defun callablep (item)
  (symbolp item))

(defgeneric call (thing &rest rest))

(defmethod call ((symbol number) &rest rest)
  (push symbol *stack*)
  (call rest))

(defmethod call (thing &rest rest)
  'ok)

#|
(defmacro def-stack-op (name lambda-list &body body)
  (let ((opt-vars 
	 (cond
	   ((member '&optional lambda-list)
	    (concatenate 'list lambda-list '((stack *stack*))))
	   (t (print 'hello)))))
    (print opt-vars)
    `(defun ,name ,opt-vars (print ',opt-vars) ,@body)))

(def-stack-op test (&optional  (foo 3))
  (+ foo stack))

(def-stack-op test2 (&optional foo)
  (cons foo stack))

|#
#|
(defmacro arity (function)
  (let ((stream-name (gensym)))
    `(describe #',function)))

(defun depth (&optional (stack *stack*))
  (length stack))

(defun dup (&optional (stack *stack*))
  (let ((var (car stack)))
    (push var stack)
    nil))

(defun swap (&optional (stack *stack*))
  (let ((thing1 (pop stack))
	(thing2 (pop stack)))
    (push thing1 stack)
    (push thing2 stack)))

(defun push-stack (x)
  (push x *stack* ))

(defun over (&optional (stack *stack*))
  (push (nth 1 stack) stack))

(defun clear (&optional (stack *stack*))
  (setf stack nil))
|#

;; (let ((pack (find-package :fincl-base)))
;;   (do-all-symbols (sym pack) (when (eql (symbol-package sym) pack)
;; 			       (export sym))))
