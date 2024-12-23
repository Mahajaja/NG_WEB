USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ActualizarSolicitudMtto', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ActualizarSolicitudMtto;
END
GO

CREATE PROCEDURE SP_ActualizarSolicitudMtto
    @id_solicitud INT,
    @id_ubicacion INT = NULL,
    @id_empleado INT = NULL,
    @id_categoria INT = NULL,
    @id_maquinaria INT = NULL,
    @horometro INT = NULL,
    @fecha_servicio DATE = NULL, -- Cambiado a DATE
    @fecha_entrega DATE = NULL, -- Cambiado a DATE
    @grado_urgencia NVARCHAR(80) = NULL,
    @id_responsable INT = NULL,
    @costo_reparacion FLOAT = NULL,
    @tipo_servicio VARCHAR(20) = NULL,
    @id_respReparacion INT = NULL,
    @proveedor_reparacion NVARCHAR(200) = NULL,
    @descripcion_problema NVARCHAR(1200) = NULL,
    @asignado NVARCHAR(1200) = NULL,
    @estatus NVARCHAR(60) = NULL,
    @id_usuario INT = NULL,
    @NombreArchivo1 NVARCHAR(200) = NULL,
    @NombreArchivo2 NVARCHAR(200) = NULL,
    @NombreArchivo3 NVARCHAR(200) = NULL,
    @NombreArchivo4 NVARCHAR(200) = NULL,
    @idInstalacion INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validación para verificar que la solicitud existe antes de actualizarla
        IF EXISTS (SELECT 1 FROM SOLICITUD_MTTO WHERE id_solicitud = @id_solicitud)
        BEGIN
            -- Convertir las fechas a formato DD/MM/YYYY
            DECLARE @FechaServicioFormatted CHAR(10) = NULL;
            DECLARE @FechaEntregaFormatted CHAR(10) = NULL;

            IF @fecha_servicio IS NOT NULL
                SET @FechaServicioFormatted = CONVERT(CHAR(10), @fecha_servicio, 103); -- Formato DD/MM/YYYY

            IF @fecha_entrega IS NOT NULL
                SET @FechaEntregaFormatted = CONVERT(CHAR(10), @fecha_entrega, 103); -- Formato DD/MM/YYYY

            -- Actualizar la solicitud
            UPDATE SOLICITUD_MTTO
            SET 
                id_ubicacion = ISNULL(@id_ubicacion, id_ubicacion),
                id_empleado = ISNULL(@id_empleado, id_empleado),
                id_categoria = ISNULL(@id_categoria, id_categoria),
                id_maquinaria = ISNULL(@id_maquinaria, id_maquinaria),
                horometro = ISNULL(@horometro, horometro),
                fecha_servicio = ISNULL(@FechaServicioFormatted, fecha_servicio),
                fecha_entrega = ISNULL(@FechaEntregaFormatted, fecha_entrega),
                grado_urgencia = ISNULL(@grado_urgencia, grado_urgencia),
                id_responsable = ISNULL(@id_responsable, id_responsable),
                costo_reparacion = ISNULL(@costo_reparacion, costo_reparacion),
                tipo_servicio = ISNULL(@tipo_servicio, tipo_servicio),
                id_respReparacion = ISNULL(@id_respReparacion, id_respReparacion),
                proveedor_reparacion = ISNULL(@proveedor_reparacion, proveedor_reparacion),
                descripcion_problema = ISNULL(@descripcion_problema, descripcion_problema),
                id_usuario = ISNULL(@id_usuario, id_usuario),
                fecha_registro = CONVERT(CHAR(10), GETDATE(), 103),
                hora_registro = CONVERT(CHAR(8), GETDATE(), 108),
                estatus = 'En Proceso',
                Asignado = @asignado,
                img_evidencia = @NombreArchivo1,
                img_evidencia2 = @NombreArchivo2,
                img_evidencia3 = @NombreArchivo3,
                img_evidencia4 = @NombreArchivo4,
                id_instalacion = @idInstalacion
            WHERE 
                id_solicitud = @id_solicitud;

            -- Mensaje de confirmación
            SELECT 'Solicitud de mantenimiento actualizada exitosamente.' AS Mensaje, @id_solicitud AS ID_Solicitud;
        END
        ELSE
        BEGIN
            -- Si no se encuentra la solicitud, lanza un error
            RAISERROR('No se encontró la solicitud de mantenimiento con el ID especificado.', 16, 1);
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
