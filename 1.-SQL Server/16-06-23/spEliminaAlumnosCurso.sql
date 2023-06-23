USE [PruebasTich]
GO
/****** Object:  StoredProcedure [dbo].[sp_EliminarAlumnosCurso]    Script Date: 16/06/2023 12:08:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_EliminarAlumnosCurso]
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
