USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_DeleteVacacion')
BEGIN
    DROP PROCEDURE SP_DeleteVacacion
END
GO

CREATE PROCEDURE SP_DeleteVacacion
    @IdVacacion INT
AS
BEGIN
    DELETE FROM VACACIONES
    WHERE id_vacacion = @IdVacacion;
END
