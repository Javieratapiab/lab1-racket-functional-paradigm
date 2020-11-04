#lang racket

(require "stack.rkt")
(require "usuario.rkt")
(require "pregunta.rkt")
(require "utils.rkt")

;Casos prueba
;-------------------------------------------------------------------------

; 1. Registro de usuarios
;-------------------------------------------------------------------------
(display "**** Usuarios registrados **** \n")
(define stackOverflow (stackList (list (user "Bill Gates" "mi$uperklave")
                                      (user "Dan abramov" "123454321"))))
(define stackOverflow1 (register stackOverflow "Jeff Bezos" "pa$$"))
(define stackOverflow2 (register stackOverflow "Mark Zuckerberg" "pa$$w0rd"))
(define stackOverflow3 (register stackOverflow "Bill Gates" "pa$$w0rd"))

stackOverflow
stackOverflow1
stackOverflow2
(display "* Caso 1: usuario sin poder registrarse (ID username ya tomado) \n")
stackOverflow3

; 2. Creación de preguntas y login
;-------------------------------------------------------------------------
(display "\n**** Creación de preguntas ****\n")
(define validAsk1
  (lazy (((login stackOverflow1 "Bill Gates" "mi$uperklave" ask)
          (date 30 10 2020)) "What is hoisting?" "javascript" "computer science" "functional paradigm")))

(define validAsk2
  (lazy (((login stackOverflow2 "Mark Zuckerberg" "pa$$w0rd" ask)
          (date 30 10 2020)) "How to create a web app using php?" "php" "web app")))

(define validAsk3
  (lazy (((login stackOverflow1 "Dan abramov" "123454321" ask)
          (date 30 10 2020)) "Is it better to use React hooks than life?" "react" "javascript" "hooks")))

(define invalidAsk (lazy (((ask stackOverflow1)
                           (date 20 10 20)) "How can i hack an email?" "hacking")))

(define multipleAsk (lazy (((login (force validAsk1) "Jeff Bezos" "pa$$" ask)
                               (date 30 09 2020)) "What does scope mean?" "javascript")))

(force validAsk1)
(force validAsk2)
(force validAsk3)
(display "* Caso 1: creación de pregunta sin usuario logueado (retorna stack) \n")
(force invalidAsk)
(display "* Caso 2: creación de multiples preguntas con una colección de usuarios registrados \n")
(force multipleAsk)

; 3. Recompensa por pregunta
;-------------------------------------------------------------------------
(display "\n**** Creación de recompensas **** \n")
(define validReward1
  (lazy (((login (force multipleAsk) "Bill Gates" "mi$uperklave" reward) 2) 200)))

(define validReward2
  (lazy (((login (force validReward1) "Bill Gates" "mi$uperklave" reward) 2) 50)))

(force validReward1)
(force validReward2)
