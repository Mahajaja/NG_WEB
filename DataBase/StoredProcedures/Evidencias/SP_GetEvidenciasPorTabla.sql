USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GetEvidenciasPorTabla')
BEGIN
    DROP PROCEDURE SP_GetEvidenciasPorTabla
END
GO

-- Crea el Stored Procedure
CREATE PROCEDURE SP_GetEvidenciasPorTabla
    @ID_Tabla INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Selecciona los registros de la tabla Evidencias filtrando por ID_Tabla y ID_TipoEvidencia = 2
        SELECT ID_Evidencia, ID_Tabla, NombreArchivo, id_usuario, FechaInserto, ID_TipoEvidencia
        FROM Evidencias
        WHERE ID_Tabla = @ID_Tabla
          AND ID_TipoEvidencia = 2;

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
