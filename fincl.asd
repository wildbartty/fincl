;;;; fincl.asd

(asdf:defsystem #:fincl
  :description "Describe fincl here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:alexandria)
  :components ((:file "package")
	       (:file "words")
               (:file "fincl")))

