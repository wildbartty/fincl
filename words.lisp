(in-package #:fincl)

(defvar *words*
  (make-hash-table)
  "Where all the word definitions are")

(defvar *stack*
  nil
  "The global data stack" )

(defvar  *memory*
  (make-hash-table))

(defun dup (&optional (stack *stack*))
  (let ((var (car stack)))
    (push var stack)
    nil))

(defun swap (&optional (stack *stack*))
  (let ((thing1 (pop stack))
	(thing2 (pop stack)))
    (push thing1 stack)
    (push thing2 stack)))

(defun push-stack (x &optional (stack *stack*))
  (push x stack ))

(defun over (&optional (stack *stack*))
  (push (nth 1 stack) stack))

(defun clear (&optional (stack *stack*))
  (setf *stack* nil))
