#lang racket

(provide customLast)

; FUNCIONES AUXILIARES
;descripción: Función que retorna el último elemento de una lista
;dom: lista
;rec: último elemento de la lista
(define (customLast l)
  (cond ((null? (cdr l)) (car l))
        (else (customLast (cdr l)))))
