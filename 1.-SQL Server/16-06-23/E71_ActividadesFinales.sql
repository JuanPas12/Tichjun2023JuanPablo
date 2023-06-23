-- 1. Realizar una vista vAlumnos que obtenga el siguiente resultado

GO

CREATE OR ALTER VIEW vAlumnos
AS
SELECT A.id, A.nombre, A.primerApellido, A.segundoaPellido, A.correo, A.telefono, A.curp, E.nombre AS Estado, EA.nombre AS Estatus
FROM Alumnos A
INNER JOIN Estados E ON A.idEstadoOrigen = E.id
INNER JOIN EstatusAlumnos EA ON A.idEstatus = EA.id

GO
SELECT *
FROM vAlumnos

/*2. Realizar el procedimiento almacenado consultarEstados el cual obtendrá la 
siguiente consulta, recibiendo como parámetro el id del registro que se 
requiere consultar de la tabla Estados. En caso de que el valor sea -1 (menos 
uno) deberá regresar todos los registros de dicha tabla.
*/

GO

CREATE OR ALTER PROC sp_consultarEstados
(
	@IDE INT
)
AS
BEGIN
		SELECT * FROM Estados WHERE id = @IDE OR @IDE <= 0
END

GO
EXEC sp_consultarEstados -1

/*3. Realizar el procedimiento almacenado consultarEstatusAlumnos el cual 
obtendrá la siguiente consulta, recibiendo como parámetro el id del registro 
que se requiere consultar de la tabla estatusAlumnos. En caso de que el valor 
sea -1 (menos uno) deberá regresar todos los registros de dicha tabla.
*/

GO

CREATE OR ALTER PROC sp_consultarEstatusAlumnos
(
	@IDEA INT
)
AS
BEGIN
	IF @IDEA = -1
	BEGIN
		SELECT * FROM EstatusAlumnos
	END
	ELSE
	BEGIN
		SELECT * FROM EstatusAlumnos WHERE id = @IDEA
	END
END

GO
EXEC sp_consultarEstatusAlumnos -1

/*4. Realizar el procedimiento almacenado consultarAlumnos el cual obtendrá la 
siguiente consulta, recibiendo como parámetro el id del registro que se 
requiere consultar de la tabla Alumnos. En caso de que el valor sea -1 (menos 
uno) deberá regresar todos los registros de dicha tabla.*/

GO


CREATE OR ALTER PROC sp_consultarAlumnos
(
	@IDA INT
)
AS
BEGIN
	IF @IDA = -1
	BEGIN
		SELECT * FROM vAlumnos
	END
	ELSE
	BEGIN
		SELECT * FROM vAlumnos WHERE id = @IDA
	END
END

GO
EXEC sp_consultarAlumnos -1

/*5. Realizar el procedimiento almacenado consultarEAlumnos el cual obtendrá la 
siguiente consulta, recibiendo como parámetro el id del registro que se 
requiere consultar de la tabla Alumnos. En caso de que el valor sea -1 (menos 
uno) deberá regresar todos los registros de dicha tabla.
*/

GO
CREATE OR ALTER PROC sp_ConsultarEAlumnos
(
	@IDA INT
)
AS
BEGIN
	IF @IDA = -1
	BEGIN
		SELECT nombre, primerApellido, segundoaPellido, fechaNacimiento, correo, telefono, curp, idEstadoOrigen, idEstatus FROM Alumnos
	END
	ELSE
	BEGIN
		SELECT nombre, primerApellido, segundoaPellido, fechaNacimiento, correo, telefono, curp, idEstadoOrigen, idEstatus FROM Alumnos WHERE id = @IDA
	END
END

GO
EXEC sp_ConsultarEAlumnos 3

/*6. Realizar el procedimiento almacenado actualizarEstatusAlumnos el cual 
recibirá como parámetros el id del Alumno al cual se le requiere cambiar el 
estatus y el valor del nuevo estatus.*/

GO

CREATE OR ALTER PROC sp_ActualizarEstatusAlumnos
(
	@IDA INT,
	@ValorEstatus INT
)
AS
BEGIN
	IF @IDA IN (SELECT id FROM Alumnos) AND @ValorEstatus IN (SELECT id FROM EstatusAlumnos) 
	BEGIN
		UPDATE Alumnos SET idEstatus = @ValorEstatus WHERE id = @IDA
		SELECT  nombre, primerApellido, idEstatus
		FROM Alumnos
		WHERE id = @IDA
	END
	ELSE
	BEGIN
		PRINT 'Valores invalidos'
	END
