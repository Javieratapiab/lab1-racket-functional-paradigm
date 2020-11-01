#lang racket

; IMPORTS
(require "usuario.rkt")

; EXPORTS
(provide stack)
(provide getUser)
(provide addUser)
(provide register)
;----------------

;CONSTRUCTOR
;descripción: Permite crear un stack
;dom: list
;rec: list
(define stack list)

;SELECTORES
;descripción: Permite obtener un usuario dentro del stack
;dom: string X stack
;rec: stack
(define (getUser username stack)
  (if (null? stack)
      stack
      (if (eq? username (car (car stack)))
          (car stack)
          (getUser username (cdr stack)))))

; MODIFICADORES
;descripción: Permite agregar un usuario al stack
;dom: user X stack
;rec: pair
(define addUser cons)

;descripción: Permite registrar un usuario en el stack
;dom: user X stack
;rec: pair
(define (register stack username password)
  (if (null? (getUser username stack))
      (addUser (user username password) stack)
      stack))



;Caso prueba
(define stack_1 (register (stack (user "pepito" "miclave")(user "Javiera" 12345)) "Tomás" 12345))