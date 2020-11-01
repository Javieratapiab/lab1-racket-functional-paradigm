#lang racket

;IMPORTS
(require "usuario.rkt")
(require "stack.rkt")

;Caso prueba
(define stack_1 (register (stack (user "pepito" "miclave")(user "Javiera" 12345)) "Tomás" 12345))#