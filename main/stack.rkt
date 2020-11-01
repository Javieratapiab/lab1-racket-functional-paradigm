#lang racket

(require "usuario.rkt")
(require "pregunta.rkt")

(provide stackTDA)
(provide getUser)
(provide addUser)
(provide register)
(provide login)
(provide ask)

;CONSTRUCTOR

;descripción: Función que permite crear un stack
;dom: list
;rec: list
(define stackTDA list)

;SELECTORES

;descripción: Función que permite obtener un usuario del stack
;dom: string X stack
;rec: list
(define (getUser username password stack)
  (if (null? stack)
      stack
      (if (and (eq? (getName (car stack)) username)(eq? (getPass (car stack)) password))
          (car stack)
          (getUser username password (cdr stack)))))

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
  (if (null? (getUser username password stack))
      (addUser username password stack)
      stack))

;descripción: Función que permite loguear un usuario en el stack
;dom: stack X string X string X function
;rec: stack
(define (login stack username password operation)
  (if (null? (getUser username password stack))
      operation
      (((force lazy-operation) operation)(stackTDA (user "pepito" "miclave")))
      ))

;OTRAS IMPLEMENTACIONES

;descripción: Función perezosa que permite gatillar una operación (función) usando currificación
;dom: function
;rec: stack
(define lazy-operation (lazy (lambda (operation) (lambda (stack) (operation stack)))))

;Caso prueba
(define usuarios_iniciales (stackTDA (user "pepito" "miclave")(user "Javiera" "12345")))
(define stack_1 (register usuarios_iniciales "Tomás" "12345"))
(define stack_2 (register usuarios_iniciales "Francisca" "sadasdad12345"))
(login stack_1 "Tomasdaás" "12345" ask)

;ASK
(((login stack_2 "pepito" "miclave" ask)(date 30 10 2020)) "How you doing" "e1" "e2" "e3")