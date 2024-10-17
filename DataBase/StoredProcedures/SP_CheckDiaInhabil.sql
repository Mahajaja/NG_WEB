
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

    -- Variable para almacenar si el d�a es inh�bil
    DECLARE @EsDiaInhabil BIT = 0;

    -- Verificar si la fecha es un fin de semana (s�bado o domingo)
    IF DATEPART(WEEKDAY, @Fecha) IN (1, 7)  -- 1 = domingo, 7 = s�bado (puede variar seg�n configuraci�n)
    BEGIN
        SET @EsDiaInhabil = 1;
    END

    -- Verificar si la fecha es un d�a inh�bil registrado en la tabla DiasInhabiles
    IF EXISTS (SELECT 1 FROM Dias_inhabiles WHERE Fecha_inhabil = @Fecha)
    BEGIN
        SET @EsDiaInhabil = 1;
    END

    -- Devolver si es inh�bil o no
    SELECT @EsDiaInhabil AS EsDiaInhabil;
END;
GO
