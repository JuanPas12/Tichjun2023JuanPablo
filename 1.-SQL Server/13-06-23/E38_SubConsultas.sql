USE InstitutoTICH
GO

/*1. Obtener el nombre del alumno cuya longitud es la más grande*/

SELECT nombre
FROM Alumnos 
WHERE LEN(nombre) = 
(
	SELECT MAX(LEN(nombre))
	FROM Alumnos
)

/*2. Mostrar el o los alumnos menos jóvenes*/

SELECT * 
FROM Alumnos
WHERE (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12) >= ALL
(
	SELECT (DATEDIFF(MONTH, fechaNacimiento, GETDATE()) / 12)
	FROM Alumnos
)

/*3. Obtener una lista de los alumnos que tuvieron la máxima calificación*/

SELECT A.nombre, A.primerApellido, A.segundoaPellido,  CC.nombre, C.fechaInicio, C.fechaTermino, CA.calificacion
FROM Alumnos A
INNER JOIN CursosAlumnos CA ON CA.idAlumnos = A.id
INNER JOIN Cursos C ON CA.idCurso = C.id
INNER JOIN CatCursos CC ON C.idCatCurso = CC.id
GROUP BY A.nombre, A.primerApellido, A.segundoaPellido,  CC.nombre, C.fechaInicio, C.fechaTermino, CA.calificacion
HAVING CA.calificacion >= ALL 
(
	SELECT calificacion
	FROM CursosAlumnos
)

/*4. Obtener la siguiente consulta con los datos de cada uno de los cursos*/

SELECT CC.nombre AS Nombre, C.fechaInicio, C.fechaTermino, COUNT(C.id) AS Total,
(
	SELECT TOP 1 MAX(CA.calificacion) 
	FROM CursosAlumnos
	WHERE CA.idCurso = C.id
) AS CalMax,
(
	SELECT TOP 1 MIN(CA.calificacion) 
	FROM CursosAlumnos
	WHERE CA.idCurso = C.id
) AS CalMin, AVG (CA.calificacion) AS CalProm
FROM Cursos C
INNER JOIN CatCursos CC ON C.idCatCurso = CC.id
INNER JOIN CursosAlumnos CA ON C.id = CA.idCurso
GROUP BY CC.nombre,  C.fechaInicio, C.fechaTermino, C.id, CA.idCurso

/*Obtener una consulta de los alumnos que tienen una calificación igual o menor 
que el promedio de calificaciones.*/

SELECT A.nombre , CA.calificacion
FROM Alumnos A
INNER JOIN CursosAlumnos CA ON CA.idAlumnos = A.id
WHERE calificacion <= 
(
	SELECT AVG(CA.calificacion)
	FROM CursosAlumnos CA
)

/*6. Obtener una lista de los alumnos que tuvieron la máxima calificación en cada uno 
de los cursos.*/

SELECT A.nombre, A.primerApellido, A.segundoaPellido, (SELECT nombre FROM CatCursos WHERE id = C.idCatCurso) AS Curso, C.fechaInicio, C.fechaTermino, CalMaxCur.Cal
FROM 
(
	SELECT MAX(calificacion) AS Cal, idCurso
	FROM CursosAlumnos
	GROUP BY CursosAlumnos.idCurso
) AS CalMaxCur
INNER JOIN Cursos C ON CalMaxCur.idCurso = C.id
INNER JOIN CursosAlumnos CA ON CA.idCurso = C.id
INNER JOIN Alumnos A ON CA.idAlumnos = A.id
WHERE CA.idCurso = CalMaxCur.idCurso AND CA.calificacion = CalMaxCur.Cal