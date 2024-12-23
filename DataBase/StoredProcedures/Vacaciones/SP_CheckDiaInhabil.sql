
USE db_aad2f8_neogenesis
GO

IF OBJECT_ID('SP_CheckDiaInhabil', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_CheckDiaInhabil;
END;
GO

CREATE PROCEDURE SP_CheckDiaInhabil
    @Fecha DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Variable para almacenar si el día es inhábil
    DECLARE @EsDiaInhabil BIT = 0;

    -- Verificar si la fecha es un fin de semana (sábado o domingo)
    IF DATEPART(WEEKDAY, @Fecha) IN (1, 7)  -- 1 = domingo, 7 = sábado (puede variar según configuración)
    BEGIN
        SET @EsDiaInhabil = 1;
    END

    -- Verificar si la fecha es un día inhábil registrado en la tabla DiasInhabiles
    IF EXISTS (SELECT 1 FROM Dias_inhabiles WHERE Fecha_inhabil = @Fecha)
    BEGIN
        SET @EsDiaInhabil = 1;
    END

    -- Devolver si es inhábil o no
    SELECT @EsDiaInhabil AS EsDiaInhabil;
END;
GO
