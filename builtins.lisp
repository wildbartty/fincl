(in-package :fincl-builtins)

(defparameter *builtins* (make-hash-table :test 'equal))

(defun defbuiltin (name function)
  (setf (gethash name *builtins*) function))

(defun fincl-+ ()
  (let ((t1 (pop fincl-base:*stack*))
	(t2 (pop fincl-base:*stack*)))
    (push (+ t1 t2) fincl-base:*stack*)))

(defbuiltin "+" #'fincl-builtins:fincl-+)

(defun fincl-dup ()
  (push (car *stack*) *stack*))

(defbuiltin "dup" #'fincl-dup)

(defun fincl-drop ()
  (pop *stack*)
  *stack*)

(defbuiltin "drop" #'fincl-drop)

(defun fincl-swap ())

;;;(def-word "+" (21 12))

