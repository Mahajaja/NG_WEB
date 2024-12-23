USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ActualizarPrestamo', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ActualizarPrestamo;
END
GO

CREATE PROCEDURE SP_ActualizarPrestamo
    @id_prestamo INT,
    
    @id_empleado INT = NULL,
    @cantidad_autorizada VARCHAR(50) = NULL,
    @fecha_entrega CHAR(10) = NULL,
    @motivo NVARCHAR(255) = NULL,
    @id_usuario INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
	DECLARE @ID_Estatus INT = (SELECT E.ID_Estatus FROM Estatus E
							  INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
							  WHERE E.Estatus = 'EN REVISION' AND TE.TipoEstatus = 'Prestamo'); 
	DECLARE @ID_Ubicacion INT = (SELECT id_ubicacion FROM EMPLEADO E WHERE id_empleado = @id_empleado);
        -- Validación para verificar que el préstamo existe antes de actualizarlo
        IF EXISTS (SELECT 1 FROM PRESTAMO WHERE id_prestamo = @id_prestamo)
        BEGIN
            UPDATE PRESTAMO
            SET 
                id_ubicacion = @ID_Ubicacion,
                id_empleado = ISNULL(@id_empleado, id_empleado),
                cantidad_autorizada = ISNULL(@cantidad_autorizada, cantidad_autorizada),
                fecha_entrega = ISNULL(@fecha_entrega, fecha_entrega),
                motivo = ISNULL(@motivo, motivo),
                id_usuario = ISNULL(@id_usuario, id_usuario),
                fecha_registro = CONVERT(CHAR(10), GETDATE(), 23), 
                hora_registro = CONVERT(CHAR(8), GETDATE(), 108),
				ID_Estatus = @ID_Estatus 
            WHERE 
                id_prestamo = @id_prestamo;

            -- Mensaje de confirmación
            SELECT 'Préstamo actualizado exitosamente.' AS Mensaje, @id_prestamo AS ID_Prestamo;
        END
        ELSE
        BEGIN
            -- Si no se encuentra el préstamo, lanza un error
            RAISERROR('No se encontró el préstamo con el ID especificado.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
