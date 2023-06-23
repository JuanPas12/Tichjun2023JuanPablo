USE InstitutoTICH;
GO

/*1. Realizar la siguiente consulta Alumnos por Estado*/

SELECT E.nombre, COUNT (A.idEstadoOrigen) AS [Total Alumnos]
FROM Estados E
INNER JOIN Alumnos A ON E.id = A.idEstadoOrigen 
GROUP BY E.nombre

/*2. Realizar la siguiente consulta Alumnos por Estatus*/

SELECT EA.nombre AS Estatus, COUNT (A.idEstatus) AS Total
FROM EstatusAlumnos EA
INNER JOIN Alumnos A ON A.idEstatus = EA.id
GROUP BY EA.nombre

--3. Realizar la siguiente consulta Resumen de Calificaciones

SELECT 'Cursos Alumnos' AS [Resumen Calificaciones], COUNT (calificacion) AS Totak, MAX (calificacion) AS Maxima, MIN (calificacion) AS Minima, AVG (calificacion) AS Promedio
FROM CursosAlumnos

--4. Realizar la siguiente consulta Resumen de Calificaciones por Curso

SELECT CC.nombre,  C.fechaInicio, C.fechaTermino, COUNT (CA.calificacion) AS Total, MAX (CA.calificacion) AS Maxima, MIN (CA.calificacion) AS Minima, AVG(CA.calificacion) AS Promedio
FROM CatCursos CC
INNER JOIN Cursos C ON C.idCatCurso = CC.id
INNER JOIN CursosAlumnos CA ON CA.idCurso = C.id
GROUP BY C.fechaInicio,c.fechaTermino , CC.nombre

/* Realizar la siguiente consulta Resumen de Calificaciones por Estado, 
considerando únicamente a los Estados que tienen promedio mayor a 
6*/

SELECT E.nombre AS Estado, COUNT (CA.calificacion) AS Total, MAX(CA.calificacion) AS Maxima, MIN (CA.calificacion) AS Minima, AVG (CA.calificacion) AS Promedio
FROM CursosAlumnos CA 
INNER JOIN Alumnos A ON CA.idAlumnos = A.id
INNER JOIN Estados E ON A.idEstadoOrigen = E.id
GROUP BY E.nombre
HAVING (AVG (CA.calificacion)) > 6