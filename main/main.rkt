#lang racket

;IMPORTS
(require "stack.rkt")
(require "usuario.rkt")
(require "pregunta.rkt") 

;Casos prueba
(define usuarios_iniciales (stackTDA (user "pepito" "miclave")(user "Javiera" "12345")))
(define stack_1 (register usuarios_iniciales "Tomás" "12345"))
(define stack_2 (register usuarios_iniciales "Francisca" "sadasdad12345"))

;Ask
(define lazy-logging
  (lazy (((login stack_2 "pepito" "miclave" ask)
         (date 30 10 2020)) "How you doing?" "e1" "e2" "e3")))

;Uso Ask
;(force lazy-logging)