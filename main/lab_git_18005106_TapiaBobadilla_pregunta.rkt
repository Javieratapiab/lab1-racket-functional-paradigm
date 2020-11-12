#lang racket

(require "lab_git_18005106_TapiaBobadilla_fecha.rkt")

(provide ask)
(provide questionList)
(provide getQuestions)
(provide getQuestionUser)
(provide getQuestionById)
(provide setQuestionStatus)
(provide getQuestionId)
(provide getQuestionStatus)
(provide getQuestionUpVotes)
(provide getQuestionDownVotes)
(provide getQuestionViews)
(provide getQuestionTitle)
(provide getQuestionLastActivity)
(provide getQuestionUser)
(provide getQuestionPublicationDate)
(provide getQuestionContent)
(provide getQuestionLabels)

; Implementación del TDA Pregunta

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

(define (getQuestionId question) (car question))

;descripción: Función que permite obtener estado de una pregunta
;dom: question
;rec: string (estado)
(define (getQuestionStatus question) (cadr question))

;descripción: Función que permite obtener votos positivos de una pregunta
;dom: question
;rec: integer (votos positivos)

(define (getQuestionUpVotes question) (caddr question))

;descripción: Función que permite obtener votos negativos de una pregunta
;dom: question
;rec: integer (votos negativos)

(define (getQuestionDownVotes question) (cadddr question))

;descripción: Función que permite obtener visualizaciones de una pregunta
;dom: question
;rec: integer (visualizaciones)

(define (getQuestionViews question) (car (cdr (cdr (cdr (cdr question))))))

;descripción: Función que permite obtener el título de una pregunta
;dom: question
;rec: string (título)

(define (getQuestionTitle question) (car (cdr (cdr (cdr (cdr (cdr question)))))))

;descripción: Función que permite obtener la fecha de la última modificación
;dom: question
;rec: date

(define (getQuestionLastActivity question) (car (cdr (cdr (cdr (cdr (cdr (cdr question))))))))

;descripción: Función que permite obtener el autor de una pregunta
;dom: question
;rec: string (author)
(define (getQuestionUser question) (car (cdr (cdr (cdr (cdr (cdr (cdr (cdr question)))))))))

;descripción: Función que permite obtener la fecha de publicación de una pregunta
;dom: question
;rec: date
(define (getQuestionPublicationDate question) (car (cdr (cdr (cdr (cdr (cdr (cdr (cdr (cdr question))))))))))

;descripción: Función que permite obtener el contenido de una pregunta
;dom: question
;rec: string (content)
(define (getQuestionContent question) (car (cdr (cdr (cdr (cdr (cdr (cdr (cdr (cdr (cdr question)))))))))))

;descripción: Función que permite obtener el contenido de una pregunta
;dom: question
;rec: string (content)
(define (getQuestionLabels question) (cadr (cdr (cdr (cdr (cdr (cdr (cdr (cdr (cdr (cdr question)))))))))))

;descripción: Función que permite obtener la lista de preguntas dentro de una lista (stack)
;dom: stack
;rec: lista (questions)

(define (getQuestions stack)(cadr (cdr stack)))

;descripción: Función que permite obtener una pregunta de una lista de preguntas por su id
;dom: lista (questions) X (integer) questionId
;rec: lista (questions)

(define (getQuestionById questions questionId)
   (filter (lambda (q) (eq? questionId (getQuestionId q))) questions))


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


;descripción: Función que permita modificar estado de una pregunta
;dom: question X string (nuevo status)
;rec: question actualizada

(define (setQuestionStatus question newStatus)
  (questionList (getQuestionId (car question))
                newStatus
                (getQuestionUpVotes (car question))
                (getQuestionDownVotes (car question))
                (getQuestionViews (car question))
                (getQuestionTitle (car question))
                (getQuestionLastActivity (car question))
                (getQuestionUser (car question))
                (getQuestionPublicationDate (car question))
                (getQuestionContent (car question))
                (getQuestionLabels (car question))))

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