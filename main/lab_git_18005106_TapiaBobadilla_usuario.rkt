#lang racket

(require "lab_git_18005106_TapiaBobadilla_pregunta.rkt")
(require "lab_git_18005106_TapiaBobadilla_respuesta.rkt")
(require "lab_git_18005106_TapiaBobadilla_reward.rkt")

(provide user)
(provide getName)
(provide getUser)
(provide getPass)
(provide addUser)
(provide reward)
(provide accept)

;CONSTRUCTOR
;-------------------------------------------------------------------------
;descripción: Función que permite crear la lista user
;dom: string X string
;rec: usuario (username password reputation temporalReputation)

(define (user username password)
  (if (and (string? username)(string? password))
      (list username password 100 0)
      null))


;PERTENENCIA
;-------------------------------------------------------------------------
;descripción: Función que permite determinar si un elemento cualquiera es del tipo user
;             se implementa a partir del constructor evaluando el retorno
;dom: elemento de cualquier tipo
;rec: boolean
(define (user? u)
  (and (list? u)
       (= (length u) 4)
       (not (null? (user (car u) (cadr u))))))


;SELECTORES
;-------------------------------------------------------------------------
;descripción: Función que permite obtener nombre de un usuario
;dom: user
;rec: string (username)

(define getName car)

;descripción: Función que permite obtener password de un usuario
;dom: user
;rec: string (password)

(define getPass cadr)

;descripción: Función que permite obtener reputación de un usuario
;dom: user
;rec: string (reputation)

(define getReputation caddr)

;descripción: Función que permite obtener reputación (temporal) de un usuario
;dom: user
;rec: string (temporalReputation)

(define getTemporalReputation cadddr)

;descripción: Función que permite obtener un usuario de una lista (stack)
;dom: string X stack
;tipo de recusión: cola
;rec: usuario

(define (getUser username users)
  (if (null? users)
      users
      (if (and (eq? (getName (car users)) username))
          (car users)
          (getUser username (cdr users)))))


;MODIFICADORES
;-------------------------------------------------------------------------

;descripción: Función que aplica lógica de recompensas para todos los usuarios involucrados
;             (usuario que hace la pregunta, usuario que responde, usuarios que dieron recompensa a la pregunta cuya respuesta fue aceptada)
;dom: users X string (question author) X string (answer author) X string X rewards (asociadas al id de pregunta)
;rec: lista de usuarios actualizada

(define (acceptUsersReputation users questionUsername answerUsername rewards)
  (let ([questionUser (getUser questionUsername users)]
        [answerUser (getUser answerUsername users)])
    (append (filter (lambda (u) (not (or (eq? questionUser u)
                                         (eq? answerUser u)))) users)
            (list (list (getName questionUser) ; Modifica reputación de usuario creador de la pregunta (+2)
                        (getPass questionUser)
                        (addReputation questionUser 2 rewards)
                        (calculateTemporalReputation questionUser rewards))
                  (list (getName answerUser)  ; Modifica reputación de usuario al que aceptaron su respuesta (+15)
                        (getPass answerUser)
                        (addReputation answerUser 15 rewards)
                        (calculateTemporalReputation answerUser rewards))))))


;descripción: Función que agrega reputación al usuario y resta de ella la recompensa si aplica
;dom: usuario X integer (cantidad reputación) X rewards
;rec: lista de usuarios actualizada

(define (addReputation user quantity rewards)
  (let ([userReward (findRewardByUser rewards (car user))])
    (if (null? userReward)
        (+ (getReputation user) quantity)
        (- (+ (getReputation user) quantity)(caddr (car userReward))))))


;descripción: Función que calcula la reputación temporal si hay una recompensa vigente
;dom: usuario X rewards
;rec: lista de usuarios actualizada

(define (calculateTemporalReputation user rewards)
  (let ([userReward (findRewardByUser rewards (car user))])
    (if (null? userReward)
        (getTemporalReputation user)
        (+ (getTemporalReputation user)(caddr (car userReward))))))

;descripción: Función que modifica un usuario definiendo una nueva reputación
;             en base a la cantidad de recompensa ofrecida, retorna la lista
;             de users actualizada.
;dom: usuario X usuarios X integer (cantidad recompensa)
;rec: lista de usuarios actualizada

(define (setReputation user users rewardQuantity)
  (append (filter (lambda (u) (not(eq? user u))) users)
          (list (list (getName user)
                      (getPass user)
                      (getReputation user)
                      (- (getTemporalReputation user) rewardQuantity)))))

;descripción: Función que asocia una recompensa a una pregunta y actualiza el stack
;             si el cálculo de reputación del usuario es superior a la cantidad de recompensa.
;dom: usuario X integer (cantidad de recompensa) X integer (ID de la pregunta) X stack
;rec: stack actualizado

(define (setRewards author rewardQuantity questionId stack)
  (let ([user (getUser author (car (cdr stack)))]
        [users (car (cdr stack))])
    (if (< (calculateReputation user) rewardQuantity)
        (cdr stack)
        (list (setReputation user users rewardQuantity)
              (getQuestions stack)
              (setReward (cdr stack) author rewardQuantity questionId)
              (cadddr (cdr stack))))))


;descripción: Función que permite agregar un usuario a una lista (stack)
;dom: string X string X stack
;rec: stack (con nuevo usuario)

(define (addUser username password stack)
  (let ([user (user username password)])
    (if (user? user)
        (cons (cons user (car stack))(cdr stack))
        stack)))


;descripción: Función currificada que permite a un usuario logueado
;             crear una recompensa asociada a una pregunta.
;dom: stack
;recorrido: integer (ID pregunta) X integer (recompensa)
;rec: stack actualizado

(define reward (lambda (stack)
                 (lambda (questionId)
                   (lambda (rewardQuantity)
                     (if (string? (car stack))
                         (setRewards (car stack) rewardQuantity questionId stack)
                         stack)))))


;descripción: Función currificada que permite a un usuario aceptar
;             una respuesta a una de sus preguntas.
;dom: stack
;recorrido: integer (ID pregunta) X integer (ID respuesta)
;rec: stack actualizado

(define accept (lambda (stack)
                 (lambda (questionId)
                   (lambda (answerId)
                     (if (string? (car stack))
                         (let ([author (car stack)]
                               [users (car (cdr stack))]
                               [questions (cadr (cdr stack))]
                               [rewards (caddr (cdr stack))]
                               [answers (cadddr (cdr stack))])
                           (let ([question (getQuestionById questions questionId)]
                                 [answer (getAnswerById answers answerId)])
                             (if (eq? (getQuestionUser (car question)) author) ; Valida que la pregunta esté asociada al usuario logueado que acepta pregunta
                                 (list (acceptUsersReputation users author (getAnswerUser (car answer))(getRewardsByQuestionId rewards questionId))
                                       (cons (setQuestionStatus question "cerrada")  ; Modifica estado de una pregunta
                                             (filter (lambda (q) (not (eq? questionId (car q)))) questions))
                                       (removeRewards (getRewardsByQuestionId rewards questionId) rewards) ; Modifica recompensas
                                       (cons (setAnswerStatus answer "sí")  ; Modifica estado de una respuesta
                                             (filter (lambda (a) (not (eq? answerId (car a)))) answers)))
                                 (cdr stack))))
                         stack)))))

;OTRAS IMPLEMENTACIONES
;-------------------------------------------------------------------------
;descripción: Función que calcula la reputación total (real y temporal) de un user
;dom: user
;rec: integer

(define (calculateReputation user)
  (+ (getReputation user)(getTemporalReputation user)))
