#lang racket

(require "utils.rkt")

(provide getRewardUser)
(provide getRewardsByQuestionId)
(provide setReward)
(provide findRewardByUser)
(provide removeRewards)
(provide getRewardUser)
(provide getRewardQuestionId)
(provide getRewardQuantity)

;CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear una lista de rewards
;dom: string X integer X integer
;rec: lista de rewards (string (username) X integer (id pregunta) X integer (cantidad de recompensa))

(define (rewardList user questionId rewardQuantity)
  (if (and (string? user)(integer? questionId)(integer? rewardQuantity))
      (list user questionId rewardQuantity)
      null))

;SELECTORES
;-------------------------------------------------------------------------
;descripción: Función que obtiene lista de rewards en un stack
;dom: string X integer X integer
;rec: lista de rewards

(define (getRewards stack) (cddr stack))

;descripción: Función que obtiene autor de la recompensa
;dom: reward
;rec: string (autor)

(define (getRewardUser reward) (car reward))

;descripción: Función que obtiene el id de pregunta de la recompensa
;dom: reward
;rec: integer (questionId)

(define (getRewardQuestionId reward) (cadr reward))

;descripción: Función que obtiene la cantidad de recompensa ofrecida
;dom: reward
;rec: integer (rewardQuantity)

(define (getRewardQuantity reward) (caddr reward))

;descripción: Función que obtiene un reward del stack
;             filtrando por autor, id de pregunta y id de respuesta.
;dom: string X integer X integer
;rec: lista de rewards

(define (getRewardsByQuestionId rewards questionId)
 (filter (lambda (r) (= questionId (getRewardQuestionId r))) rewards))

;descripción: Función que retorna si un username se encuentra en lista rewards
;dom: rewards X string (username)
;rec: reward

(define (findRewardByUser rewards username)
  (filter (lambda (r) (eq? username (getRewardUser r))) rewards))


;MODIFICADORES
;-------------------------------------------------------------------------
;descripción: Función que permite crear una lista de rewards o actualizar la existente con un nuevo reward
;dom: stack X user X integer X integer
;rec: lista de rewards

(define (setReward stack user rewardQuantity questionId)
  (if (null? (getRewards stack))
      (list (rewardList user questionId rewardQuantity))
      (cons (rewardList user questionId rewardQuantity)(caddr stack))))


;descripción: Función que permite eliminar rewards de una lista de rewards
;dom: lista de rewards (conjunto) X lista de rewards (stack)
;rec: lista de rewards

(define (removeRewards rewards allRewards)
  (customDelete allRewards (customFlatten rewards)))

  