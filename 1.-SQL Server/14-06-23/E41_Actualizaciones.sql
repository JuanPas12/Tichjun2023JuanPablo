--1. Actualizar el estatus del Alumnos de los que están en propedéutico a capacitación

/*SELECT CONCAT(nombre, ' ', primerApellido, ' ', segundoaPellido), (idEstatus + 1)
FROM Alumnos
WHERE idEstatus = 3*/

UPDATE Alumnos 
SET idEstatus = 4
WHERE idEstatus = 3

SELECT * 
FROM Alumnos
WHERE idEstatus = 4

--2. Actualizar el segundo apellido del Alumno a Mayúsculas

/*SELECT nombre, primerApellido, UPPER(segundoaPellido)
FROM Alumnos*/

UPDATE Alumnos
SET segundoaPellido = UPPER (segundoaPellido)

SELECT * FROM Alumnos

/*3. Actualizar el segundo Apellido para que la primera letra sea mayúsculas y el resto 
minúsculas*/

/*SELECT nombre, primerApellido, STUFF(LOWER(segundoaPellido), 1, 1, UPPER(LEFT(segundoaPellido, 1)))
FROM Alumnos*/

UPDATE Alumnos
SET segundoaPellido = STUFF(LOWER(segundoaPellido), 1, 1, UPPER(LEFT(segundoaPellido, 1)))

SELECT * FROM Alumnos

/*4. Actualizar el número telefónico de los instructores para que los dos primeros 
dígitos sean 55, en caso de que de acuerdo al curp sean del DF*/

/*SELECT nombre, telefono, STUFF(telefono, 1, 2, '55')
FROM Instructores*/

UPDATE Instructores 
SET telefono = STUFF(telefono, 1, 2, '55')

SELECT * FROM Instructores

/*5. Subirles un punto en la calificación a los alumnos de Hidalgo y Oaxaca, y del 
Curso impartido en junio de 2021. Se deberá considerar que al incrementar el 
punto no exceda del máximo de la calificación permitida*/

SELECT * FROM Estados
SELECT * FROM Alumnos WHERE idEstadoOrigen = 12 OR idEstadoOrigen = 19

/*SELECT A.nombre, CA.calificacion, (CA.calificacion + 1) AS NuevaCal
FROM Alumnos A
INNER JOIN CursosAlumnos CA ON CA.idAlumnos = A.id
INNER JOIN Cursos C ON CA.idCurso = C.id
WHERE A.idEstadoOrigen IN (12, 19) AND CA.calificacion < 10 AND (DATEPART(MONTH, C.fechaInicio) = 6 AND DATEPART(YEAR,C.fechaInicio) = 2021)*/

UPDATE CA
SET CA.calificacion = (CA.calificacion + 1)
FROM CursosAlumnos CA
INNER JOIN Alumnos A ON CA.idAlumnos = A.id
INNER JOIN Cursos C ON CA.idCurso = C.id
WHERE A.idEstadoOrigen IN (12, 19) AND CA.calificacion <10 AND (DATEPART(MONTH, C.fechaInicio) = 6 AND DATEPART(YEAR,C.fechaInicio) = 2021)

/*6. Subirle el 10% de la cuota por hora a los profesores que han impartido el curso de 
Matematicas I*/

/*SELECT I.nombre, I.cuotaHora, (I.cuotaHora + ((I.cuotaHora / 100) * 10)) AS NuevaCuota
FROM Instructores I
INNER JOIN CursosInstructores CI ON CI.idInstructor = I.id 
WHERE CI.idCurso = 1*/

UPDATE I
SET I.cuotaHora = I.cuotaHora + ((I.cuotaHora / 100) * 10)
FROM Instructores I
INNER JOIN CursosInstructores CI ON CI.idInstructor = I.id
WHERE CI.idCurso = 1

SELECT * FROM Instructores


/*7. En la Base de Datos Ejercicios realice lo siguiente:
	a. Copiar la Tabla de Alumnos de la Base de Datos InstitutoTich a la Tabla 
AlumnosTodos
	b. Copiar a los alumnos de Hidalgo de la Tabla de Alumnos de la Base de 
Datos InstitutoTich a la Tabla AlumnosHgo
	c. En la Tabla AlumnosHgo cambiarles el número telefónico inicie con 77, 
mediante la instrucción update
	d. Actualizar el teléfono de la tabla AlumnosTodos obtenidos desde la taba 
AlumnosHgo*/

-- a. 

SELECT *
INTO  EjerciciosTich.dbo.AlumnosTodos
FROM Alumnos

--b.

SELECT *
INTO EjerciciosTich.dbo.AlumnosHgo
FROM Alumnos
WHERE idEstadoOrigen = 12

-- c.

/*SELECT AH.nombre, AH.telefono, STUFF(AH.telefono, 1, 2, '77') AS NTel
FROM EjerciciosTich.dbo.AlumnosHgo AH*/

UPDATE AH
SET AH.telefono = STUFF(AH.telefono, 1, 2, '77')
FROM EjerciciosTich.dbo.AlumnosHgo AH

SELECT * FROM EjerciciosTich.dbo.AlumnosHgo 

-- d.

/*SELECT ATo.nombre, ATo.telefono, (AH.telefono) AS TelH
FROM EjerciciosTich.dbo.AlumnosTodos ATo
INNER JOIN EjerciciosTich.dbo.AlumnosHgo AH ON ATo.id = AH.id
WHERE ATo.idEstadoOrigen = 12*/

UPDATE ATo
SET ATo.telefono = AH.telefono
FROM EjerciciosTich.dbo.AlumnosTodos ATo
INNER JOIN EjerciciosTich.dbo.AlumnosHgo AH ON ATo.id = AH.id
WHERE ATo.idEstadoOrigen = AH.idEstadoOrigen

SELECT * FROM EjerciciosTich.dbo.AlumnosTodos WHERE idEstadoOrigen = 12