#lang racket

(require "lab_git_18005106_TapiaBobadilla_stack.rkt")
(require "lab_git_18005106_TapiaBobadilla_usuario.rkt")
(require "lab_git_18005106_TapiaBobadilla_pregunta.rkt")
(require "lab_git_18005106_TapiaBobadilla_respuesta.rkt")
(require "lab_git_18005106_TapiaBobadilla_fecha.rkt")

;-------------------------------------------------------------------------
; CASOS DE PRUEBA
;-------------------------------------------------------------------------

; 1. REGISTER
;-------------------------------------------------------------------------

(display "\n******* REGISTER ********\n")
; Descripción: Creación de stack y registro de lista de users

(display "* Creación de stack y registro de usuarios \n")
(define stackOverflow (stackList (list (user "Bill Gates" "mi$uperklave")
                                       (user "Dan abramov" "123454321"))))
(define stackOverflow1 (register stackOverflow "Jeff Bezos" "pa$$"))
(define stackOverflow2 (register stackOverflow "Mark Zuckerberg" "pa$$w0rd"))
(define stackOverflow3 (register stackOverflow "Bill Gates" "pa$$w0rd"))

(display "1)")
stackOverflow
(display "2)")
stackOverflow1
(display "3)")
stackOverflow2

; Descripción: Registro de usuario no existoso, usuario ya registrado (validación por username)
(display "* Caso específico: Usuario sin poder registrarse (validación de username) \n")
(display "4)")
stackOverflow3


; 2. ASK Y LOGIN
;-------------------------------------------------------------------------
(display "\n******* ASK Y LOGIN ********\n")

; Descripción: Función login y creación de preguntas con usuario logueado
(display "* Login y creación de preguntas con usuario logueado \n")

(define validAsk1
  (lazy (((login stackOverflow1 "Bill Gates" "mi$uperklave" ask)
          (date 30 10 2020)) "What is hoisting?" "javascript" "computer science" "functional paradigm")))

(define validAsk2
  (lazy (((login stackOverflow2 "Mark Zuckerberg" "pa$$w0rd" ask)
          (date 30 10 2020)) "How to create a web app using php?" "php" "web app")))

(define validAsk3
  (lazy (((login stackOverflow1 "Dan abramov" "123454321" ask)
          (date 30 10 2020)) "Is it better to use React hooks than life?" "react" "javascript" "hooks")))

; Descripción: Creación de pregunta inválida (usuario no logueado)
(define invalidAsk (lazy (((ask stackOverflow1)
                           (date 20 10 20)) "How can i hack an email?" "hacking")))

; Descripción: Creación de múltiples preguntas (con distintos usuarios)
(define multipleAsk1 (lazy (((login (force validAsk1) "Jeff Bezos" "pa$$" ask)
                             (date 30 09 2020)) "What does scope mean?" "javascript")))
(define multipleAsk2 (lazy (((login (force multipleAsk1) "Jeff Bezos" "pa$$" ask)
                             (date 30 09 2020)) "What is dijkstra algorithm?" "algorithms" "computer science")))

(display "1)")
(force validAsk1)
(display "2)")
(force validAsk2)
(display "3)")
(force validAsk3)
(display "* Caso específico: Creación de pregunta sin usuario logueado (retorna stack) \n")
(display "4)")
(force invalidAsk)
(display "* Extra: Creación de multiples preguntas conservando stack \n")
(display "5)")
(force multipleAsk1)

; 3. REWARD
;-------------------------------------------------------------------------
(display "\n******* REWARD ********\n")

; Descripción: Función reward y creación de recompensas con usuario logueado
(display "* Login y creación de recompensas con usuario logueado \n")

(define validReward1
  (lazy (((login (force multipleAsk1) "Bill Gates" "mi$uperklave" reward) 2) 50)))

(define validReward2
  (lazy (((login (force multipleAsk1) "Jeff Bezos" "pa$$" reward) 2) 75)))

(define validReward3
  (lazy (((login (force multipleAsk2) "Dan abramov" "123454321" reward) 2) 55)))

; Descripción: Recompensa excede reputación de usuario (retorna stack)
(define invalidReward
  (lazy (((login (force multipleAsk1) "Bill Gates" "mi$uperklave" reward) 2) 200)))

