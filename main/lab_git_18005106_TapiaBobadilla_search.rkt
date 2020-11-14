#lang racket

(provide search)
(provide labels)
(provide all)

(require "lab_git_18005106_TapiaBobadilla_pregunta.rkt")
(require "lab_git_18005106_TapiaBobadilla_respuesta.rkt")

;descripción: Función que permite obtener preguntas y respuestas filtrando por substring en su contenido y etiquetas
;dom: lista (preguntas) X lista (respuestas) X string (texto a buscar)
;rec: lista de preguntas y respuestas filtradas

(define (all questions answers text)
  (append (filter (lambda (q) (or (regexp-match text (getQuestionContent q))
                                  (regexp-match text (string-join (getQuestionLabels q) "")))) questions)
          (filter (lambda (a) (or (regexp-match text (getAnswerContent a))
                                  (regexp-match text (string-join (getAnswerLabels a) "")))) answers)))

;descripción: Función que permite obtener preguntas y respuestas filtrando por etiqueta
;dom: lista (preguntas) X lista (respuestas) X string (texto a buscar)
;rec: lista de preguntas y respuestas filtradas

(define (labels questions answers text)
  (append (filter (lambda (q) (regexp-match text (string-join (getQuestionLabels q) ""))) questions)
          (filter (lambda (a) (regexp-match text (string-join (getAnswerLabels a) ""))) answers)))


;descripción: Función currificada que permite buscar en preguntas, respuestas y etiquetas
;             una coincidencia parcial de texto.
;dom: stack
;recorrido: función (all o labels) X string (texto a buscar)
;rec: lista de respuestas y preguntas que responden al criterio

(define search (lambda (stack)
                 (lambda (operation)
                   (lambda (word)
                     (if (string? (car stack))
                         (let ([questions (cadr (cdr stack))]
                               [answers (cadddr (cdr stack))])
                           (operation questions answers word))
                         (let ([questions (cadr stack)]
                               [answers (cadddr stack)])
                         (operation questions answers word)))))))
