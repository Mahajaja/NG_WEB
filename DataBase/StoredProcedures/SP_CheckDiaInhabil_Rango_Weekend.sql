IF OBJECT_ID('SP_CheckDiaInhabil_Rango_Weekend', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_CheckDiaInhabil_Rango_Weekend;
END;
GO

-- Luego puedes recrear el stored procedure
CREATE PROCEDURE SP_CheckDiaInhabil_Rango_Weekend
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Variable para contar los d�as inh�biles
    DECLARE @DiasInhabiles INT = 0;

    -- Tabla temporal para almacenar los d�as del rango
    DECLARE @Dias TABLE (Fecha DATE);

    -- Insertar todas las fechas del rango en la tabla temporal
    INSERT INTO @Dias (Fecha)
    SELECT DATEADD(DAY, Number, @FechaInicio)
    FROM master..spt_values
    WHERE Type = 'P' AND DATEADD(DAY, Number, @FechaInicio) <= @FechaFin;

    -- Contar los d�as inh�biles que son fines de semana (s�bado o domingo)
    SET @DiasInhabiles = @DiasInhabiles + (
        SELECT COUNT(*)
        FROM @Dias
        WHERE DATEPART(WEEKDAY, Fecha) IN (1, 7)  -- 1 = domingo, 7 = s�bado (puede variar seg�n configuraci�n)
    );

    -- Contar los d�as inh�biles que coinciden con los feriados almacenados en tu tabla de feriados
    SET @DiasInhabiles = @DiasInhabiles + (
        SELECT COUNT(*)
        FROM @Dias
        WHERE Fecha IN (SELECT Fecha FROM DiasInhabiles) -- Aseg�rate de tener una tabla de feriados llamada 'DiasInhabiles'
    );

    -- Devolver el n�mero de d�as inh�biles
    SELECT @DiasInhabiles AS DiasInhabiles;
END;
GO
