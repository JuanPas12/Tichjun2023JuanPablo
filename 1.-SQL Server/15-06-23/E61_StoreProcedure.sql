/*1. Crear un store procedur eCodigoAscii que imprima los caracteres con su respectivo 
código ascii en decimal. Solo para los caracteres cuyo código sea mayor a 32*/

GO
CREATE OR ALTER PROC sp_CodigoAcii 
AS
BEGIN
	DECLARE @C INT= 32
	WHILE @C <= 255
	BEGIN
		PRINT CONCAT(CHAR(@C), ' ASCII=> ', @C)
		SET @C = @C + 1
	END
END

GO
EXEC sp_CodigoAcii

/*2. Crear el store procedure Factorial que reciba como parámetro un número entero y 
que devuelve el factorial calculado en un parámetro de salida*/

GO
CREATE OR ALTER PROC sp_Factorial 
(
	@Num INT OUTPUT
)
AS
BEGIN
	DECLARE @Temp INT = @Num -1
	WHILE @Temp > 0
	BEGIN
		SET @Num = @Num * @Temp
		SET @Temp = @Temp - 1
	END
	PRINT @Num
END

GO
EXEC sp_Factorial 10

-- 3. Crear las siguientes Tablas

GO
CREATE TABLE saldos 
(
	id INT PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR(30) NOT NULL, 
	saldo DECIMAL(10, 2) NOT NULL
)

GO
CREATE TABLE Transacciones
(
	id INT PRIMARY KEY IDENTITY(1,1),
	idOrigen INT NOT NULL,
	idDestino INT NOT NULL,
	monto DECIMAL(9,2) NOT NULL
	CONSTRAINT fk_idOrigen FOREIGN KEY (idOrigen) REFERENCES dbo.saldos (id),
	CONSTRAINT fk_idDestino FOREIGN KEY (idDestino) REFERENCES dbo.saldos (id)
)

INSERT INTO saldos VALUES ('Juan Pablo', 10000)

/*4. Crear un store procedure “Transacciones” que recibirá como parámetros el id de la 
cuenta de origen, el id de la cuenta destino y el monto de la transacción. Se 
deberá crear dentro de una transacción a fin de que los saldos de las cuentas 
involucradas y la tabla de transacciones quede perfectamente consistente.*/

GO
CREATE OR ALTER PROC sp_Transacciones
(
	@idOrigen INT,
	@idDestino INT,
	@Monto DECIMAL(9,2)
)
AS
BEGIN
	DECLARE @SaldoCuentaOrigen DECIMAL(20,2) = (SELECT saldo FROM saldos WHERE id = @idOrigen)
		BEGIN
		BEGIN TRY 
				BEGIN TRANSACTION
				IF (@Monto <= @SaldoCuentaOrigen)
				BEGIN
					UPDATE saldos SET saldo = saldo + @Monto WHERE id = @idDestino
					UPDATE saldos SET saldo = saldo - @Monto WHERE id = @idOrigen
					INSERT INTO Transacciones VALUES (@idOrigen, @idDestino, @Monto)
					SELECT * FROM saldos WHERE id = @idOrigen OR id = @idDestino
				COMMIT TRANSACTION
				PRINT 'Transaccion completada satisfactoriamente'
				END
				ELSE
				BEGIN
					ROLLBACK TRANSACTION
					PRINT 'No hay saldo suficiente en la cuenta de origen'
				END
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION 
			PRINT 'Ha habido un error en la transaccion, sea a realizado un Rollback';
			THROW 51000, 'Error al realizar la transferencia', 1
		END CATCH
	END
END

GO
EXEC sp_Transacciones 10, 1, 100

SELECT * FROM Transacciones