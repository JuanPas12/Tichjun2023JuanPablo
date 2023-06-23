USE InstitutoTICH;
GO

/*1. Realizar la siguiente Consulta con el nombre y apellidos en 
Mayúsculas*/

SELECT id, UPPER(nombre), UPPER(primerApellido), UPPER(segundoaPellido), 
fechaNacimiento, GETDATE() AS Hoy, (DATEDIFF(MONTH ,fechaNacimiento, GETDATE()) / 12) AS Edad, 
(DATEDIFF(MONTH, fechaNacimiento, DATEADD(MONTH, 5, GETDATE())) / 12) AS Edad5Meses
FROM Alumnos;

/*2. Realizar la consulta Anterior agregando columna con la fecha de 
nacimiento extraída del CURP*/

SELECT id, UPPER(nombre), UPPER(primerApellido), UPPER(segundoaPellido), 
fechaNacimiento, curp, CONVERT(DATE, SUBSTRING(curp, 5,6))  AS FechaCurp
FROM Alumnos;

/*3. Realizar una consulta con los datos del alumnos y una columna 
adicional indicando el género con la palabra ‘Hombre’ o ‘Mujer’ según 
corresponda de acuerdo con lo indicado en la columna 11 del curp*/

SELECT id, UPPER(nombre), UPPER(primerApellido), UPPER(segundoaPellido), 
fechaNacimiento, curp, CONVERT(DATE, SUBSTRING(curp, 5,6))  AS FechaCurp, 
CASE
	WHEN SUBSTRING(curp, 11, 1) = 'M' THEN 'Mujer'
	WHEN SUBSTRING(curp, 11, 1) = 'H' THEN 'Hombre'
END AS Genero
FROM Alumnos;

/*4. Realizar la siguiente consulta de Alumnos, cambiando el correo de 
Gmail por hotmail*/

SELECT id, nombre, primerApellido, segundoaPellido, fechaNacimiento, correo, REPLACE(correo, 'gmail', 'hotmail')
FROM Alumnos
