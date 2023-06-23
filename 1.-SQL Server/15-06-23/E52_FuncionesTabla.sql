/*Hacer una función valuada en tabla que obtenga la tabla de amortización de los 
Reembolsos quincenales que un participante tiene que realizar en 6 meses*/

GO

CREATE OR ALTER FUNCTION dbo.AmortizacionAlumnos (@IDA INT)
RETURNS @Amort TABLE
(
	Quincena TINYINT IDENTITY (1,1),
	SaldoAnterior DECIMAL(10,2),
	Pago DECIMAL(10,2),
	SaldoNuevo DECIMAL(10,2)
)
AS
BEGIN
	DECLARE @Sueldo DECIMAL(10,2)= (SELECT sueldo FROM Alumnos WHERE id = @IDA) 
	DECLARE @SA DECIMAL (10,2) = (SELECT (sueldo * 2.5) FROM Alumnos WHERE id = @IDA)
	DECLARE @Pago DECIMAL(10,2)= dbo.RembolsoMensual(@Sueldo)
	DECLARE @Q INT = 12
	WHILE @Q >= 1 
	BEGIN
		INSERT INTO @Amort 
			SELECT @SA, @Pago, (@SA - @Pago)
			FROM Alumnos 
			WHERE id = @IDA
	SET @SA = @SA - @Pago
	SET @Q = @Q - 1
	END
	RETURN
END

GO
SELECT * FROM dbo.AmortizacionAlumnos(1)

/*Hacer una función valuada en tabla que obtenga la tabla de amortización de los 
préstamos posibles que se le pueden hacer a un instructor. 
La función recibirá como parámetro el id del instructor 
El importe del préstamo será 200 veces la cuota por hora
El porcentaje de interés será el 24% anual cuando la cuota por hora sea superior a 
200
Para el resto será de 18%
El pago mensual será el equivalente a 25 horas
*/

GO
CREATE OR ALTER FUNCTION dbo.AmortizacionPrestamoInsctructor(@IDI INT)
RETURNS @Amort TABLE (
	Mes TINYINT IDENTITY(1,1),
	[Sueldo Anterior] DECIMAL(10,2),
	Intereses DECIMAL(10,2),
	Pago DECIMAL(10,2),
	[Sueldo Nuevo] DECIMAL(10,2)
)
AS
BEGIN
	DECLARE @Importe DECIMAL(10,2)= (SELECT cuotaHora FROM Instructores WHERE id = @IDI) * 200
	DECLARE @CuotaHora DECIMAL (10,2) = (SELECT cuotaHora FROM Instructores WHERE id = @IDI)
	DECLARE @InteresAnual DECIMAL(9,2) = IIF (@CuotaHora > 200, 24, 18)
	DECLARE @InteresTotal DECIMAL(10,2)
	DECLARE @InteresMes DECIMAL(10,2) = (@InteresAnual / 12)
	DECLARE @Mes TINYINT = 12
	WHILE @Mes > 1
	BEGIN
		IF 0 IN (SELECT [Sueldo Nuevo] FROM @Amort)
		BEGIN
			BREAK
		END
		ELSE
		BEGIN
			SET @InteresTotal = ((@InteresMes * @Importe) / 100)
			INSERT INTO @Amort 
				SELECT @Importe, @InteresTotal, IIF((@Importe + @InteresTotal)  <= (cuotaHora * 25), (@Importe + @InteresTotal), (cuotaHora * 25)), IIF((@Importe + @InteresTotal)  <= (cuotaHora * 25), 0 , (@Importe + @InteresTotal) - (cuotaHora * 25)) 
				FROM Instructores
				WHERE id =  @IDI
			SET @Importe = IIF((@Importe + @InteresTotal)  <= (@CuotaHora * 25), (@Importe - @InteresTotal), ((@Importe + @InteresTotal) - (@CuotaHora * 25)))
			SET @Mes = @Mes - 1
		END
	END
	RETURN
END

GO
SELECT * FROM dbo.AmortizacionPrestamoInsctructor (2)

SELECT cuotaHora from Instructores