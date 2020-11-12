# Laboratorio paradigmas: [Stackoverflow](https://stackoverflow.com/)

Se presenta proyecto semestral de laboratorio de la asignatura **"Paradigmas de programación"** de la Universidad Santiago de Chile, que consta en la creación de un clon de la aplicación Stackoverflow en el lenguaje Scheme, que consolida los conocimientos del paradigma funcional.

## Autora
- [Javiera Tapia Bobadilla](https://github.com/javieratapiab)
  
## Características

- Paradigma: Funcional

- Lenguage: Scheme (https://groups.csail.mit.edu/mac/projects/scheme/)

- Entorno: DrRacket v7.8 (https://download.racket-lang.org/)


## Construcción de TDAs

| Abstracción         	| Contexto                                                                                                                                                     	| Características (Qué)                                                                                                                                                                                                                                                                                                                                                                                                                	|
|---------------------	|--------------------------------------------------------------------------------------------------------------------------------------------------------------	|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	|
| Stack               	| Estructura base que funciona como contenedor de usuarios, preguntas, recompensas, <br>respuestas y búsqueda.                                                 	| Lista de listas que se encarga de contener una serie de estructuras (del tipo lista), <br>tales como: usuarios, preguntas, recompensas, respuestas y búsqueda dentro de la plataforma.                                                                                                                                                                                                                                               	|
| Usuario (User)      	| Persona que publica, edita y elimina tanto preguntas como respuestas,<br>ofrece recompensas, vota, reporta, entre otros.                                     	| - Lista que posee credenciales de acceso y reputación<br>- Ofrece reputación, pregunta y responde, da ranking, etc. dentro de la plataforma.                                                                                                                                                                                                                                                                                         	|
| Pregunta (Question) 	| Enunciado interrogativo realizado por un usuario sobre diversas<br>tecnologías relacionadas a la ingeniería de software en la plataforma.                    	| - Lista que puede ser editada, modificada y eliminada.<br>- Es creada por un usuario y recibe ranking por medio del mismo.<br>- Posee textos con formato (negrita, cursiva) imágenes, enlaces y código<br>- Posee un ID, votaciones (positivas y negativas), visualizaciones,<br>  etiquetas, título, contenido, fecha de publicación, fecha de última modificación , etc.<br>- Es referenciada por una respuesta a través de su ID. 	|
| Respuesta (Answer)  	| Enunciado que responde a una pregunta realizada por un usuario<br>sobre diversas tecnologías relacionadas a la ingeniería de software en la plataforma       	| - Lista que recibe ranking y referencia una pregunta.<br>- Es creada por un usuario, quien puede recibir una bonificación (reputación) si esta es aceptada.<br>- Posee un autor (usuario), fecha de publicación, votos (favor y contra), estado de aceptación (sí/no), <br>  reportes de ofensa y categorías (mejor respuesta, peor respuesta, etc).                                                                                 	|
| Recompensa (Reward) 	| Bonificación que genera un usuario y que compensa<br>la utilidad de una pregunta dentro de la plataforma.                                                    	| - Lista que posee una descripción, id de pregunta y usuario que la otorgó.<br>- Bonifica una pregunta y posee diversas reglas en su aplicación.                                                                                                                                                                                                                                                                                      	|
| Búsqueda (Search)   	| Motor de búsqueda dentro de la plataforma que resulta de utilidad para encontrar información rápidamente<br>por medio de una coincidencia parcial de texto.  	| - Búsqueda por etiqueta (entre corchetes)<br>- Búsqueda palabra exacta (entre comillas)<br>- Búsqueda por cantidad de respuestas (answers: numero_x)<br>- Búsqueda por puntaje (score: numero_x)                                                                                                                                                                                                                                     	|

## Instrucciones de uso

- Instalación de DrRacket (https://download.racket-lang.org/) en máquina local.
- Correr la aplicación y abrir archivo `main.rkt`, donde se ubican los casos pruebas.
- Clickear en botón `RUN`, esquina superior derecha del IDE.

  
## Características del laboratorio

- Más sobre los requerimientos y especificaciones: [Link a la actividad](https://docs.google.com/document/d/1TwFzL2nr5yJ24qKY3V4Z-iSBFnZuGbB_tgJ2ov_UtJs)