END

GO
EXEC sp_ActualizarEstatusAlumnos 1, 5

/*7. Realizar el procedimiento almacenado agregarAlumnos el cual recibirá como 
parámetros los valores de cada una de las columnas de la tabla de Alumnos 
con los cuales se insertará el registro a la tabla Alumnos. El procedimiento 
deberá regresar el id con el que se creo el registro en formato de entero.*/

GO

CREATE OR ALTER PROC sp_agregarAlumnos 
(
	@Nombre VARCHAR(30),
	@AP VARCHAR(30),
	@AM VARCHAR(30),
	@Correo VARCHAR(50),
	@Telefono VARCHAR(10),
	@FN DATE,
	@CURP VARCHAR(18),
	@Sueldo DECIMAL(15,2),
	@IEO TINYINT,
	@IE TINYINT
)
AS
BEGIN
	DECLARE @IDA INT
	INSERT INTO Alumnos VALUES (@Nombre, @AP, @AM, @Correo, @Telefono, @FN, @CURP, @Sueldo, @IEO, @IE)
	SET @IDA = SCOPE_IDENTITY()
	PRINT CONCAT('Tu ID es: ', @IDA)
END

GO
EXEC sp_agregarAlumnos 'Jose Eduardo', 'Martinez', 'Chavez', 'lalochz@gmail.com', '3511963752', '1996-08-30', 'MACJ960830HGRRHS011', 45012, 13, 4
SELECT * FROM Alumnos

/*8. Realizar el procedimiento almacenado actualizarAlumnos el cual recibirá 
como parámetros los valores de cada una de las columnas de la tabla de
Alumnos con los cuales se actualizarán los valores que existen en la tabla 
Alumnos del registro que corresponda al id enviado como parámetro. El 
procedimiento deberá regresar la cantidad de registros actualizados.*/

GO

