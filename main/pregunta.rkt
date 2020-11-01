#lang racket

(require "etiqueta.rkt")
(require "usuario.rkt")

(provide question)
(provide question?)
(provide date)
(provide date?)
(provide ask)

; CONSTRUCTOR
(define (question user publicationDate questionText tag)
  (if (and (user? user)
           (date? publicationDate)
           (string? questionText)
           (tag? tag))
      (list user publicationDate questionText tag)
      null))

(define (date m d y)
  (if (and (integer? m)(integer? d)(integer? y))
      (list m d y)
      null))

; PERTENENCIA
(define (question? q)
  (and (list? q)
       (= (length q) 4)
       (not (null? (question (car q) (cadr q)(caddr q)(cadddr q))))))

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
                  (display stack)
                  ))))
