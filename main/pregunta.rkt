#lang racket

(require "usuario.rkt")

(provide questionTDA)
(provide question?)
(provide ask)
(provide date)

; CONSTRUCTOR
;(define questionTDA list)
(define questionTDA list)

; CONSTRUCTOR FECHA
(define (date m d y)
  (if (and (integer? m)(integer? d)(integer? y))
      (list m d y)
      null))

; PERTENENCIA
(define (question? q)
  (and (list? q)
       (= (length q) 4)
       (not (null? (questionTDA (car q)(cadr q)(caddr q)(cadddr q))))))

; PERTENENCIA FECHA
(define (date? d)
  (and (list? d)
       (>= (length d) 3)
       (not (null? (date (car d) (cadr d)(caddr d))))))

; MODIFICADOR
;descripción: Función currificada que permite a un usuario con sesión iniciada en la
;             plataforma realizar una nueva pregunta.
;dom: stack
;rec: stack
(define ask (lambda (stack)
              (lambda (date)
                (lambda (question . labels)
                  (questionTDA (car stack) date question labels)
                  ))))
