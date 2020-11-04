#lang racket

(require "usuario.rkt")

(provide stackList)
(provide register)
(provide login)

;CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear un stack (contenedor de listas)
;dom: lista
;rec: lista de listas (usuarios registrados X preguntas)

(define stackList list)


;SELECTORES
;-------------------------------------------------------------------------
;descripción: Función que permite obtener los usuarios dentro de una lista (stack)
;dom: stack
;rec: usuarios

(define getUsers car)


; MODIFICADORES
;-------------------------------------------------------------------------
;descripción: Función que permite registrar un usuario en el stack
;dom: stack X string X string
;rec: stack (con usuario registrado)

(define (register stack username password)
  (if (null? (getUser username (getUsers stack)))
      (addUser username password stack)
      stack))

;descripción: Función que permite loguear un usuario del stack con username y password
;             y retornar una función currificada de la operación recibida.
;dom: stack X string X string X función
;rec: función currificada que retorna stack actualizado

(define (login stack username password operation)
  (let ([user (getUser username (getUsers stack))])
  (if (and (null? user)(eq? (getPass user) password))
      operation
      (((force lazy-operation) operation)
       (cons username stack)))))


;OTRAS IMPLEMENTACIONES
;-------------------------------------------------------------------------
;descripción: Función perezosa auxiliar que permite
;             gatillar una operación (función) currificada
;dom: función X stack
;rec: stack actualizado

(define lazy-operation
  (lazy (lambda (operation)
          (lambda (stack)
            (operation stack)))))