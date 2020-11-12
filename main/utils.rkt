#lang racket

(provide customDelete)
(provide customFlatten)

; FUNCIONES AUXILIARES
;-------------------------------------------------------------------------

;descripción: Implementación propia de remove. Permite eliminar elemento de una lista.
;dom: lista X cualquier elemento de la lista
;rec: lista actualizada
;tipo de recusión: de cola

(define (customDelete lst item)
  (cond ((null? lst)
         null)
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
  (cond ((null? lst) null)
        ((pair? lst)
         (append (customFlatten (car lst)) (customFlatten (cdr lst))))
        (else (list lst))))
