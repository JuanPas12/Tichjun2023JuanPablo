/*1. Crear una función Suma que reciba dos números enteros y regrese la suma de 
ambos números*/

GO
CREATE FUNCTION Suma (@n1 INT, @n2 INT)
RETURNS INT
AS
BEGIN
	RETURN (@n1 + @n2)
END

GO
PRINT dbo.Suma(5, 9)

/*2. Crear la función GetGenero la cual reciba como parámetros el curp y regrese el 
género al que pertenece*/

GO
CREATE OR ALTER FUNCTION Genero (@curp VARCHAR(18))
RETURNS VARCHAR(10)
AS
BEGIN
	DECLARE @GeneroChar CHAR 
	DECLARE @Gen VARCHAR(10)
	SET @GeneroChar = SUBSTRING(@curp, 11, 1)
	IF (@GeneroChar = 'M')
	BEGIN
		SET @Gen = 'Mujer'
	END
	ELSE
		SET @Gen = 'Hombre'
	RETURN @Gen
END

GO
PRINT dbo.Genero('TABJ000712HMNFNNA0')

/*3. Crear la función GetFechaNacimiento la cual reciba como parámetros el curp y 
regrese la fecha de nacimiento. La fecha de nacimiento deberá completarse a 4 
dígitos, debiéndose determinar si es año dos mil o año mil novecientos
*/

GO
CREATE OR ALTER FUNCTION GetFechaNacimiento (@curp VARCHAR(18))
RETURNS DATE
AS
BEGIN
	RETURN (CONVERT(DATE, SUBSTRING (@curp, 5, 6)))
END

GO
PRINT dbo.GetFechaNacimiento('TABJ000712HMNFNNA0')

/*4. Crear la función GetidEstado la cual reciba como parámetros el curp y regrese el 
Id Estado con base en la siguiente tabla*/

GO
CREATE OR ALTER FUNCTION GetIdEstado (@curp VARCHAR(18))
RETURNS INT
BEGIN
	RETURN (
		SELECT id 
		FROM Estados 
		WHERE curp LIKE SUBSTRING(@curp, 12, 2)
		)
END

GO
PRINT dbo.GetIdEstado ('TABJ000712HMNFNNA0')

/*5. Realizar una función llamada Calculadora que reciba como parámetros dos 
enteros y un operador (+,-,*,/,%) regresando el resultado de la operación se 
deberá cuidar de no hacer división entre cero*/

GO
CREATE OR ALTER FUNCTION Calculadora (@N1 DECIMAL(9,3), @N2 DECIMAL(9,3), @Op VARCHAR(1))
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @Res VARCHAR(100)
	SET @RES = CASE
		WHEN @Op LIKE '+' THEN CONVERT(VARCHAR(100),(@N1 + @N2))
		WHEN @Op LIKE '-' THEN CONVERT(VARCHAR(100),(@N1 - @N2))
		WHEN @Op LIKE '*' THEN CONVERT(VARCHAR(100),(@N1 * @N2))
		WHEN @Op LIKE '/' THEN IIF(@N2 > 0, CONVERT(VARCHAR(100),(@N1 / @N2)), 'No es posible dividir entre 0')
		WHEN @Op LIKE '%' THEN IIF(@N2 > 0, CONVERT(VARCHAR(100),(@N1 % @N2)), 'No es posible dividir entre 0')
		ELSE 'Ingresa Valores Validos'
	END
	RETURN @Res
END

GO
PRINT dbo.Calculadora (5.3, 2.7, '/')

/*6. Realizar una función llamada GetHonorarios que calcule el importe a pagar a un 
determinado instructor y curso, por lo que la función recibirá como parámetro el id 
del instructor y el id del curso*/

