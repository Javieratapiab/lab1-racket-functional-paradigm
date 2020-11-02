#lang racket

(require "stack.rkt")
(require "usuario.rkt")
(require "pregunta.rkt") 

;Casos prueba
(define stackOverflow (stackTDA (user "Bilz" "mi$uperklave")(user "Pap" "123454321")))
(define stackOverflow1 (register stackOverflow "Pepsi" "pa$$"))

; 1) Usuario logueado creando una pregunta
(define lazy-login-ask
  (lazy (((login stackOverflow1 "Pepsi" "pa$$" ask)
         (date 30 10 2020)) "How you doing?" "e1" "e2" "e3")))

(force lazy-login-ask)
