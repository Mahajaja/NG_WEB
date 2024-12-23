USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ObtenerIncidenciaPorId')
BEGIN
    DROP PROCEDURE sp_ObtenerIncidenciaPorId
END
GO

CREATE PROCEDURE [dbo].[sp_ObtenerIncidenciaPorId]
    @id_incidencia INT
AS
BEGIN
    BEGIN TRY
        -- Selecciona el registro de la tabla INCIDENCIA basado en el ID proporcionado
        SELECT 
            [id_incidencia],
            [folio_incidencia],
            [hora_registro],
            [fecha_registro],
            [id_ubicacion],
            [id_empleado],
            [tipo_registro],
            [tipo_incidencia],
            [tiempo_sancion],
            [descuento_dia],
            [dia],
            [fecha_inicio],
            [descripcion],
            [goze],
            [horas],
            [id_usuario],
            [ID_Estatus]
        FROM 
          [dbo].[INCIDENCIA]
        WHERE 
            [id_incidencia] = @id_incidencia;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO
