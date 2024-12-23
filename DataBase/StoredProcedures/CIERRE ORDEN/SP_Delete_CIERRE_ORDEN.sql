USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Delete_CIERRE_ORDEN')
BEGIN
    DROP PROCEDURE SP_Delete_CIERRE_ORDEN
END
GO

CREATE PROCEDURE SP_Delete_CIERRE_ORDEN
    @id_cierre INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Eliminar el registro de la tabla CIERRE_ORDEN
        DELETE FROM CIERRE_ORDEN
        WHERE id_cierreOrden = @id_cierre;

        -- Confirmación de éxito
        SELECT 'Registro eliminado correctamente.' AS Mensaje;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
