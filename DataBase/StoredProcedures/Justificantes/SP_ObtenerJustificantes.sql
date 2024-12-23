USE NEO_GENESIS
GO

-- Borrar el procedimiento almacenado si ya existe
IF OBJECT_ID('SP_ObtenerJustificantes', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerJustificantes;
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_ObtenerJustificantes
    @id_empleado INT -- Parámetro para filtrar
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
            -- Mostrar todos los justificantes de las ubicaciones asociadas al empleado
            SELECT DISTINCT 
                J.id_justificante, 
                J.fecha_registro, 
                J.Permiso_solicitado,
                J.observacion, 
                EST.Estatus, 
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento,
                P.nombre AS Puesto
            FROM 
                JUSTIFICANTE J
            INNER JOIN 
                EMPLEADO E ON J.id_empleado = E.id_empleado
            INNER JOIN 
                Estatus EST ON J.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                PUESTO P ON E.id_puesto = P.id_puesto
            INNER JOIN 
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion
            WHERE 
                UXE.id_empleado = @id_empleado
            ORDER BY 
                J.id_justificante DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Mostrar justificantes filtrados por la ubicación principal del empleado
            SELECT 
                J.id_justificante, 
                J.fecha_registro, 
                J.Permiso_solicitado,
                J.observacion, 
                EST.Estatus, 
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento,
                P.nombre AS Puesto
            FROM 
                JUSTIFICANTE J
            INNER JOIN 
                EMPLEADO E ON J.id_empleado = E.id_empleado
            INNER JOIN 
                Estatus EST ON J.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                PUESTO P ON E.id_puesto = P.id_puesto
            WHERE 
                E.id_ubicacion = @Id_ubicacion_empleado
            ORDER BY 
                J.id_justificante DESC; -- Ordenar por ID de manera descendente
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
