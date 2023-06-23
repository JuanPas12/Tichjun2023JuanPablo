USE	InstitutoTICH;

CREATE TABLE estados (
	id INT PRIMARY KEY,
	nombre VARCHAR(100) NULL
);

CREATE TABLE EstatusAlumnos (
	id SMALLINT PRIMARY KEY,
	clave CHAR(10) NOT NULL,
	nombre VARCHAR(100) NOT NULL
);

CREATE TABLE CatCursos (
	id SMALLINT PRIMARY KEY IDENTITY(1,1),
	clave VARCHAR(15),
	nombre VARCHAR(50),
	descripcion VARCHAR(1000) NULL,
	horas TINYINT,
	idPreRequisito SMALLINT NULL,
	activo BIT
	FOREIGN KEY (idPreRequisito) REFERENCES CatCursos (id)
);

CREATE TABLE Cursos (
	id SMALLINT PRIMARY KEY IDENTITY(1,1),
	idCatCurso SMALLINT NULL,
	fechaInicio DATE NULL,
	fechaTermino DATE NULL,
	activo BIT NULL,
	CONSTRAINT fk_CatCurso FOREIGN KEY (idCatCurso) REFERENCES CatCursos (id)
);

CREATE TABLE Alumnos (
	id INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(60),
	primerApellido VARCHAR(50),
	segundoaPellido VARCHAR(50) NULL,
	correo VARCHAR(80),
	telefono NCHAR(10),
	fechaNacimiento DATE,
	curp CHAR(18),
	sueldo DECIMAL(9,2) NULL,
	idEstadoOrigen INT,
	idEstatus SMALLINT,
	CONSTRAINT fk_EstadoOrigen FOREIGN KEY (idEstadoOrigen) REFERENCES Estados (id),
	CONSTRAINT fk_Estatus FOREIGN KEY (idEstatus) REFERENCES EstatusAlumnos (id)
);

CREATE TABLE Instructores (
	id SMALLINT PRIMARY KEY IDENTITY,
	nombre VARCHAR(60),
	primerApellido VARCHAR(50),
	segundoAplellido VARCHAR(50) NULL,
	correo VARCHAR(80),
	telefono NCHAR(10),
	fechaNacimiento DATE,
	rfc CHAR(13),
	curp CHAR(18),
	cuotaHora DECIMAL(9,2),
	activo BIT
);

CREATE TABLE CursosAlumnos(
	id INT PRIMARY KEY IDENTITY,
	idCurso SMALLINT,
	idAlumnos INT,
	fechaInscripcion DATE,
	fechaBaja DATE NULL,
	calificacion TINYINT NULL,
	CONSTRAINT fk_Cursos FOREIGN KEY (idCurso) REFERENCES Cursos (id),
	CONSTRAINT fk_Alumnos FOREIGN KEY (idAlumnos) REFERENCES Alumnos (id)
);

ALTER TABLE CursosInstructores ADD FOREIGN KEY (idCurso) REFERENCES Cursos (id);
ALTER TABLE CursosInstructores ALTER COLUMN idInstructor SMALLINT
GO
ALTER TABLE CursosInstructores ADD FOREIGN KEY (idInstructor) REFERENCES Instructores (id);

CREATE TABLE TablaISR (
	id INT PRIMARY KEY IDENTITY (1,1),
	LimInf Decimal(19, 2),
	LimSup Decimal(19, 2),
	CuotaFija Decimal(19, 2),
	ExedLimInf Decimal(19, 2),
	Subsidio Decimal(19, 2)
);