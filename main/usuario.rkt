#lang racket

(require "pregunta.rkt")

(provide user)
(provide user?)
(provide getName)
(provide getUser)
(provide getPass)
(provide addUser)
(provide reward)

;CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear la lista usuario
;dom: string X string
;rec: usuario (username password reputation retention)
(define (user username password)
  (if (and (string? username)(string? password))
      (list username password 0 0)
      null))


;PERTENENCIA
;-------------------------------------------------------------------------
;descripción: Función que permite determinar si un elemento cualquiera es del tipo user
;se implementa a partir del constructor evaluando el retorno
;dom: elemento de cualquier tipo
;rec: boolean
(define (user? u)
  (and (list? u)
       (= (length u) 4)
       (not (null? (user (car u) (cadr u))))))


;SELECTORES
;-------------------------------------------------------------------------
;descripción: Función que permite obtener nombre de un usuario
;dom: user
;rec: string (username)

(define getName car)

;descripción: Función que permite obtener password de un usuario
;dom: user
;rec: string (password)

(define getPass cadr)

;descripción: Función que permite obtener reputación de un usuario
;dom: user
;rec: string (reputation)

(define getReputation caddr)

;descripción: Función que permite obtener reputación (temporal) de un usuario
;dom: user
;rec: string (temporalReputation)

(define getTemporalReputation cadddr)

;descripción: Función que permite obtener un usuario de una lista (stack)
;dom: string X stack
;rec: usuario

(define (getUser username stack)
  (if (null? stack)
      stack
      (if (and (eq? (getName (car stack)) username))
          (car stack)
          (getUser username (cdr stack)))))


;MODIFICADORES
;-------------------------------------------------------------------------

;descripción: Función que modifica y calcula las reputaciones real y temporal de un usuario
;dom: usuario X stack
;rec: usuario actualizado

(define (setReputation user stack rewardQuantity)
  (let ([users (car (cdr stack))])
     (display users)
    ))

;descripción: Función que permite calcular la nueva reputación del usuario apartir de una recompensa
;dom: string X integer X integer X stack
;rec: stack actualizado

(define (setReward username rewardQuantity questionId stack)
  (let ([users (car (cdr stack))])
  (define getUserLazy (lazy (getUser username users)))
  (if (< (getReputation(force getUserLazy)) rewardQuantity)
      (cdr stack)
      (setReputation (force getUserLazy) stack rewardQuantity))))

;descripción: Función que permite agregar un usuario a una lista (stack)
;dom: string X string X stack
;rec: stack (con nuevo usuario)

(define (addUser username password stack)
  (let ([user (user username password)])
  (if (user? user)
      (cons (cons user (car stack))(cdr stack))
      stack)))

;descripción: Función currificada que permite a un usuario logueado
;             crear una recompensa asociada a una pregunta.
;dom: stack
;recorrido: integer (ID pregunta) X integer (recompensa)
;rec: stack

(define reward (lambda (stack)
                 (lambda (questionId)
                   (lambda (rewardQuantity)
                     (if (string? (car stack))
                         (setReward (car stack) rewardQuantity questionId stack)
                         stack)))))
