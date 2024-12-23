USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Update_CIERRE_ORDEN')
BEGIN
    DROP PROCEDURE SP_Update_CIERRE_ORDEN
END
GO

CREATE PROCEDURE SP_Update_CIERRE_ORDEN
    @id_cierreOrden INT,
    @herramientas_trabajo CHAR(50) = NULL,
    @tiempo_reparacion CHAR(50) = NULL,
    @reparacion_realizada CHAR(50) = NULL,
    @otra_falla CHAR(50) = NULL,
    @especificacion_falla NVARCHAR(255) = NULL,
    @area_reparacion CHAR(50) = NULL,
    @medidas_seguridad CHAR(50) = NULL,
    @area_limpia CHAR(50) = NULL,
    @calidad_trabajo VARCHAR(50) = NULL,
    @especificar_calidad NVARCHAR(255) = NULL,
    @sobrante_material CHAR(50) = NULL,
    @entrada_almacen NVARCHAR(255) = NULL,
    @observaciones NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Actualización de los campos de la tabla CIERRE_ORDEN
        UPDATE CIERRE_ORDEN
        SET 
            herramientas_trabajo = ISNULL(@herramientas_trabajo, herramientas_trabajo),
            tiempo_reparacion = ISNULL(@tiempo_reparacion, tiempo_reparacion),
            reparacion_realizada = ISNULL(@reparacion_realizada, reparacion_realizada),
            otra_falla = ISNULL(@otra_falla, otra_falla),
            especificacion_falla = ISNULL(@especificacion_falla, especificacion_falla),
            area_reparacion = ISNULL(@area_reparacion, area_reparacion),
            medidas_seguridad = ISNULL(@medidas_seguridad, medidas_seguridad),
            area_limpia = ISNULL(@area_limpia, area_limpia),
            calidad_trabajo = ISNULL(@calidad_trabajo, calidad_trabajo),
            especificar_calidad = ISNULL(@especificar_calidad, especificar_calidad),
            sobrante_material = ISNULL(@sobrante_material, sobrante_material),
            entrada_almacen = ISNULL(@entrada_almacen, entrada_almacen),
            observaciones = ISNULL(@observaciones, observaciones)
        WHERE 
            id_cierreOrden = @id_cierreOrden;

        -- Confirmación de éxito
        SELECT 'Registro actualizado correctamente.' AS Mensaje;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
