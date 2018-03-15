;;;; package.lisp

(defpackage #:fincl
  (:use #:cl
	#:alexandria)
  (:export #:def-word))

(defpackage #:fincl-builtins
  (:use #:cl
	#:fincl))
