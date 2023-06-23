USE [master]
GO
/****** Object:  Database [InstitutoTICH]    Script Date: 16/06/2023 12:05:33 p. m. ******/
CREATE DATABASE [InstitutoTICH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'InstitutoTICH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InstitutoTICH.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'InstitutoTICH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\InstitutoTICH_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [InstitutoTICH] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [InstitutoTICH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [InstitutoTICH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [InstitutoTICH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [InstitutoTICH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [InstitutoTICH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [InstitutoTICH] SET ARITHABORT OFF 
GO
ALTER DATABASE [InstitutoTICH] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [InstitutoTICH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [InstitutoTICH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [InstitutoTICH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [InstitutoTICH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [InstitutoTICH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [InstitutoTICH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [InstitutoTICH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [InstitutoTICH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [InstitutoTICH] SET  DISABLE_BROKER 
GO
ALTER DATABASE [InstitutoTICH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [InstitutoTICH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [InstitutoTICH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [InstitutoTICH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [InstitutoTICH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [InstitutoTICH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [InstitutoTICH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [InstitutoTICH] SET RECOVERY FULL 
GO
ALTER DATABASE [InstitutoTICH] SET  MULTI_USER 
GO
ALTER DATABASE [InstitutoTICH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [InstitutoTICH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [InstitutoTICH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [InstitutoTICH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [InstitutoTICH] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [InstitutoTICH] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'InstitutoTICH', N'ON'
GO
ALTER DATABASE [InstitutoTICH] SET QUERY_STORE = OFF
GO
USE [InstitutoTICH]
GO
/****** Object:  UserDefinedFunction [dbo].[AmortizacionAlumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[AmortizacionAlumnos] (@IDA INT)
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
/****** Object:  UserDefinedFunction [dbo].[AmortizacionPrestamoInsctructor]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[AmortizacionPrestamoInsctructor](@IDI INT)
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
/****** Object:  UserDefinedFunction [dbo].[Calculadora]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Calculadora] (@N1 DECIMAL(9,3), @N2 DECIMAL(9,3), @Op VARCHAR(1))
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
/****** Object:  UserDefinedFunction [dbo].[Descuento]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Descuento] (@Meses INT, @SM DECIMAL(20, 2))
RETURNS INT
AS
BEGIN
	DECLARE @PorcentajeB INT = (@SM / 1000)
	DECLARE @Descuento INT = 
	CASE
		WHEN @Meses = 1 THEN @PorcentajeB
		WHEN @Meses = 2 THEN (@PorcentajeB * .75)
		WHEN @Meses = 3 THEN (@PorcentajeB * .50)
		WHEN @Meses = 4 THEN (@PorcentajeB * .25)
		ELSE 0
	END
	RETURN @Descuento
END
GO
/****** Object:  UserDefinedFunction [dbo].[Factorial]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Factorial] (@N INT)
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
/****** Object:  UserDefinedFunction [dbo].[GetEdad]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[GetEdad] (@FN DATE, @FR DATE)
RETURNS INT
AS
BEGIN
	RETURN ((DATEDIFF(MONTH, @FN, @FR) / 12) + (DATEDIFF(DAY, @FN, @FR) / 365)) / 2
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetHonorarios]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[GetHonorarios] (@IDI INT, @IDC INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE @CuotaInscructor INT = (SELECT cuotaHora FROM Instructores WHERE id = @IDI)
	DECLARE @HorasCurso INT = (SELECT CC.horas FROM CatCursos CC INNER JOIN Cursos C ON C.idCatCurso = CC.id INNER JOIN CursosInstructores CI ON CI.idCurso = C.id WHERE CI.idCurso = @IDC AND CI.idInstructor = @IDI)
	RETURN (@CuotaInscructor * @HorasCurso)
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetIdEstado]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[GetIdEstado] (@curp VARCHAR(18))
RETURNS INT
BEGIN
	RETURN (
		SELECT id 
		FROM Estados 
		WHERE curp LIKE SUBSTRING(@curp, 12, 2)
		)
END
GO
/****** Object:  UserDefinedFunction [dbo].[Impuestos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Impuestos] (@IDI INT, @IDC INT)
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
/****** Object:  UserDefinedFunction [dbo].[Jaden]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[Jaden] (@cadena VARCHAR(255))
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
/****** Object:  UserDefinedFunction [dbo].[RembolsoMensual]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[RembolsoMensual] (@RM DECIMAL(20, 2))
RETURNS DECIMAL(20, 2)
AS
BEGIN
	DECLARE @Rembolso DECIMAL(20, 2) = (@RM * 2.5)
	RETURN @Rembolso / 12
END
GO
/****** Object:  Table [dbo].[Alumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alumnos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[primerApellido] [varchar](50) NOT NULL,
	[segundoaPellido] [varchar](50) NULL,
	[correo] [varchar](80) NOT NULL,
	[telefono] [nchar](10) NOT NULL,
	[fechaNacimiento] [date] NOT NULL,
	[curp] [char](18) NOT NULL,
	[sueldo] [decimal](9, 2) NULL,
	[idEstadoOrigen] [int] NOT NULL,
	[idEstatus] [smallint] NOT NULL,
 CONSTRAINT [PK__Alumnos__3213E83F92CDE6B2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estados](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NULL,
	[curp] [varchar](2) NULL,
 CONSTRAINT [PK__estados__3213E83F10B5EB8D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstatusAlumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstatusAlumnos](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[clave] [char](10) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
 CONSTRAINT [PK__EstatusA__3213E83FCE278ADA] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vAlumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[vAlumnos]
AS
SELECT A.id, A.nombre, A.primerApellido, A.segundoaPellido, A.correo, A.telefono, A.curp, E.nombre AS Estado, EA.nombre AS Estatus
FROM Alumnos A
INNER JOIN Estados E ON A.idEstadoOrigen = E.id
INNER JOIN EstatusAlumnos EA ON A.idEstatus = EA.id
GO
/****** Object:  Table [dbo].[AlumnosBaja]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlumnosBaja](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[primerApellido] [varchar](50) NOT NULL,
	[segundoApellido] [varchar](50) NULL,
	[fechaBaja] [datetime] NOT NULL,
 CONSTRAINT [PK_AlumnosBaja] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CatCursos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CatCursos](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[clave] [varchar](15) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](1000) NULL,
	[horas] [tinyint] NOT NULL,
	[idPreRequisito] [smallint] NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK__CatCurso__3213E83F131F0FD9] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cursos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cursos](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[idCatCurso] [smallint] NULL,
	[fechaInicio] [date] NULL,
	[fechaTermino] [date] NULL,
	[activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CursosAlumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CursosAlumnos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idCurso] [smallint] NOT NULL,
	[idAlumnos] [int] NOT NULL,
	[fechaInscripcion] [date] NOT NULL,
	[fechaBaja] [date] NULL,
	[calificacion] [tinyint] NULL,
 CONSTRAINT [PK__CursosAl__3213E83F5A27A16A] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CursosInstructores]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CursosInstructores](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idCurso] [smallint] NOT NULL,
	[idInstructor] [smallint] NOT NULL,
	[fechaContratacion] [date] NULL,
 CONSTRAINT [PK_CursosInstructores] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructores]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructores](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[primerApellido] [varchar](50) NOT NULL,
	[segundoApellido] [varchar](50) NULL,
	[correo] [varchar](80) NOT NULL,
	[telefono] [nchar](10) NOT NULL,
	[fechaNacimiento] [date] NOT NULL,
	[rfc] [char](13) NOT NULL,
	[curp] [char](18) NOT NULL,
	[cuotaHora] [decimal](9, 2) NOT NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK__Instruct__3213E83F707C2271] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[saldos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[saldos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[saldo] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TablaISR]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablaISR](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LimInf] [decimal](19, 2) NULL,
	[LimSup] [decimal](19, 2) NULL,
	[CuotaFija] [decimal](19, 2) NULL,
	[ExedLimInf] [decimal](19, 2) NULL,
	[Subsidio] [decimal](19, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transacciones]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transacciones](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idOrigen] [int] NOT NULL,
	[idDestino] [int] NOT NULL,
	[monto] [decimal](9, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Alumnos]  WITH CHECK ADD  CONSTRAINT [fk_EstadoOrigen] FOREIGN KEY([idEstadoOrigen])
REFERENCES [dbo].[Estados] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Alumnos] CHECK CONSTRAINT [fk_EstadoOrigen]
GO
ALTER TABLE [dbo].[Alumnos]  WITH CHECK ADD  CONSTRAINT [fk_Estatus] FOREIGN KEY([idEstatus])
REFERENCES [dbo].[EstatusAlumnos] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Alumnos] CHECK CONSTRAINT [fk_Estatus]
GO
ALTER TABLE [dbo].[CatCursos]  WITH CHECK ADD  CONSTRAINT [FK__CatCursos__activ__2E1BDC42] FOREIGN KEY([idPreRequisito])
REFERENCES [dbo].[CatCursos] ([id])
GO
ALTER TABLE [dbo].[CatCursos] CHECK CONSTRAINT [FK__CatCursos__activ__2E1BDC42]
GO
ALTER TABLE [dbo].[Cursos]  WITH CHECK ADD  CONSTRAINT [fk_CatCurso] FOREIGN KEY([idCatCurso])
REFERENCES [dbo].[CatCursos] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cursos] CHECK CONSTRAINT [fk_CatCurso]
GO
ALTER TABLE [dbo].[CursosAlumnos]  WITH CHECK ADD  CONSTRAINT [fk_Alumnos] FOREIGN KEY([idAlumnos])
REFERENCES [dbo].[Alumnos] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CursosAlumnos] CHECK CONSTRAINT [fk_Alumnos]
GO
ALTER TABLE [dbo].[CursosAlumnos]  WITH CHECK ADD  CONSTRAINT [fk_Cursos] FOREIGN KEY([idCurso])
REFERENCES [dbo].[Cursos] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CursosAlumnos] CHECK CONSTRAINT [fk_Cursos]
GO
ALTER TABLE [dbo].[CursosInstructores]  WITH CHECK ADD  CONSTRAINT [FK__CursosIns__idCur__3B75D760] FOREIGN KEY([idCurso])
REFERENCES [dbo].[Cursos] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CursosInstructores] CHECK CONSTRAINT [FK__CursosIns__idCur__3B75D760]
GO
ALTER TABLE [dbo].[CursosInstructores]  WITH CHECK ADD  CONSTRAINT [FK__CursosIns__idIns__4222D4EF] FOREIGN KEY([idInstructor])
REFERENCES [dbo].[Instructores] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CursosInstructores] CHECK CONSTRAINT [FK__CursosIns__idIns__4222D4EF]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [fk_idDestino] FOREIGN KEY([idDestino])
REFERENCES [dbo].[saldos] ([id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [fk_idDestino]
GO
ALTER TABLE [dbo].[Transacciones]  WITH CHECK ADD  CONSTRAINT [fk_idOrigen] FOREIGN KEY([idOrigen])
REFERENCES [dbo].[saldos] ([id])
GO
ALTER TABLE [dbo].[Transacciones] CHECK CONSTRAINT [fk_idOrigen]
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizarAlumno]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_actualizarAlumno]
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
	SET @cont = @cont + 1
	END
	IF @AP NOT LIKE (SELECT primerApellido FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET primerApellido = @AP
	SET @cont = @cont + 1
	END
	IF @AM NOT LIKE (SELECT segundoaPellido FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET segundoaPellido = @AM
	SET @cont = @cont + 1
	END
	IF @Correo NOT LIKE (SELECT correo FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET correo = @Correo
	SET @cont = @cont + 1
	END
	IF @Telefono NOT LIKE (SELECT telefono FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET telefono = @Telefono
	SET @cont = @cont + 1
	END
	IF @FN NOT LIKE (SELECT fechaNacimiento FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET fechaNacimiento = @FN
	SET @cont = @cont + 1
	END
	IF @CURP NOT LIKE (SELECT curp FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET curp = @CURP
	SET @cont = @cont + 1
	END
	IF @Sueldo NOT LIKE (SELECT sueldo FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET sueldo = @Sueldo
	SET @cont = @cont + 1
	END
	IF @IEO NOT LIKE (SELECT idEstadoOrigen FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET idEstadoOrigen = @IEO
	SET @cont = @cont + 1
	END
	IF @IE NOT LIKE (SELECT idEstatus FROM Alumnos WHERE id = @ID)
	BEGIN
	UPDATE Alumnos SET idEstatus = @IE
	SET @cont = @cont + 1
	END

	PRINT CONCAT('Registros Actualizados: ', @cont)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarEstatusAlumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_ActualizarEstatusAlumnos]
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
/****** Object:  StoredProcedure [dbo].[sp_agregarAlumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_agregarAlumnos] 
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
/****** Object:  StoredProcedure [dbo].[sp_CodigoAcii]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_CodigoAcii] 
AS
DECLARE @C INT= 32
WHILE @C <= 255
BEGIN
	PRINT CONCAT(CHAR(@C), ' ASCII=> ', @C)
	SET @C = @C + 1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_consultarAlumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_consultarAlumnos]
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
/****** Object:  StoredProcedure [dbo].[sp_ConsultarEAlumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_ConsultarEAlumnos]
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
/****** Object:  StoredProcedure [dbo].[sp_consultarEstados]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_consultarEstados]
(
	@IDE INT
)
AS
BEGIN
	IF @IDE = -1
	BEGIN
		SELECT * FROM Estados
	END
	ELSE
	BEGIN
		SELECT * FROM Estados WHERE id = @IDE
	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_consultarEstatusAlumnos]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_consultarEstatusAlumnos]
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
/****** Object:  StoredProcedure [dbo].[sp_eliminarAlumno]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_eliminarAlumno] (@ID INT)
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
/****** Object:  StoredProcedure [dbo].[sp_Factorial]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_Factorial] 
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
/****** Object:  StoredProcedure [dbo].[sp_Transacciones]    Script Date: 16/06/2023 12:05:33 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[sp_Transacciones]
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
USE [master]
GO
ALTER DATABASE [InstitutoTICH] SET  READ_WRITE 
GO
