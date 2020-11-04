#lang racket

(require "utils.rkt")
(require "respuesta.rkt")

(provide questionTDA)
(provide question?)
(provide getQuestionId)
(provide getQuestions)
(provide ask)

; CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear una pregunta.
;dom: lista (características de pregunta)
;rec: lista

(define questionTDA list)

;SELECTORES
;-------------------------------------------------------------------------

;descripción: Función que permite obtener el id de una pregunta
;dom: question
;rec: integer (id)

(define getQuestionId car)

;descripción: Función que permite obtener la lista de preguntas dentro de una lista (stack)
;dom: stack
;rec: lista (questions)

(define (getQuestions stack)(cadr (cdr stack)))

;PERTENENCIA
;-------------------------------------------------------------------------
;descripción: Función que permite determinar si un elemento cualquiera es del tipo question
;             se implementa a partir del constructor evaluando el retorno.
;dom: elemento de cualquier tipo
;rec: boolean

(define (question? q)
  (and (list? q)
       (= (length q) 4)
       (not (null? (questionTDA (car q)(cadr q)(caddr q)(cadddr q))))))

; MODIFICADORES
;-------------------------------------------------------------------------
;descripción: Función que permite crear una lista de preguntas o crear
;             una lista nueva de preguntas existentes y una nueva pregunta.
;dom: lista de preguntas
;rec: integer (ID único de pregunta)

(define (setQuestionId questions)
  (if (null? questions)
      1
      (+ (getQuestionId (car questions)) 1)))

;descripción: Función que permite crear una lista de preguntas o crear
;             una lista nueva de preguntas existentes y una nueva pregunta.
;dom: date X string X list X stack
;recorrido: list -> stack X date X string X string list
;rec: lista de p

(define (setQuestions stack date question labels)
  (if (= (length (cdr stack)) 1)
      (list (questionTDA 1 (car stack) date question labels))
      (cons (questionTDA (setQuestionId (getQuestions stack))(car stack) date question labels)
            (getQuestions stack))))

;descripción: Función currificada que permite a un usuario con sesión
;             iniciada realizar una nueva pregunta.
;dom: stack
;recorrido: list -> stack X date X string X string list
;rec: stack

(define ask (lambda (stack)
              (lambda (date)
                (lambda (question . labels)
                  (if (string? (car stack))
                      (list (car (cdr stack))(setQuestions stack date question labels))
                      stack)))))