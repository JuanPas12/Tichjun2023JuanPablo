CREATE DATABASE EjerciciosTich;
GO

USE EjerciciosTich;

CREATE TABLE CursosInstructores (
	id INT PRIMARY KEY IDENTITY (1,1),
	idCurso SMALLINT,
	idInstructor INT,
	fechaContratacion DATE NULL
);

CREATE TABLE AlumnosBaja (
	id INT PRIMARY KEY IDENTITY (1,1),
	nombre VARCHAR(50),
	primerApelliudo VARCHAR(50),
	segundoApellido VARCHAR(50) NULL,
	fechaBaja DATETIME
);