CREATE OR ALTER PROC sp_actualizarAlumno
(
	@ID INT,
	@Nombre VARCHAR(30),
	@AP VARCHAR(30),
	@AM VARCHAR(30),
	@Correo VARCHAR(50),
	@Telefono VARCHAR(10),
	@FN DATE,
	@CURP VARCHAR(18),
	@Sueldo DECIMAL(15,2),
	@IEO TINYINT,
	@IE TINYINT
)
AS
BEGIN
	DECLARE @cont INT = 0
	IF @Nombre NOT LIKE (SELECT nombre FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET nombre = @Nombre
	WHERE id = @ID
	SET @cont = @cont + 1
	END
	IF @AP NOT LIKE (SELECT primerApellido FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET primerApellido = @AP
	WHERE id = @ID
	SET @cont = @cont + 1
	END
	IF @AM NOT LIKE (SELECT segundoaPellido FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET segundoaPellido = @AM
	WHERE id = @ID
	SET @cont = @cont + 1
	END
	IF @Correo NOT LIKE (SELECT correo FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET correo = @Correo
	WHERE id = @ID
	SET @cont = @cont + 1
	END
	IF @Telefono NOT LIKE (SELECT telefono FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET telefono = @Telefono
	WHERE id = @ID
	SET @cont = @cont + 1
	END
	IF @FN NOT LIKE (SELECT fechaNacimiento FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET fechaNacimiento = @FN
	WHERE id = @ID
	SET @cont = @cont + 1
	END
	IF @CURP NOT LIKE (SELECT curp FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET curp = @CURP
	WHERE id = @ID
	SET @cont = @cont + 1
	END
	IF @Sueldo NOT LIKE (SELECT sueldo FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET sueldo = @Sueldo
	WHERE id = @ID
	SET @cont = @cont + 1
	END
	IF @IEO NOT LIKE (SELECT idEstadoOrigen FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET idEstadoOrigen = @IEO
	WHERE id = @ID
	SET @cont = @cont + 1
	END
	IF @IE NOT LIKE (SELECT idEstatus FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET idEstatus = @IE
	WHERE id = @ID
	SET @cont = @cont + 1
	END

	PRINT CONCAT('Registros Actualizados: ', @cont)
END

GO
EXEC sp_actualizarAlumno 1019, 'Jose', 'Martinez', 'Chavez', 'lalochz@gmail.com', '3511963752', '1996-08-30', 'MACJ960830HGRRHS011', 45012, 13, 4

/*9. Realizar el procedimiento almacenado eliminarAlumnos el cual recibirá como 
parámetros el valor del id del registro del alumno del que se requiere eliminar.
Primeramente se deberán eliminar todos los registros de la Tabla de 
CursosAlumnos los cuales tengan el id del alumno a eliminar y posteriormente 
el eliminar al alumno de la Tabla de Alumnos.
Esto deberá considerarse como una transacción ya que se trate de actualizar 
dos tablas relacionadas.
En caso de que no se haya eliminado el registro de la tabla de Alumnos 
deberá levantar una excepción.*/

GO
CREATE OR ALTER PROC sp_eliminarAlumno (@ID INT)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF @ID IN (SELECT id FROM Alumnos)
			BEGIN
				DELETE CursosAlumnos WHERE idAlumnos = @ID
				DELETE Alumnos WHERE id = @ID
			END
			ELSE
			BEGIN;
				THROW 51000, 'Error al realizar la peticiona', 1
			END
		COMMIT TRANSACTION
			PRINT CONCAT('Se elimino el alumnos con el id: ', @ID, ' de manera satisfactoria')
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
			PRINT 'Ha habido un error al momento de ejecutar la peticion se ha hecho un ROLLBACK';
			
	END CATCH
END

GO
EXEC sp_eliminarAlumno 1
SELECT * FROM Alumnos

/*10. Crear el trigger Trigger_EliminarAlumnos el cual se debe ejecutar cuando se 
elimina un registro de la tabla de Alumnos. Este trigger deberá insertar un 
registro en la Tabla AlumnosBaja del alumno eliminado.*/

GO
CREATE OR ALTER TRIGGER Trigger_EliminarAlumnos
ON Alumnos
AFTER DELETE
AS
SET NOCOUNT ON
BEGIN
	INSERT INTO AlumnosBaja (nombre, primerApellido, segundoApellido, fechaBaja)
	SELECT D.nombre, D.primerApellido, D.segundoaPellido, GETDATE()
	FROM deleted D
END

EXEC sp_eliminarAlumno 28

SELECT * FROM AlumnosBaja

-- 11. Obtener un respaldo de su base de datos InstitutoTich

GO
BACKUP DATABASE InstitutoTich
TO DISK = 'E:\TICH\16-06-23\InstitutoTich.bak'
WITH FORMAT, COMPRESSION, 
				MEDIANAME = 'SQLServerBackups',
				NAME = 'Respaldo completo de InstitutoTich'

/*12. Crear una base de datos PruebasTich con el respaldo de la base de datos 
InstitutoTich.*/

GO
CREATE DATABASE PruebasTich

RESTORE FILELISTONLY
FROM DISK = 'E:\TICH\16-06-23\InstitutoTich.bak';

RESTORE DATABASE PruebasTich
FROM DISK = 'E:\TICH\16-06-23\InstitutoTich.bak'
WITH REPLACE,
MOVE 'InstitutoTICH' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\PruebasTich.mdf',
MOVE 'InstitutoTICH_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\\PruebasTich.ldf';


/*Sobre la base de datos PruebasTich crear el store Procedure 
spEliminaAlumnosCurso el cual deberá eliminar los alumnos que se 
encuentren en un determinado curso por lo que recibirá como parámetro el 
nombre del curso.*/

USE PruebasTich

GO
CREATE OR ALTER PROC sp_EliminarAlumnosCurso
(
	@NombreC VARCHAR(50) 
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF @NombreC IN (SELECT CC.nombre FROM CursosAlumnos CA
								INNER JOIN Cursos C ON CA.idCurso = C.id
								INNER JOIN CatCursos CC ON C.idCatCurso = CC.id)
			BEGIN
				DELETE Alumnos WHERE id IN (SELECT CA.idAlumnos FROM CursosAlumnos CA
								INNER JOIN Cursos C ON CA.idCurso = C.id
								INNER JOIN CatCursos CC ON C.idCatCurso = CC.id
								WHERE CC.nombre LIKE @NombreC)
		
		END
		ELSE
		BEGIN;
			THROW 51000, 'Error al realizar la peticiona', 1		
		END
		COMMIT TRANSACTION
			PRINT CONCAT('Eliminacion de los alumnos: ', @NombreC)
	END TRY
	BEGIN CATCH
		PRINT 'No se pudo realizar la operacion'
	END CATCH
END

GO
EXEC sp_EliminarAlumnosCurso 'Matematicas I+'

-- 14. Obtener los scripts de la base de datos InstitutoTich

-- 15. Obtener el script de la spEliminaAlumnosCurso