USE InstitutoTICH
GO

--1. Alumnos cuyo apellido sea �Mendoza�

SELECT * 
FROM Alumnos
WHERE primerApellido LIKE 'Mendoza' OR segundoaPellido LIKE 'Mendoza'

--2. Alumnos cuyo estatus sea �En Capacitaci�n�

SELECT * 
FROM Alumnos A
INNER JOIN EstatusAlumnos EA ON A.idEstatus = EA.id
WHERE EA.nombre LIKE 'En Capacitaci�n'

--3. Instructores que sean mayores de 30 a�os

SELECT *, (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) AS Edad
FROM Instructores
WHERE (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) > 30

--4. Alumnos que est�n entre 20 y 25 a�os

SELECT *, (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) AS Edad
FROM Alumnos
WHERE (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) >= 20 AND (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) <= 25
ORDER BY (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) DESC

/*5. Alumnos que sea del Estado de �Oaxaca� y su estatus sea �En 
Capacitaci�n�, o que sean de �Campeche� y que est�n en estatus 
�Prospecto�*/

SELECT CONCAT (A.nombre, ' ', A.primerApellido, ' ', A.segundoaPellido) AS Alumno, E.nombre AS Estado, EA.nombre
FROM Alumnos A
INNER JOIN Estados E ON A.idEstadoOrigen = E.id
INNER JOIN EstatusAlumnos EA ON A.idEstatus = EA.id
WHERE (E.nombre LIKE 'Quintana Roo' AND EA.nombre LIKE 'En capacitaci�n') OR (E.nombre LIKE 'Nuevo Le�n' AND EA.nombre LIKE 'Prospecto')

--6. Alumnos cuyo correo sea de gmailSELECT * FROM AlumnosWHERE correo LIKE '%gmail%'--7. Alumnos que cumplen a�os en el mes de marzoSELECT *FROM AlumnosWHERE fechaNacimiento LIKE '%-03-%'/*8. Alumnos que cumplen 30 a�os dentro de 5 a�os en relaci�n con la fecha 
actual*/SELECT * FROM AlumnosWHERE (DATEDIFF(MONTH, DATEADD(YEAR, 5, fechaNacimiento), GETDATE()) / 12) >= 30 --9. Alumnos cuyo nombre exceda de 10 caracteresSELECT * FROM AlumnosWHERE nombre LIKE '__________%'--10.Alumnos cuyo �ltimo car�cter del curp sea num�ricoSELECT *FROM AlumnosWHERE curp LIKE '%[0-9]'--11.Alumnos cuya calificaci�n sea mayor que 8SELECT *FROM Alumnos AINNER JOIN CursosAlumnos CA ON CA.idAlumnos = A.idWHERE CA.calificacion > 8/*12.Alumnos que se encuentren en estatus laborando o liberado con un 
sueldo superior a 15,000*/SELECT *FROM Alumnos AINNER JOIN EstatusAlumnos EA ON A.idEstatus = EA.idWHERE (EA.nombre LIKE 'Laborando' OR EA.nombre LIKE 'Liberado') AND A.sueldo > 15000/*13.Alumnos cuyo a�o de nacimiento est� entre 1990 y 1995 y que su 
primer apellido empiece con B, C � Z*/SELECT *FROM AlumnosWHERE (YEAR(fechaNacimiento) >= 1990 AND YEAR(fechaNacimiento) <= 1995) AND (primerApellido LIKE '[BCZG]%')/*. Alumnos cuyo fecha de Nacimiento no coincide con la fecha de nacimiento del 
curp
� Nombre del alumno
� Curp
� Fecha de Nacimiento*/SELECT CONCAT(nombre,' ', primerApellido,' ', segundoaPellido) AS [Nombre del alumno], curp AS CURP, fechaNacimiento AS [Fecha de nacimiento]FROM AlumnosWHERE fechaNacimiento NOT LIKE CONVERT(DATE,SUBSTRING(curp, 5,6))/*15. Alumnos cuyo primer apellido inicie con �A� y el mes de nacimiento sea abril y 
que tengan entre 21 y 30 a�os*/

SELECT *, (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) AS Edad
FROM Alumnos
WHERE (primerApellido LIKE 'A%') AND (fechaNacimiento LIKE '%-04-%') AND ((DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) >= 21 AND (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) <= 30)

--16. Obtener una lista de alumnos que se llaman Luis aunque sea compuestoSELECT * FROM AlumnosWHERE nombre LIKE '%Luis%'/*17. Obtener una consulta de los cursos que se han impartido en el a�o de 2021, 
o nombre del curso
o fecha de inicio
o fecha final
o cantidad de alumnos
o promedio de calificaciones*/

SELECT CC.nombre AS [Nombre del Curso], C.fechaInicio AS [Fecha de Inicio], C.fechaTermino AS [Fecha Final], COUNT (CA.idAlumnos) AS [Cantidad de Alumnos], AVG (CA.calificacion) AS [Promedio de Calificaciones]
FROM Cursos C
INNER JOIN CatCursos CC ON C.idCatCurso = CC.id
INNER JOIN CursosAlumnos CA ON CA.idCurso = C.id
GROUP BY CC.nombre, C.fechaInicio, C.fechaTermino
HAVING /*C.fechaInicio LIKE '2021-%' */ YEAR(C.fechaInicio) = 2021 

/*18. Realizar la siguiente consulta Resumen de Calificaciones por Estado, 
considerando �nicamente a los alumnos que tienen calificaci�n mayor a 6
mostrando �nicamente a los estados cuyo total de alumnos (con promedio 
mayor a 6) sea mayor a 1*/

SELECT E.nombre AS Estado, COUNT(A.idEstadoOrigen) AS Total, AVG(CA.calificacion) AS [Prom. Calif.], AVG(A.sueldo) AS [Prom. Sueldo]
FROM Estados E
INNER JOIN Alumnos A ON A.idEstadoOrigen = E.id
INNER JOIN CursosAlumnos CA ON CA.idAlumnos = A.id
GROUP BY E.nombre, CA.calificacion
HAVING CA.calificacion > 6 