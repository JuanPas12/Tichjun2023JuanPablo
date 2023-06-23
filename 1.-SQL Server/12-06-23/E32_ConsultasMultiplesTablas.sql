USE InstitutoTICH

SELECT nombre, primerApellido as [Apellido Paterno], segundoApellido AS [Apellido Materno], rfc, cuotaHora AS [Cuota por Hora], IIF (activo = 1, 'Activo', 'Inactivo') AS [Estatus]
FROM Instructores 

SELECT catCur.nombre AS Curso, catCur.horas AS [Horas], fechaInicio, fechaTermino
FROM Cursos cur INNER JOIN CatCursos catCur
ON cur.idCatCurso = catCur.id
WHERE horas = 1

SELECT Alm.nombre, primerApellido, segundoApellido, curp, Est.nombre AS [Estado], Sta.nombre AS [Estatus]
FROM Alumnos Alm 
INNER JOIN Estados Est ON Alm.idEstadoOrigen = Est.id
INNER JOIN EstatusAlumnos Sta ON Alm.idEstatus = Sta.id

SELECT CONCAT (Ins.nombre,' ', Ins.primerApellido, ' ',Ins.segundoApellido) AS [Instructor], Ins.cuotaHora, cc.nombre, Cur.fechaInicio, Cur.fechaTermino
FROM CursosInstructores CI
INNER JOIN Instructores Ins ON CI.idInstructor = Ins.id
INNER JOIN Cursos Cur ON CI.idCurso = Cur.id
INNER JOIN CatCursos CC ON Cur.id = CC.id

SELECT A.nombre, A.primerApellido, A.segundoApellido, E.nombre AS [Estado], CC.nombre AS [Curso], C.fechaInicio, C.fechaTermino
FROM CursosAlumnos CA
INNER JOIN Alumnos A ON CA.idAlumnos = A.id
INNER JOIN Estados E ON A.idEstadoOrigen = E.id
INNER JOIN Cursos C ON CA.idCurso = C.id
INNER JOIN CatCursos CC ON C.idCatCurso = CC.id

SELECT CONCAT (A.nombre,' ', A.primerApellido, ' ', A.segundoaPellido) AS Nombre, CC.nombre AS [Curso], C.fechaInicio, C.fechaTermino, CA.calificacion
FROM CursosAlumnos CA
INNER JOIN Alumnos A ON CA.idAlumnos = A.id
INNER JOIN Cursos C ON CA.idCurso = C.id
INNER JOIN CatCursos CC ON C.idCatCurso = CC.id
ORDER BY CA.calificacion DESC

SELECT CC.clave, CC.nombre AS [Curso], horas, IIF (CC.idPreRequisito > 0, CC.nombre, 'Sin Prerequisitos')
FROM Cursos C
INNER JOIN CatCursos CC ON C.idCatCurso = CC.id

SELECT A.nombre, A.primerApellido, A.segundoaPellido, CC.nombre, C.fechaInicio, C.fechaTermino, CA.calificacion, 
CASE
	WHEN calificacion BETWEEN 9 AND 10 THEN 'Excelente'
	WHEN calificacion BETWEEN 7 AND 8 THEN 'Bien'
	WHEN calificacion = 6 THEN 'Suficiente'
	ELSE 'N/A'
END AS Nivel
FROM CursosAlumnos CA
INNER JOIN Alumnos A ON CA.idAlumnos = A.id
INNER JOIN Cursos C ON CA.idCurso = C.id
INNER JOIN CatCursos CC ON C.idCatCurso = CC.id