; Descripción: Creación de múltiples recompensas (con distintos usuarios)
(define multipleReward
  (lazy (((login (force validReward2) "Dan abramov" "123454321" reward) 3) 80)))

(define multipleReward2
  (lazy (((login (force validReward2) "Jeff Bezos" "pa$$"  reward) 1) 22)))

(display "1)")
(force validReward1)
(display "2)")
(force validReward2)
(display "3)")
(force validReward3)
(display "* Caso específico: Recompensa excede reputación de usuario (retorna stack) \n")
(display "4)")
(force invalidReward)
(display "* Extra: Creación de multiples recompensas conservando stack \n")
(display "5)")
(force multipleReward)

; 4. ANSWER
;-------------------------------------------------------------------------
(display "\n******* ANSWER ********\n")

; Descripción: Función answer y creación de respuestas con usuario logueado
(display "* Login y creación de respuestas con usuario logueado \n")

(define validAnswer1 (lazy ((((login (force multipleReward) "Jeff Bezos" "pa$$" answer)
                              (date 30 10 2020)) 2) "Refers to the current context of code, which determines the accessibility" "javascript")))

(define validAnswer2 (lazy ((((login (force multipleReward2) "Jeff Bezos" "pa$$" answer)
                              (date 15 11 2020)) 1) "I don't know what it means but i think is cool" "javascript")))

(define validAnswer3 (lazy ((((login (force multipleReward) "Dan abramov" "123454321" answer)
                              (date 16 12 2020)) 1) "Default behavior of moving all declarations to the top of the current scope" "javascript")))

; Descripción: Creación de múltiples respuestas (con distintos usuarios)
(define multipleAnswer1 (lazy ((((login (force validAnswer3) "Bill Gates" "mi$uperklave" answer)
                                (date 13 10 2020)) 2) "Scope in JavaScript refers to the current context of code" "javascript")))

(define multipleAnswer2 (lazy ((((login (force validAnswer2) "Dan abramov" "123454321" answer)
                                (date 13 10 2020)) 2) "Scope in JavaScript refers to the current context of code" "javascript")))

; Descripción: Creación de respuesta inválido con una pregunta inexistente (retorna stack)
(define invalidAnswer (lazy ((((login (force multipleAnswer2) "Dan abramov" "123454321" answer)
                               (date 16 12 2020)) 18) "Default behavior of moving all declarations to the top of the current scope" "javascript")))

(display "1)")
(force validAnswer1)
(display "2)")
(force validAnswer2)
(display "3)")
(force validAnswer3)
(display "* Caso específico: Creación de respuesta inválido con una pregunta inexistente (retorna stack) \n")
(display "4)")
(force invalidAnswer)
(display "* Extra: Creación de multiples respuestas conservando stack \n")
(display "5)")
(force multipleAnswer1)

; 5. ACCEPT
;-------------------------------------------------------------------------
(display "\n******* ACCEPT ********\n")

; Descripción: Función accept y aceptación de respuestas con usuario logueado
(display "* Login y aceptación con usuario logueado \n")
(define validAccept1 (lazy (((login (force multipleAnswer1) "Jeff Bezos" "pas$$" accept) 2) 2)))
(define validAccept2 (lazy (((login (force multipleAnswer2) "Bill Gates" "pas$$" accept) 1) 1)))
(define invalidAccept (lazy (((login (force multipleAnswer1) "Dan abramov" "123454321" accept) 1) 1)))

(display "1)")
(force validAccept1)
(display "2)")
(force validAccept2)
(display "* Caso específico: Usuario intenta aceptar pregunta que no lo pertence. Retorna stack \n")
(display "3)")
(force invalidAccept)


; 6. STACK->STRING
;-------------------------------------------------------------------------
(display "\n******* STACK->STRING ********\n")

; Descripción: Función stack->string que da formato string a stack

(display "1)")
(display (stack->string (force validAccept1)))
(display "2)")
(display (stack->string (force validAccept2)))
(display "* Caso específico: Antecedentes de usuario logueado. \n")
(display (login (force validAnswer3) "Dan abramov" "123454321" stack->string))


; 7. SEARCH
;-------------------------------------------------------------------------
(display "\n******* SEARCH ********\n")
