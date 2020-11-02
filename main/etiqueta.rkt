#lang racket

(provide tag)
(provide tag?)

;CONSTRUCTOR
;descripción: Función que permite crear una etiqueta
;dom: string
;rec: list
(define (tag description)
  (if (string? description)
    (list description)
    null))

(define emptyTag null)

;PERTENENCIA
;descripción: Función que permite determinar si un elemento cualquiera es del tipo tag
;se implementa a partir del constructor evaluando el retorno
;dom: elemento de cualquier tipo
;rec: boolean
(define (tag? t)
  (and (list? t)
       (= (length t) 1)
       (not (null? (tag (car t))))))