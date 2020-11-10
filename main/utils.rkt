#lang racket

(provide customDelete)
(provide customFlatten)
(provide date)
(provide date?)

; FUNCIONES AUXILIARES

;descripción: Implementación propia de remove. Permite eliminar elemento de una lista.
;dom: lista X cualquier elemento de la lista
;rec: lista actualizada
;tipo de recusión: de cola

(define (customDelete lst item)
  (cond ((null? lst)
         '())
        ((equal? item (car lst))
         (cdr lst))
        (else
         (cons (car lst) 
               (customDelete (cdr lst) item)))))


;descripción: Implementación propia de flatten. Condensa anidación de lista en una única lista
;dom: cualquier lista
;rec: lista actualizada
;tipo de recusión: natural

(define (customFlatten lst)
  (cond ((null? lst) '())
        ((pair? lst)
         (append (customFlatten (car lst)) (customFlatten (cdr lst))))
        (else (list lst))))

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
