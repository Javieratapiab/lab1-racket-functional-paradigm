#lang racket

;EXPORTS
(provide user)
(provide getName)
(provide getPass)
(provide getReputation)
;---------------------------------------

;CONSTRUCTOR
;descripción: Permite crear un usuario
;dom: lista
;rec: lista
(define user list)

; SELECTORES
;descripción: Permite obtener nombre de usuario
;dom: user
;rec: string
(define getName car)

;descripción: Permite obtener password de usuario
;dom: user
;rec: string
(define getPass cadr)

;descripción: Permite obtener reputación de usuario
;dom: user
;rec: string
(define getReputation caddr)
