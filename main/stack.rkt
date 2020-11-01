#lang racket

(require "usuario.rkt")
(require "pregunta.rkt")

(provide stack)
(provide getUser)
(provide addUser)
(provide register)
(provide login)
(provide ask)

;CONSTRUCTOR
;descripción: Función que permite crear un stack
;dom: list
;rec: list
(define stack list)

;SELECTORES
;descripción: Función que permite obtener un usuario del stack
;dom: string X stack
;rec: list
(define (getUser username stack)
  (if (null? stack)
      stack
      (if (eq? username (car (car stack)))
          (car stack)
          (getUser username (cdr stack)))))

;MODIFICADORES
;descripción: Función que permite agregar un usuario al stack
;dom: user X stack
;rec: pair
(define (addUser username password stack)
  (if (user? (user username password))
    (cons (user username password) stack)
    stack)
)

;descripción: Función que permite registrar un usuario en el stack
;dom: stack X string X string
;rec: stack
(define (register stack username password)
  (if (null? (getUser username stack))
      (addUser username password stack)
      stack))

;descripción: Función que permite loguear un usuario en el stack
;dom: stack X string X string X function
;rec: stack
(define (login stack username password operation)
  (if (null? (getUser username stack))
      operation
      (((force lazy-operation) operation) stack)
  ))

; OTRAS IMPLEMENTACIONES
;descripción: Función perezosa que permite gatillar una operación (función) a través de currificación
;dom: function
;rec: stack
(define lazy-operation (lazy (lambda (operation) (lambda (stack) (operation stack)))))

;Caso prueba
(define usuarios_iniciales (stack (user "pepito" "miclave")(user "Javiera" "12345")))
(define stack_1 (register usuarios_iniciales "Tomás" "12345"))
(define stack_2 (register usuarios_iniciales "Francisca" "sadasdad12345"))
(login stack_1 "Tomás" "12345" ask)
(login stack_2 "Francisca" "12345" ask)