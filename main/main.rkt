#lang racket

(require "stack.rkt")
(require "usuario.rkt")
(require "pregunta.rkt") 

;Casos prueba
(define stackOverflow (stackTDA (list (user "Bill Gates" "mi$uperklave")
                                      (user "Dan abramov" "123454321"))))
(define stackOverflow1 (register stackOverflow "Jeff Bezos" "pa$$"))

; 1) Usuario logueado creando una pregunta
(define validAsk
  (lazy (((login stackOverflow1 "Bill Gates" "mi$uperklave" ask)
          (date 30 10 2020)) "What is hoisting?" "javascript" "computer science" "functional paradigm")))

; 2) Usuario no logueado creando pregunta (retorna el mismo stack)
(define invalidAsk (lazy (((ask stackOverflow1)
                           (date 20 10 20)) "How can i hack an email?" "hacking")))

; 3) Usuario logueado creando pregunta con una lista de preguntas presente
(define validNestedAsk (lazy (((login (force validAsk) "Jeff Bezos" "pa$$" ask)
                               (date 30 09 2020)) "What is scope?" "javascript")))

(display "---- Pregunta válida ---- \n")
(force validAsk)
(display "---- Pregunta inválida ---- \n")
(force invalidAsk)
(display "---- Preguntas anidadas ---- \n")
(force validNestedAsk)
