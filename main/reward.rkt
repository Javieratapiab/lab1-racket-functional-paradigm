#lang racket

(provide setReward)

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
(define getRewards cddr)


;MODIFICADORES
;-------------------------------------------------------------------------

;descripción: Función que permite crear una lista de rewards o actualizar la existente con un nuevo reward
;dom: stack X user X integer X integer
;rec: lista de rewards

(define (setReward stack user rewardQuantity questionId)
  (if (null? (getRewards stack))
      (list (rewardList user questionId rewardQuantity))
      (cons (rewardList user questionId rewardQuantity)(caddr stack))))
