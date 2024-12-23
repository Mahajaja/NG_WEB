USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ObtenerPrestamoPorId', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerPrestamoPorId;
END
GO

CREATE PROCEDURE SP_ObtenerPrestamoPorId
    @id_prestamo INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT 
            p.id_prestamo,
            p.folio_prestamo,
            p.hora_registro,
            p.fecha_registro,
            p.id_ubicacion,
            p.id_empleado,
            p.cantidad_autorizada,
            p.descuento_semanal,
            p.fecha_entrega,
            p.fecha_inicio,
            p.fecha_fin
        FROM 
            PRESTAMO p
        WHERE 
            p.id_prestamo = @id_prestamo;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
