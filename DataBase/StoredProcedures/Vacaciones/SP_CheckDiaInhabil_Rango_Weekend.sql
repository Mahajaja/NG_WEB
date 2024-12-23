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

    -- Variable para contar los días inhábiles
    DECLARE @DiasInhabiles INT = 0;

    -- Tabla temporal para almacenar los días del rango
    DECLARE @Dias TABLE (Fecha DATE);

    -- Insertar todas las fechas del rango en la tabla temporal
    INSERT INTO @Dias (Fecha)
    SELECT DATEADD(DAY, Number, @FechaInicio)
    FROM master..spt_values
    WHERE Type = 'P' AND DATEADD(DAY, Number, @FechaInicio) <= @FechaFin;

    -- Contar los días inhábiles que son fines de semana (sábado o domingo)
    SET @DiasInhabiles = @DiasInhabiles + (
        SELECT COUNT(*)
        FROM @Dias
        WHERE DATEPART(WEEKDAY, Fecha) IN (1, 7)  -- 1 = domingo, 7 = sábado (puede variar según configuración)
    );

    -- Contar los días inhábiles que coinciden con los feriados almacenados en tu tabla de feriados
    SET @DiasInhabiles = @DiasInhabiles + (
        SELECT COUNT(*)
        FROM @Dias
        WHERE Fecha IN (SELECT Fecha FROM DiasInhabiles) -- Asegúrate de tener una tabla de feriados llamada 'DiasInhabiles'
    );

    -- Devolver el número de días inhábiles
    SELECT @DiasInhabiles AS DiasInhabiles;
END;
GO
