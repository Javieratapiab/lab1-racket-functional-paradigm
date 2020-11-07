#lang racket

(provide rewardList)

;CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear una lista de rewards (recompensas)
;dom: string X integer X integer
;rec: lista de rewards (string (username) X integer (id pregunta) X integer (cantidad de recompensa))
(define (rewardList user questionId rewardQuantity)
  (if (and (string? user)(integer? questionId)(integer? rewardQuantity))
      (list user questionId rewardQuantity)
      null))

