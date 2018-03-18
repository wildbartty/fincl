;;;; package.lisp

(defpackage #:fincl-base
  (:use #:cl)
  (:export #:*stack*
	   #:call
   ))

(defpackage #:fincl-builtins
  (:use #:cl
	#:fincl-base
	)
  (:export #:fincl-+
	   #:fincl-dup
	   #:*builtins*)
  )


(defpackage #:fincl
  (:use #:cl
	#:fincl-builtins
	#:fincl-base
	#:alexandria)
  (:export #:def-word))
