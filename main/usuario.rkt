#lang racket

(provide user)
(provide getName)
(provide getPass)
(provide getReputation)

;CONSTRUCTOR
;descripción: Función que permite crear un usuario
;dom: lista
;rec: lista
(define user list)

; SELECTORES
;descripción: Función que permite obtener nombre de usuario
;dom: user
;rec: string
(define getName car)

;descripción: Función que permite obtener password de usuario
;dom: user
;rec: string
(define getPass cadr)

;descripción: Permite que permite obtener reputación de usuario
;dom: user
;rec: string
(define getReputation caddr)
