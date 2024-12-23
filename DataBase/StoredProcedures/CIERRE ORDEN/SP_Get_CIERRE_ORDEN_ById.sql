USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Get_CIERRE_ORDEN_ById')
BEGIN
    DROP PROCEDURE SP_Get_CIERRE_ORDEN_ById
END
GO

CREATE PROCEDURE SP_Get_CIERRE_ORDEN_ById
    @id_cierreOrden INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Obtener los datos del registro en base al id_cierreOrden
        SELECT 
            CO.id_cierreOrden,
            CO.folio_orden,
            CO.fecha_registro,
            CO.hora_registro,
            CO.id_orden,
            CO.id_usuario,
            CO.herramientas_trabajo,
            CO.tiempo_reparacion,
            CO.reparacion_realizada,
            CO.otra_falla,
            CO.especificacion_falla,
            CO.area_reparacion,
			CO.medidas_seguridad,
            CO.area_limpia,
            CO.calidad_trabajo,
            CO.especificar_calidad,
            CO.sobrante_material,
            CO.entrada_almacen,
            CO.observaciones,
			ISNULL(E.nombre, '') + ' ' + ISNULL(E.apellido_paterno, '') + ' ' + ISNULL(E.apellido_materno, '') AS Responsable,
			O.folio_orden AS Folio_orden,
			SO.tipo_servicio
        FROM 
    CIERRE_ORDEN CO
INNER JOIN 
    ORDEN_MTTO O ON CO.id_orden = O.id_orden
INNER JOIN 
    SOLICITUD_MTTO SO ON O.id_solicitud = SO.id_solicitud
INNER JOIN 
    EMPLEADO E ON SO.id_empleado = E.id_empleado
WHERE 
    CO.id_cierreOrden = @id_cierreOrden;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
