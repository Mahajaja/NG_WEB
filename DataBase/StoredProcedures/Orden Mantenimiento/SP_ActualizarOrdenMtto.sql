USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ActualizarOrdenMtto', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ActualizarOrdenMtto;
END
GO

CREATE PROCEDURE SP_ActualizarOrdenMtto
    @id_orden INT,
    @tipo_servicio CHAR(20) = NULL,
    @id_empleado INT = NULL,
    @atendido_externo NVARCHAR(200) = NULL,
    @diagnostico_falla NVARCHAR(1200) = NULL,
    @observaciones NVARCHAR(1200) = NULL,
    @refacciones VARCHAR(200) = NULL,
    @folio_almacen VARCHAR(50) = NULL,
    @folio_compras VARCHAR(50) = NULL,
    @falla_corregida CHAR(2) = NULL,
    @tiempo_invertido VARCHAR(50) = NULL,
    @id_usuario INT = NULL,
	@img_solucion NVARCHAR(MAX) = NULL,
	@img_solucion2 NVARCHAR(MAX) = NULL,	
	@img_solucion3 NVARCHAR(MAX) = NULL,
	@img_solucion4 NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validación para verificar que la orden existe antes de actualizarla
        IF EXISTS (SELECT 1 FROM ORDEN_MTTO WHERE id_orden = @id_orden)
        BEGIN
            UPDATE ORDEN_MTTO
            SET 
                tipo_servicio = ISNULL(@tipo_servicio, tipo_servicio),
                --id_empleado = ISNULL(@id_empleado, id_empleado),
                atendido_externo = ISNULL(@atendido_externo, atendido_externo),
                diagnostico_falla = ISNULL(@diagnostico_falla, diagnostico_falla),
                observaciones = ISNULL(@observaciones, observaciones),
                refacciones = ISNULL(@refacciones, refacciones),
                folio_almacen = ISNULL(@folio_almacen, folio_almacen),
                folio_compras = ISNULL(@folio_compras, folio_compras),
                falla_corregida = ISNULL(@falla_corregida, falla_corregida),
                tiempo_invertido = ISNULL(@tiempo_invertido, tiempo_invertido),
				img_solucion = ISNULL(@img_solucion, img_solucion),
				img_solucion2 = ISNULL(@img_solucion2, img_solucion2),
				img_solucion3 = ISNULL(@img_solucion3, img_solucion3),
				img_solucion4 = ISNULL(@img_solucion4, img_solucion4)
            WHERE 
                id_orden = @id_orden;

			UPDATE SOLICITUD_MTTO
			SET estatus = 'Finalizado'
			WHERE id_solicitud = (SELECT id_solicitud FROM ORDEN_MTTO WHERE id_orden = @id_orden)
            -- Mensaje de confirmación
            SELECT 'Orden de mantenimiento actualizada exitosamente.' AS Mensaje, @id_orden AS ID_Orden;
        END
        ELSE
        BEGIN
            -- Si no se encuentra la orden, lanza un error
            RAISERROR('No se encontró la orden de mantenimiento con el ID especificado.', 16, 1);
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
