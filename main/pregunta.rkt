#lang racket

(require "usuario.rkt")

(provide questionTDA)
(provide question?)
(provide ask)
(provide date)

; CONSTRUCTOR
;descripción: Función que permite crear una pregunta (question).
;dom: list
;rec: list
(define questionTDA list)


; CONSTRUCTOR (FECHA)
;descripción: Función que permite crear una fecha (date).
;dom: integer X integer X integer
;rec: list
(define (date m d y)
  (if (and (integer? m)(integer? d)(integer? y))
      (list m d y)
      null))


;PERTENENCIA
;descripción: Función que permite determinar si un elemento cualquiera es del tipo question
;             se implementa a partir del constructor evaluando el retorno.
;dom: elemento de cualquier tipo
;rec: boolean

(define (question? q)
  (and (list? q)
       (= (length q) 4)
       (not (null? (questionTDA (car q)(cadr q)(caddr q)(cadddr q))))))


; PERTENENCIA (FECHA)
;descripción: Función que permite determinar si un elemento cualquiera es del tipo date
;             se implementa a partir del constructor evaluando el retorno.
;dom: elemento de cualquier tipo
;rec: boolean
(define (date? d)
  (and (list? d)
       (>= (length d) 3)
       (not (null? (date (car d) (cadr d)(caddr d))))))


; MODIFICADOR
;descripción: Función currificada que permite a un usuario con sesión
;             iniciada realizar una nueva pregunta.
;dom: stack X date X question X labels
;rec: stack
(define ask (lambda (stack)
              (lambda (date)
                (lambda (question . labels)
                  (append (cdr stack)(list (questionTDA (car stack) date question labels)))))))
