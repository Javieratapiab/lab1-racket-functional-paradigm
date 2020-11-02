#lang racket

(require "usuario.rkt")
(require "pregunta.rkt")

(provide stackTDA)
(provide register)
(provide login)

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
      (if (and (eq? (getName (car stack)) username)
               (eq? (getPass (car stack)) password))
          (car stack)
          (getUser username password (cdr stack)))))

;descripción: Función que permite obtener el usuario logueado del stack
;dom: stack
;rec: user
(define (getLoggedUser stack)
  (cond ((null? (cdr stack)) (car stack))
        (else (getLoggedUser (cdr stack)))))

;descripción: Función que permite obtener el usuario logueado del stack
;dom: stack
;rec: user
(define (removeLoggedUser stack)
  (cond ((null? (cdr stack)) (car stack))
        (else (removeLoggedUser (cdr stack)))))

;MODIFICADORES
;descripción: Función que permite agregar un usuario al stack
;dom: user X stack
;rec: pair
(define (addUser username password stack)
  (if (user? (user username password))
      (cons (user username password) stack)
      stack
      )
  )

;descripción: Función que permite agregar una pregunta al stack
;dom: question X stack
;rec: pair
(define (addQuestion q stack)
  (if (question? q)
      (cons q stack)
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
      (((force lazy-operation) operation)
       (stackTDA (user username password))))
 )

;OTRAS IMPLEMENTACIONES
;descripción: Función perezosa auxuliar que permite
;             gatillar una operación (función) currificada
;dom: function
;rec: stack
(define lazy-operation
  (lazy (lambda (operation)
          (lambda (stack)
            (operation stack)))))