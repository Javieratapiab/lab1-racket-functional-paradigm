#lang racket

(provide customLast)
(provide date)
(provide date?)

; FUNCIONES AUXILIARES
;descripción: Función que retorna el último elemento de una lista
;dom: lista
;rec: último elemento de la lista

(define (customLast l)
  (if (= (length l) 1)
      (car l)
      (customLast (cdr l))))

;descripción: Función que permite crear una fecha (date).
;dom: integer X integer X integer
;rec: list

(define (date m d y)
  (if (and (integer? m)(integer? d)(integer? y))
      (list m d y)
      null))

;descripción: Función que permite determinar si un elemento cualquiera es del tipo date
;             se implementa a partir del constructor evaluando el retorno.
;dom: elemento de cualquier tipo
;rec: boolean

(define (date? d)
  (and (list? d)
       (>= (length d) 3)
       (not (null? (date (car d) (cadr d)(caddr d))))))