#lang racket

(provide user)
(provide user?)
(provide getName)
(provide getPass)

;CONSTRUCTOR
;descripción: Función que permite crear un usuario
;dom: lista
;rec: lista
(define (user username password)
  (if (and (string? username)(string? password))
    (list username password)
    null
  )
)

;PERTENENCIA
;descripción: Función que permite determinar si un elemento cualquiera es del tipo user
;se implementa a partir del constructor evaluando el retorno
;dom: elemento de cualquier tipo
;rec: boolean
(define (user? u)
  (and (list? u)
       (= (length u) 2)
      (not (null? (user (car u) (cadr u)))))
)

;SELECTORES
;descripción: Función que permite obtener nombre de usuario
;dom: user
;rec: string
(define getName car)

;descripción: Función que permite obtener password de usuario
;dom: user
;rec: string
(define getPass cadr)
