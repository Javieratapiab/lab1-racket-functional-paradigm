#lang racket

(provide answer)
(provide getAnswerById)
(provide getAnswerId)
(provide getAnswerUpVotes)
(provide getAnswerDownVotes)
(provide getAnswerStatus)
(provide getAnswerOffenseReports)
(provide getAnswerUser)
(provide getAnswerQuestionId)
(provide getAnswerPublicationDate)
(provide getAnswerContent)
(provide getAnswerLabels)
(provide setAnswerStatus)
(provide setAnswerId)

; CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear la lista respuesta.
;dom: elementos de una respuesta
;rec: lista answer
;     (integer (id) X integer (votos positivos) X integer (votos negativos) X string (estado de aceptación) X integer (reportes de ofensa)
;     X string (author) X integer (id de pregunta) X date (fecha de publicación respuesta) X string (contenido respuesta) X lista (etiquetas)

(define answerList list)

;SELECTORES
;-------------------------------------------------------------------------

;descripción: Función que permite obtener el id de una respuesta
;dom: respuesta
;rec: integer (id)

(define (getAnswerId answer) (car answer))

;descripción: Función que permite obtener votos positivos de una respuesta
;dom: respuesta
;rec: integer (votos positivos)

(define (getAnswerUpVotes answer) (cadr answer))

;descripción: Función que permite obtener votos negativos de una respuesta
;dom: respuesta
;rec: integer (votos negativos)

(define (getAnswerDownVotes answer) (caddr answer))

;descripción: Función que permite obtener estado de aceptación de una respuesta
;dom: respuesta
;rec: string (estado de aceptación)

(define (getAnswerStatus answer) (car (cdr (cdr (cdr answer)))))

;descripción: Función que permite obtener reportes de ofensa de una respuesta
;dom: respuesta
;rec: integer (reportes de ofensa)

(define (getAnswerOffenseReports answer) (car (cdr (cdr (cdr (cdr answer))))))

;descripción: Función que permite obtener el autor de una respuesta
;dom: respuesta
;rec: string (author)

(define (getAnswerUser answer) (car (cdr (cdr (cdr (cdr (cdr answer)))))))

;descripción: Función que permite obtener el id de pregunta asociado a una respuesta
;dom: respuesta
;rec: integer (id de pregunta en la respuesta)

(define (getAnswerQuestionId answer) (car (cdr (cdr (cdr (cdr (cdr (cdr answer))))))))

;descripción: Función que permite obtener la fecha de publicación de una respuesta
;dom: respuesta
;rec: date (fecha de publicación)

(define (getAnswerPublicationDate answer) (car (cdr (cdr (cdr (cdr (cdr (cdr (cdr answer)))))))))

;descripción: Función que permite obtener el contenido de una respuesta
;dom: respuesta
;rec: string (conteniddo)

(define (getAnswerContent answer) (car (cdr (cdr (cdr (cdr (cdr (cdr (cdr (cdr answer))))))))))

;descripción: Función que permite obtener el contenido de una respuesta
;dom: respuesta
;rec: string (conteniddo)

(define (getAnswerLabels answer) (cadr (cdr (cdr (cdr (cdr (cdr (cdr (cdr (cdr answer))))))))))

;descripción: Función que permite obtener una respuesta de una lista de respuestas filtrando por id
;dom: lista de respuesta X integer (id respuesta)
;rec: respuesta

(define (getAnswerById answers answerId)
  (filter (lambda (a) (= (car a) answerId)) answers))


; MODIFICADORES
;-------------------------------------------------------------------------

;descripción: Función que setea un ID incremental para nueva pregunta
;dom: lista de preguntas
;rec: integer (ID único de pregunta)
(define (setAnswerId answers)
  (if (null? answers)
      1
      (+ (getAnswerId (car answers)) 1)))

;descripción: Función que permite crear una nueva respuesta para agregarla al stack
;dom: string (author) X lista (answers en un stack) X date X integer (question ID) X string (contenido) X labels (etiquetas)
;rec: lista answers actualizada

(define (setAnswer author answers date questionId content labels)
  (let ([votes 0]
        [views 0]
        [status "no"]
        [offenseReports 0]
        [title ""]
        [lastActivity date])
    (if (null? answers)
        (list (answerList (setAnswerId answers) votes votes status offenseReports author questionId date content labels))
        (cons (answerList (setAnswerId answers) votes votes status offenseReports author questionId date content labels) answers))))

;descripción: Función que permita modificar estado de una respuesta
;dom: answer X string (nuevo status)
;rec: answer actualizada

(define (setAnswerStatus answer newStatus)
  (answerList (getAnswerId (car answer))
              (getAnswerUpVotes (car answer))
              (getAnswerDownVotes (car answer))
              newStatus
              (getAnswerOffenseReports (car answer))
              (getAnswerUser (car answer))
              (getAnswerQuestionId (car answer))
              (getAnswerPublicationDate (car answer))
              (getAnswerContent (car answer))
              (getAnswerLabels (car answer))))

;descripción: Función currificada que permite a un usuario con sesión
;             iniciada realizar una nueva respuesta a una pregunta específica.
;dom: stack
;recorrido: list -> stack X date X integer X string X string list
;rec: stack actualizado

(define answer (lambda (stack)
                 (lambda (date)
                   (lambda (questionId)
                     (lambda (answer . labels)
                       (if (string? (car stack)) ; validación de user logueado
                           (let ([author (car stack)]
                                 [users (car (cdr stack))]
                                 [questions (cadr (cdr stack))]
                                 [rewards (caddr (cdr stack))]
                                 [answers (cadddr (cdr stack))])
                             (if (null? (filter (lambda (q) (= (car q) questionId)) questions)) ; validación existencia pregunta
                                 (cdr stack)
                                 (list users questions rewards (setAnswer author answers date questionId answer labels))))
                           stack))))))