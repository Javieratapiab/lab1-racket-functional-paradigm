#lang racket


(provide answer)

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

(define getAnswerId car)


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