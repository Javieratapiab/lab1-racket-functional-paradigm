#lang racket

(require "usuario.rkt")
(require "pregunta.rkt")

(provide stackTDA)
(provide register)
(provide login)

;CONSTRUCTOR
;descripción: Función que permite crear un stack (contenedor de listas)
;dom: lista
;rec: lista de listas (usuarios registrados X preguntas X rewards X respuestas)
(define stackTDA list)

;SELECTORES
(define getUsers car)

;descripción: Función que permite obtener un usuario del stack
;dom: string X string X stack
;rec: usuario
(define (getUser username password stack)
  (if (null? stack)
      stack
      (if (and (eq? (getName (car stack)) username)
               (eq? (getPass (car stack)) password))
          (car stack)
          (getUser username password (cdr stack)))))

;MODIFICADORES
;descripción: Función que permite agregar un usuario al stack
;dom: string X string X stack
;rec: stack (con nuevo usuario)
(define (addUser username password stack)
  (if (user? (user username password))
      (cons (cons (user username password)(car stack))(cdr stack))
      stack))

;descripción: Función que permite registrar un usuario en el stack
;dom: stack X string X string
;rec: stack (con usuario registrado)
(define (register stack username password)
  (if (null? (getUser username password (getUsers stack)))
      (addUser username password stack)
      stack))

;descripción: Función que permite loguear un usuario del stack
;             y retornar una función currificada de la operación recibida.
;dom: stack X string X string X función
;rec: función currificada que retorna stack actualizado
(define (login stack username password operation)
  (display "***** STACK LOGIN ***** \n")
  (display (cons username stack))
  (display "*********************** \n")
  (if (null? (getUser username password (getUsers stack)))
      operation
      (((force lazy-operation) operation)
       (cons username stack))))

;OTRAS IMPLEMENTACIONES
;descripción: Función perezosa auxuliar que permite
;             gatillar una operación (función) currificada
;dom: función X stack
;rec: stack actualizado
(define lazy-operation
  (lazy (lambda (operation)
          (lambda (stack)
            (operation stack)))))