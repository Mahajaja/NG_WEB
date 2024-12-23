USE NEO_GENESIS
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Delete_Vacacion')
BEGIN
    DROP PROCEDURE SP_Delete_Vacacion
END
GO

CREATE PROCEDURE SP_Delete_Vacacion
    @id_vacacion INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM VACACIONES
    WHERE id_vacacion = @id_vacacion;
END;
GO
