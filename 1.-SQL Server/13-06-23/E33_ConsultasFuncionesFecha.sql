USE InstitutoTICH;
GO

SELECT id, nombre, primerApellido, segundoaPellido, fechaNacimiento, GETDATE() AS Hoy, (DATEDIFF(MONTH ,fechaNacimiento, GETDATE()) / 12) AS Edad, (DATEDIFF(MONTH, fechaNacimiento, DATEADD(MONTH, 5, GETDATE())) / 12) AS Edad5Meses
FROM Alumnos;

