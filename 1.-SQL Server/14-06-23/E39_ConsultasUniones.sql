/*Obtener una consulta que contenga el Nombre y apellidos, mes y día 
de nacimiento de todos los alumnos y profesores, ordenado por tipo 
mes y día de nacimientO*/

SELECT 'Alumno' AS TipoPersona, nombre, primerApellido, segundoaPellido, DATEPART(MONTH, fechaNacimiento) AS MesNacimiento, DATEPART(DAY, fechaNacimiento) AS DiaNacimiento
FROM Alumnos
UNION
SELECT 'Profesor' AS TipoPersona , nombre, primerApellido, segundoApellido, DATEPART(MONTH, fechaNacimiento) AS MesNacimiento, DATEPART(DAY, fechaNacimiento) AS DiaNacimiento
FROM Instructores
ORDER BY DATEPART(MONTH, fechaNacimiento), DATEPART(DAY, fechaNacimiento)