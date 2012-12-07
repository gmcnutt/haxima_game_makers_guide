;; General custom scheme utilites.

;; 'nil' is a more readable way to represent the meaning implied by an empty
;; list.
(define nil '())

;; 'println' is a more useful form of the built-in scheme 'display' proc, that
;; takes a list of args and prints a newline after them.
(define (println . args)
  (map display args)
  (newline))

;; 'kern-load' loads a file but also tells the kernel to make a note of it so
;; that saved sessions will load the file, too.
(define (kern-load fname)
  (kern-include fname)
  (load fname))

