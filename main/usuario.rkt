#lang racket

(require "pregunta.rkt")
(require "reward.rkt")

(provide user)
(provide getName)
(provide getUser)
(provide getPass)
(provide addUser)
(provide reward)

;CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear la lista user
;dom: string X string
;rec: usuario (username password reputation temporalReputation)

(define (user username password)
  (if (and (string? username)(string? password))
      (list username password 100 0)
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
;tipo de recusión: cola
;rec: usuario

(define (getUser username stack)
  (if (null? stack)
      stack
      (if (and (eq? (getName (car stack)) username))
          (car stack)
          (getUser username (cdr stack)))))

;MODIFICADORES
;-------------------------------------------------------------------------

;descripción: Función que modifica un usuario definiendo una nueva reputación
;             en base a la cantidad de recompensa ofrecida, retorna la lista
;             de users actualizada.
;dom: usuario X usuarios X integer (cantidad recompensa)
;rec: lista de usuarios actualizada

(define (setReputation user users rewardQuantity)
  (append (filter (lambda (u) (not(eq? user u))) users)
          (list (list (getName user)
                      (getPass user)
                      (getReputation user)
                      (- (getTemporalReputation user) rewardQuantity)))))

;descripción: Función que asocia una recompensa a una pregunta y actualiza el stack
;             si el cálculo de reputación del usuario es superior a la cantidad de recompensa.
;dom: usuario X integer (cantidad de recompensa) X integer (ID de la pregunta) X stack
;rec: stack actualizado

(define (setRewards author rewardQuantity questionId stack)
  (let ([user (getUser author (car (cdr stack)))]
        [users (car (cdr stack))])
    (if (< (calculateReputation user) rewardQuantity)
        (cdr stack)
        (list (setReputation user users rewardQuantity)
              (getQuestions stack)
              (setReward (cdr stack)(car user) rewardQuantity questionId)
              (cadddr (cdr stack))))))

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
;rec: stack actualizado

(define reward (lambda (stack)
                 (lambda (questionId)
                   (lambda (rewardQuantity)
                     (if (string? (car stack))
                         (setRewards (car stack) rewardQuantity questionId stack)
                         stack)))))

;OTRAS IMPLEMENTACIONES
;-------------------------------------------------------------------------
;descripción: Función que calcula la reputación total (real y temporal) de un user
;dom: user
;rec: integer
(define (calculateReputation user)
  (+ (getReputation user)(getTemporalReputation user)))
