(in-package #:fincl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun t->string (x)
    (format nil "~a" x))
  (defvar *words* nil)
  )

(defclass forth-word ()
  ;; defines the basic structure of a forth word
  ((length :reader word-length :initarg :length)
   (name :reader word-name :initarg :name)
   (definition :reader word-def :initarg :word-def)))

(defmacro def-word (name def)
  ;; A macro that defines a forth word and pushes it
  ;; onto the word list
  (let ((word-class-name (gensym))
	(name-string (t->string name))
	(length (length (t->string name)))
	(def-string (mapcar #'t->string def)))
    `(let ((,word-class-name (make-instance 'forth-word
					    :length ,length
					    :name ,name-string
					    :word-def ',def-string)))
       (push ,word-class-name *words*)
       ,word-class-name)))

(defmacro see-word (word-name)
  (let ((name-string (gensym "name"))
	(x (gensym "x"))
	(y (gensym "y")))
    `(let ((,name-string (t->string ',word-name)))
       (loop for ,x in *words*
	  and ,y = (word-name ,x)
	    do (print ,y)))))

(defvar *stack*
  nil
  "The global data stack" )

(defvar *memory*
  nil)

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
