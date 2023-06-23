USE InstitutoTICH

SELECT primerApellido AS [Apelliudo Paterno], segundoaPellido AS [Apellido Materno], nombre, telefono, correo FROM Alumnos;

SELECT nombre, primerApellido AS [Apellido Paterno], segundoApellido AS [Apellido Materno], rfc, cuotaHora AS [Cuota por hora] FROM Instructores

SELECT clave, nombre, descripcion, horas FROM CatCursos

SELECT TOP 5 * FROM Alumnos ORDER BY fechaNacimiento DESC

CREATE DATABASE Ejercicios

SELECT * INTO EjerciciosTich.dbo.AlumnosCopia FROM Alumnos
SELECT * INTO EjerciciosTich.dbo.InstructoresCopia FROM Instructores

USE EjerciciosTich

SELECT * FROM AlumnosCopia
SELECT * FROM InstructoresCopia