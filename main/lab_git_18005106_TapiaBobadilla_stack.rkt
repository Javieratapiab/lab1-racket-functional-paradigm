#lang racket

(require "lab_git_18005106_TapiaBobadilla_usuario.rkt")
(require "lab_git_18005106_TapiaBobadilla_pregunta.rkt")
(require "lab_git_18005106_TapiaBobadilla_respuesta.rkt")
(require "lab_git_18005106_TapiaBobadilla_reward.rkt")
(require "lab_git_18005106_TapiaBobadilla_utils.rkt")
(require "lab_git_18005106_TapiaBobadilla_fecha.rkt")
(require "lab_git_18005106_TapiaBobadilla_search.rkt")

(provide stackList)
(provide register)
(provide login)
(provide stack->string)

;CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear un stack (contenedor de listas)
;dom: lista
;rec: lista de listas (usuarios registrados X preguntas X recompensas X respuestas)

(define (stackList users)
  (if (list? users)
      (list users null null null)
      null))


;SELECTORES
;-------------------------------------------------------------------------
;descripción: Función que permite obtener los usuarios dentro de una lista (stack)
;dom: stack
;rec: usuarios

(define getUsers car)

;descripción: Función que permite obtener las preguntas dentro de una lista (stack)
;dom: stack
;rec: preguntas

(define getQuestions cadr)

;descripción: Función que permite obtener las recompensas dentro de una lista (stack)
;dom: stack
;rec: rewards

(define getRewards caddr)

;descripción: Función que permite obtener las respuestas dentro de una lista (stack)
;dom: stack
;rec: respuestas

(define getAnswers cadddr)


; MODIFICADORES
;-------------------------------------------------------------------------
;descripción: Función que permite registrar un usuario en el stack
;dom: stack X string X string
;rec: stack (con usuario registrado)

(define (register stack username password)
  (if (null? (getUser username (getUsers stack)))
      (addUser username password stack)
      stack))


;descripción: Función que permite loguear un usuario del stack con username y password
;             y retornar una función currificada de la operación recibida.
;dom: stack X string X string X función
;rec: función currificada que retorna stack actualizado

(define (login stack username password operation)
  (let ([user (getUser username (getUsers stack))])
    (if (and (null? user)(eq? (getPass user) password))
        operation
        (((force lazy-operation) operation)
         (cons username stack)))))


;OTRAS IMPLEMENTACIONES
;-------------------------------------------------------------------------
;descripción: Función perezosa auxiliar que permite
;             gatillar una operación (función) currificada
;dom: función X stack
;rec: stack actualizado

(define lazy-operation
  (lazy (lambda (operation)
          (lambda (stack)
            (operation stack)))))

;descripción: Función que da formato a usuarios registrados en la lista stack
;dom: users
;tipo de recursión: cola
;rec: string (usuarios registrados)

(define (formatUsersWrapper users)
  (define (formatUsers users result)
    (if (null? users)
        result
        (formatUsers (cdr users)(string-append result "- Username: " (car (car users)) "\n"
                                                      "- Password: " (cadr (car users)) "\n"))))
  (formatUsers users "--- Usuarios --- \n"))

;descripción: Función que da formato a preguntas en la lista stack
;dom: questions
;tipo de recursión: cola
;rec: string (preguntas)

(define (formatQuestionsWrapper questions)
  (define (formatQuestions questions result)
    (if (null? questions)
        result
        (formatQuestions (cdr questions)
                         (string-append result "- ID: " (number->string (getQuestionId (car questions))) "\n"
                                        "- Estado: " (getQuestionStatus (car questions)) "\n"
                                        "- Votos positivos: " (number->string (getQuestionUpVotes (car questions))) "\n"
                                        "- Votos negativos: " (number->string (getQuestionDownVotes (car questions))) "\n"
                                        "- Visualizaciones: " (number->string (getQuestionViews (car questions))) "\n"
                                        "- Título: " (getQuestionTitle (car questions)) "\n"
                                        "- Fecha última modificación: " (date->string (getQuestionLastActivity (car questions))) "\n"
                                        "- Autor: " (getQuestionUser (car questions))"\n"
                                        "- Fecha de publicación: " (date->string (getQuestionPublicationDate (car questions))) "\n"
                                        "- Contenido: " (getQuestionContent (car questions)) "\n"
                                        "- Etiquetas: " (string-join (getQuestionLabels (car questions))) "\n"))))  
  (formatQuestions questions "--- Preguntas --- \n"))

;descripción: Función que da formato a recompensas en la lista stack
;dom: rewards
;tipo de recursión: cola
;rec: string (rewards)

(define (formatRewardsWrapper rewards)
  (define (formatRewards rewards result)
    (if (null? rewards)
        result
        (formatRewards (cdr rewards)
                       (string-append result "- Usuario: " (getRewardUser (car rewards)) "\n"
                                      "- ID pregunta: " (number->string (getRewardQuestionId (car rewards))) "\n"
                                      "- Cantidad recompensa: " (number->string (getRewardQuantity (car rewards))) "\n"))))
  (formatRewards rewards "--- Recompensas --- \n"))

;descripción: Función que da formato a respuestas en la lista stack
;dom: answers
;tipo de recursión: cola
;rec: string (answers)

(define (formatAnswersWrapper answers)
  (define (formatAnswers answers result)
    (if (null? answers)
        result
        (formatAnswers (cdr answers)
                       (string-append result "- ID: " (number->string (getAnswerId (car answers))) "\n"
                                      "- ID pregunta: " (number->string (getAnswerQuestionId (car answers))) "\n"
                                      "- Autor: " (getAnswerUser (car answers)) "\n"
                                      "- Status: " (getAnswerStatus (car answers)) "\n"
                                      "- Votos positivos: " (number->string (getAnswerUpVotes (car answers))) "\n"
                                      "- Votos negativos: " (number->string (getAnswerDownVotes (car answers))) "\n"
                                      "- Reportes de ofensa: " (number->string (getAnswerOffenseReports (car answers))) "\n"
                                      "- Fecha de publicación: " (date->string (getAnswerPublicationDate (car answers))) "\n"
                                      "- Contenido: " (getAnswerContent (car answers)) "\n"
                                      "- Etiquetas: " (string-join (getAnswerLabels (car answers))) "\n"))))
  (formatAnswers answers "--- Respuestas --- \n"))

;descripción: Función que entrega una representación del stack 
;             como un posible string posible de visualizar de forma comprensible
;dom: stack
;rec: string

(define stack->string (lambda (stack)
                        (if (string? (car stack)) ; validación de user logueado
                            (let ([users (getUsers (cdr stack))]
                                  [questions (getQuestions (cdr stack))]
                                  [rewards (getRewards (cdr stack))]
                                  [answers (getAnswers (cdr stack))])
                              (string-append "*** Información Usuario logueado: " (car stack) " *** \n"
                                             (formatUsersWrapper (filter (lambda (u) (eq? (car stack) (car u))) users))
                                             (formatQuestionsWrapper questions)
                                             (formatAnswersWrapper answers)))
                            (let ([users (getUsers stack)]
                                  [questions (getQuestions stack)]
                                  [rewards (getRewards stack)]
                                  [answers (getAnswers stack)])
                              (string-append (formatUsersWrapper users)
                                             (formatQuestionsWrapper questions)
                                             (formatRewardsWrapper rewards)
                                             (formatAnswersWrapper answers))))))