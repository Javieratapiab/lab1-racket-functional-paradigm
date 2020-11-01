#lang racket

(require "usuario.rkt")

(provide stack)
(provide getUser)
(provide addUser)
(provide register)

;CONSTRUCTOR
;descripción: Función que permite crear un stack
;dom: list
;rec: list
(define stack list)

;SELECTORES
;descripción: Función que permite obtener un usuario dentro del stack
;dom: string X stack
;rec: stack
(define (getUser username stack)
  (if (null? stack)
      stack
      (if (eq? username (car (car stack)))
          (car stack)
          (getUser username (cdr stack)))))

; MODIFICADORES
;descripción: Función que permite agregar un usuario al stack
;dom: user X stack
;rec: pair
(define addUser cons)

;descripción: Función que permite registrar un usuario en el stack
;dom: stack X string X string
;rec: stack
(define (register stack username password)
  (if (null? (getUser username stack))
      (addUser (user username password) stack)
      stack))

;Caso prueba
(define stack_1 (register (stack (user "pepito" "miclave")(user "Javiera" 12345)) "Tomás" 12345))