GO
CREATE OR ALTER FUNCTION dbo.GetHonorarios (@IDI INT, @IDC INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @CuotaInscructor INT = (SELECT cuotaHora FROM Instructores WHERE id = @IDI)
	DECLARE @HorasCurso INT = (SELECT CC.horas FROM CatCursos CC INNER JOIN Cursos C ON C.idCatCurso = CC.id INNER JOIN CursosInstructores CI ON CI.idCurso = C.id WHERE CI.idCurso = @IDC AND CI.idInstructor = @IDI)
	RETURN (@CuotaInscructor * @HorasCurso)
END

GO
PRINT dbo.GetHonorarios (1, 5)

/*7. Crear la función GetEdad la cual reciba como parámetros la fecha de nacimiento y 
la fecha a la que se requiere realizar el cálculo de la edad. Los años deberán se 
cumplidos, considerando mes y día
*/

GO
CREATE OR ALTER FUNCTION dbo.GetEdad (@FN DATE, @FR DATE)
RETURNS INT
AS
BEGIN
	RETURN ((DATEDIFF(MONTH, @FN, @FR) / 12) + (DATEDIFF(DAY, @FN, @FR) / 365)) / 2
END

GO
PRINT dbo.GetEdad ('1999-12-19', GETDATE())

/*8. Crear la función Factorial la cual reciba como parámetros un número entero y 
regrese como resultado el factorial.*/

GO
CREATE OR ALTER FUNCTION dbo.Factorial (@N INT)
RETURNS INT
AS
BEGIN
	DECLARE @F INT = @N
	WHILE (@N > 1)
	BEGIN
		SET @N = @N - 1
		SET @F = @F * @N
	END
	RETURN @F
END

GO
PRINT dbo.Factorial (10)

/*9. Crear la función ReembolsoQuincenal la cual reciba como parámetros un 
SueldoMensual y regrese como resultado el Importe de Reembolso quincenal, 
considerando que el importe total a reembolsar es igual a dos meses y medio de 
sueldo, y el periodo de reembolso es de 6 meses*/

GO
CREATE OR ALTER FUNCTION dbo.RembolsoMensual (@RM DECIMAL(20, 2))
RETURNS DECIMAL(20, 2)
AS
BEGIN
	DECLARE @Rembolso DECIMAL(20, 2) = (@RM * 2.5)
	RETURN @Rembolso / 12
END

GO
PRINT dbo.RembolsoMensual (20000)

/*10. Realizar una función que calcule el impuesto que debe pagar un instructor para un 
determinado curso. De tal manera que la función recibirá id de un instructor y el id 
del curso correspondiente.
El cálculo del impuesto se realiza de la siguiente forma: 
Determinar el porcentaje que aplicará dependiendo del estado de nacimiento
Chiapas = 5 %
Sonora = 10 %
Veracruz = 7 %
El resto del país 8 %
El impuesto se obtendrá aplicando el porcentaje al total de la cuota por hora por la 
cantidad de horas del curso
El Estado de Origen se obtendrá de la posición 12 y 13 del curp de acuerdo con la 
siguiente tabla*/

GO
CREATE OR ALTER FUNCTION dbo.Impuestos (@IDI INT, @IDC INT)
RETURNS DECIMAL(20,2)
AS
BEGIN
	DECLARE @Honorarios DECIMAL (20,2) = (SELECT dbo.GetHonorarios (@IDI, @IDC))
	DECLARE @EstadoN VARCHAR(2) = (SUBSTRING((SELECT curp FROM Instructores WHERE id = @IDI), 12, 2))
	DECLARE @Impuestos DECIMAL(20, 2)
	SET @Impuestos= CASE 
					@EstadoN
					WHEN 'CS' THEN (@Honorarios / 100) * 5
					WHEN 'SR' THEN (@Honorarios / 100) * 10
					WHEN 'VZ' THEN (@Honorarios / 100) * 7
					ELSE (@Honorarios / 100) * 8
					END
	RETURN @Impuestos
END

GO
PRINT dbo.Impuestos(1, 5)

/*11. Haciendo uso de la función GetEdad, obtener una relación de alumnos con la edad 
a la fecha de inscripción, y la edad actual. De aquellos alumnos que actualmente 
tengan más de 25 años.*/

GO

SELECT CONCAT(A.nombre, ' ', a.primerApellido, ' ', A.segundoaPellido ), dbo.GetEdad(A.fechaNacimiento, GETDATE()) AS EdadActual, dbo.GetEdad(A.fechaNacimiento, (SELECT fechaInscripcion FROM CursosAlumnos WHERE idAlumnos = A.id)) AS EdadFechaIncripcion
FROM Alumnos A
WHERE dbo.GetEdad(A.fechaNacimiento, GETDATE()) > 25
ORDER BY dbo.GetEdad(A.fechaNacimiento, GETDATE())

/*12. Realizar una función que determine el porcentaje a descontar en los reembolsos, 
con base a la cantidad de meses en que se realizará el reembolso y el sueldo 
mensual logrado, de acuerdo al siguiente procedimiento:
a. El porcentaje de descuento será en función de la cantidad de 
mensualidades en que se realizará el reembolso.
b. La cantidad máximo de meses para realizar el reembolso es de 6 meses
c. El porcentaje máximo de descuento a otorgar será el que resulte el sueldo 
mensual entre 1,000
i. Ejemplo : Si el sueldo mensual es de 20,000 pesos el descuento 
será del 20 %
d. El porcentaje máximo de descuento será otorgado si el reembolso total se 
realiza cuando le corresponde efectuar la primera parcialidad de dicho 
reembolso
e. Los porcentaje de descuento a otorgar disminuirá inversamente 
proporcional a la cantidad de meses en que se cubrirá totalmente el 
reembolso, de tal forma que si el reembolso se cubre en la mitad del 
periodo máximo (3 meses = 6 meses /2), el porcentaje a descontar será la 
mitad del porcentaje máximo ( en el ejemplo 10% = 20% / 2), y si el 
reembolso se realiza en el máximo del plazo, el descuento a otorgar será 
cero.*/

GO
CREATE OR ALTER FUNCTION dbo.Descuento (@Meses INT, @SM DECIMAL(20, 2))
RETURNS INT
AS
BEGIN
	DECLARE @PorcentajeB INT = (@SM / 1000)
	RETURN CASE
		WHEN @Meses = 1 THEN @PorcentajeB
		WHEN @Meses = 2 THEN (@PorcentajeB * .75)
		WHEN @Meses = 3 THEN (@PorcentajeB * .50)
		WHEN @Meses = 4 THEN (@PorcentajeB * .25)
		ELSE 0
	END
END

GO
PRINT dbo.Descuento (2, 20000)

/*13. Hacer una función que convierta a mayúsculas la primera letra de cada palabra de 
un cadena de caracteres recibida.*/

GO
CREATE OR ALTER FUNCTION dbo.Jaden (@cadena VARCHAR(255))
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @resultado VARCHAR(255)
    DECLARE @temp VARCHAR(255)
    DECLARE @i INT
    SET @resultado = ''
    SET @temp = UPPER(SUBSTRING(@cadena, 1, 1))
    SET @i = 2 
    WHILE @i <= LEN(@cadena) 
	BEGIN
        IF SUBSTRING(@cadena, @i-1, 1) = ' ' BEGIN
            SET @temp = CONCAT(@temp, UPPER(SUBSTRING(@cadena, @i, 1)))
        END
		ELSE
            SET @temp = CONCAT(@temp, LOWER(SUBSTRING(@cadena, @i, 1))) 
        
        SET @i = @i + 1
    END
    
    SET @resultado = @temp
    RETURN TRIM(@resultado)
END

GO
PRINT dbo.Jaden ('hola mundo mundial del planeta')