/*1. Crear una funci�n Suma que reciba dos n�meros enteros y regrese la suma de 
ambos n�meros*/

GO
CREATE FUNCTION Suma (@n1 INT, @n2 INT)
RETURNS INT
AS
BEGIN
	RETURN (@n1 + @n2)
END

GO
PRINT dbo.Suma(5, 9)

/*2. Crear la funci�n GetGenero la cual reciba como par�metros el curp y regrese el 
g�nero al que pertenece*/

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

/*3. Crear la funci�n GetFechaNacimiento la cual reciba como par�metros el curp y 
regrese la fecha de nacimiento. La fecha de nacimiento deber� completarse a 4 
d�gitos, debi�ndose determinar si es a�o dos mil o a�o mil novecientos
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

/*4. Crear la funci�n GetidEstado la cual reciba como par�metros el curp y regrese el 
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

/*5. Realizar una funci�n llamada Calculadora que reciba como par�metros dos 
enteros y un operador (+,-,*,/,%) regresando el resultado de la operaci�n se 
deber� cuidar de no hacer divisi�n entre cero*/

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

/*6. Realizar una funci�n llamada GetHonorarios que calcule el importe a pagar a un 
determinado instructor y curso, por lo que la funci�n recibir� como par�metro el id 
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

/*7. Crear la funci�n GetEdad la cual reciba como par�metros la fecha de nacimiento y 
la fecha a la que se requiere realizar el c�lculo de la edad. Los a�os deber�n se 
cumplidos, considerando mes y d�a
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

/*8. Crear la funci�n Factorial la cual reciba como par�metros un n�mero entero y 
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

/*9. Crear la funci�n ReembolsoQuincenal la cual reciba como par�metros un 
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

/*10. Realizar una funci�n que calcule el impuesto que debe pagar un instructor para un 
determinado curso. De tal manera que la funci�n recibir� id de un instructor y el id 
del curso correspondiente.
El c�lculo del impuesto se realiza de la siguiente forma: 
Determinar el porcentaje que aplicar� dependiendo del estado de nacimiento
Chiapas = 5 %
Sonora = 10 %
Veracruz = 7 %
El resto del pa�s 8 %
El impuesto se obtendr� aplicando el porcentaje al total de la cuota por hora por la 
cantidad de horas del curso
El Estado de Origen se obtendr� de la posici�n 12 y 13 del curp de acuerdo con la 
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

/*11. Haciendo uso de la funci�n GetEdad, obtener una relaci�n de alumnos con la edad 
a la fecha de inscripci�n, y la edad actual. De aquellos alumnos que actualmente 
tengan m�s de 25 a�os.*/

GO

SELECT CONCAT(A.nombre, ' ', a.primerApellido, ' ', A.segundoaPellido ), dbo.GetEdad(A.fechaNacimiento, GETDATE()) AS EdadActual, dbo.GetEdad(A.fechaNacimiento, (SELECT fechaInscripcion FROM CursosAlumnos WHERE idAlumnos = A.id)) AS EdadFechaIncripcion
FROM Alumnos A
WHERE dbo.GetEdad(A.fechaNacimiento, GETDATE()) > 25
ORDER BY dbo.GetEdad(A.fechaNacimiento, GETDATE())

/*12. Realizar una funci�n que determine el porcentaje a descontar en los reembolsos, 
con base a la cantidad de meses en que se realizar� el reembolso y el sueldo 
mensual logrado, de acuerdo al siguiente procedimiento:
a. El porcentaje de descuento ser� en funci�n de la cantidad de 
mensualidades en que se realizar� el reembolso.
b. La cantidad m�ximo de meses para realizar el reembolso es de 6 meses
c. El porcentaje m�ximo de descuento a otorgar ser� el que resulte el sueldo 
mensual entre 1,000
i. Ejemplo : Si el sueldo mensual es de 20,000 pesos el descuento 
ser� del 20 %
d. El porcentaje m�ximo de descuento ser� otorgado si el reembolso total se 
realiza cuando le corresponde efectuar la primera parcialidad de dicho 
reembolso
e. Los porcentaje de descuento a otorgar disminuir� inversamente 
proporcional a la cantidad de meses en que se cubrir� totalmente el 
reembolso, de tal forma que si el reembolso se cubre en la mitad del 
periodo m�ximo (3 meses = 6 meses /2), el porcentaje a descontar ser� la 
mitad del porcentaje m�ximo ( en el ejemplo 10% = 20% / 2), y si el 
reembolso se realiza en el m�ximo del plazo, el descuento a otorgar ser� 
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

/*13. Hacer una funci�n que convierta a may�sculas la primera letra de cada palabra de 
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