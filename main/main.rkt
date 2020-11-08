#lang racket

(require "stack.rkt")
(require "usuario.rkt")
(require "pregunta.rkt")
(require "utils.rkt")

;-------------------------------------------------------------------------
; CASOS DE PRUEBA
;-------------------------------------------------------------------------

; 1. REGISTER
;-------------------------------------------------------------------------

(display "******* REGISTER ********\n")
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
(display "* Caso específico: usuario sin poder registrarse (validación de username) \n")
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
(define multipleAsk (lazy (((login (force validAsk1) "Jeff Bezos" "pa$$" ask)
                               (date 30 09 2020)) "What does scope mean?" "javascript")))

(display "1)")
(force validAsk1)
(display "2)")
(force validAsk2)
(display "3)")
(force validAsk3)
(display "* Caso específico: creación de pregunta sin usuario logueado (retorna stack) \n")
(display "4)")
(force invalidAsk)
(display "* Extra: creación de multiples preguntas con una colección de usuarios registrados \n")
(display "5)")
(force multipleAsk)

; 3. REWARD
;-------------------------------------------------------------------------
(display "\n******* REWARD ********\n")

; Descripción: Función reward y creación de recompensas con usuario logueado
(display "* Login y creación de recompensas con usuario logueado \n")

(define validReward1
  (lazy (((login (force multipleAsk) "Bill Gates" "mi$uperklave" reward) 2) 50)))

(define validReward2
  (lazy (((login (force multipleAsk) "Jeff Bezos" "pa$$" reward) 2) 75)))

(define validReward3
  (lazy (((login (force multipleAsk) "Dan abramov" "123454321" reward) 2) 55)))

; Descripción: Recompensa excede reputación de usuario (retorna stack)
(define validReward4
  (lazy (((login (force multipleAsk) "Bill Gates" "mi$uperklave" reward) 2) 200)))

; Descripción: Creación de múltiples recompensas (con distintos usuarios)
(define validReward5
  (lazy (((login (force validReward3) "Jeff Bezos" "pa$$" reward) 2) 80)))

(display "1)")
(force validReward1)
(display "2)")
(force validReward2)
(display "3)")
(force validReward3)
(display "* Caso específico: recompensa excede reputación de usuario (retorna stack) \n")
(display "4)")
(force validReward4)
(display "* Extra: creación de multiples recompensas con una colección de usuarios registrados \n")
(display "5)")
(force validReward5)