
USE NEO_GENESIS
GO

USE NEO_GENESIS
GO

IF OBJECT_ID('SP_ObtenerPrestamos', 'P') IS NOT NULL
    DROP PROCEDURE SP_ObtenerPrestamos;
GO

CREATE PROCEDURE SP_ObtenerPrestamos
    @id_empleado INT -- Parámetro para filtrar por empleado
AS
BEGIN
    BEGIN TRY
        -- Declarar variable para la ubicación principal del empleado
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);
        END

        -- Verificar si el empleado tiene acceso a múltiples ubicaciones mediante Ubicaciones_X_Empleado
        IF EXISTS (SELECT 1 FROM Ubicaciones_X_Empleado WHERE id_empleado = @id_empleado)
        BEGIN
            -- Mostrar todos los préstamos de las ubicaciones asociadas al empleado
            SELECT DISTINCT 
                P.id_prestamo,
                P.folio_prestamo,
                P.hora_registro,
                P.fecha_registro,
                P.id_ubicacion,
                P.id_empleado,
                P.cantidad_autorizada,
                P.descuento_semanal,
                P.fecha_entrega,
                P.fecha_inicio,
                P.fecha_fin,
                P.motivo,
                P.id_usuario,
                P.ID_Estatus,
                EST.Estatus,
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento
            FROM 
                PRESTAMO P
            INNER JOIN 
                ESTATUS EST ON P.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                EMPLEADO E ON P.id_empleado = E.id_empleado
            INNER JOIN 
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion
            WHERE 
                UXE.id_empleado = @id_empleado
            ORDER BY 
                P.id_prestamo DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Mostrar solo los préstamos de la ubicación principal del empleado
            SELECT 
                P.id_prestamo,
                P.folio_prestamo,
                P.hora_registro,
                P.fecha_registro,
                P.id_ubicacion,
                P.id_empleado,
                P.cantidad_autorizada,
                P.descuento_semanal,
                P.fecha_entrega,
                P.fecha_inicio,
                P.fecha_fin,
                P.motivo,
                P.id_usuario,
                P.ID_Estatus,
                EST.Estatus,
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento
            FROM 
                PRESTAMO P
            INNER JOIN 
                ESTATUS EST ON P.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                EMPLEADO E ON P.id_empleado = E.id_empleado
            WHERE 
                E.id_ubicacion = @Id_ubicacion_empleado
            ORDER BY 
                P.id_prestamo DESC; -- Ordenar por ID de manera descendente
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
