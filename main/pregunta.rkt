#lang racket

(provide questionList)
(provide getQuestionId)
(provide getQuestions)
(provide ask)

; CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear una pregunta.
;dom: elementos de una pregunta
;rec: lista question
;     (integer (id) X string (estado) X integer (votos positivos) X integer (votos negativos) X integer (visualizaciones) X string (título)
;     X date (fecha última modificación) X string (autor) X date (fecha publicación) X string (contenido) X lista (etiquetas))

(define questionList list)

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


; MODIFICADORES
;-------------------------------------------------------------------------
;descripción: Función que setea un ID incremental para nueva pregunta
;dom: lista de preguntas
;rec: integer (ID único de pregunta)
(define (setQuestionId questions)
  (if (null? questions)
      1
      (+ (getQuestionId (car questions)) 1)))

;descripción: Función que permite crear una lista de preguntas
;             o actualiza lista existente de preguntas con nueva pregunta.
;dom: date X string X list X stack
;rec: questions (lista)

(define (setQuestions stack date content labels)
  (let ([author (car stack)]
        [votes 0]
        [views 0]
        [title ""]
        [lastActivity date]
        [status "abierta"])
    (if (null? (cadr (cdr stack)))
        (list (questionList (setQuestionId (getQuestions stack)) status votes votes views title lastActivity author date content labels))
        (cons (questionList (setQuestionId (getQuestions stack)) status votes votes views title lastActivity author date content labels)
              (getQuestions stack)))))

;descripción: Función currificada que permite a un usuario con sesión
;             iniciada realizar una nueva pregunta.
;dom: stack
;recorrido: list -> stack X date X string X string list
;rec: stack actualizado

(define ask (lambda (stack)
              (lambda (date)
                (lambda (question . labels)
                  (if (string? (car stack)) ; validación de user logueado
                      (let ([users (car (cdr stack))]
                            [rewards (caddr (cdr stack))]
                            [answers (cadddr (cdr stack))])
                        (list users (setQuestions stack date question labels) rewards answers))
                      stack)))))