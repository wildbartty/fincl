(in-package #:fincl)

(defvar *words* (make-hash-table))
(defvar *stack* nil)

(defun dup ()
  (let ((var (car *stack*)))
    (push var *stack*)
    nil))

(defun swap ()
  (let ((thing1 (pop *stack*))
	(thing2 (pop *stack*)))
    (push thing1 *stack*)
    (push thing2 *stack*)))

(defun )
