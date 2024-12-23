USE NEO_GENESIS
GO

-- Borrar el procedimiento almacenado si ya existe
IF OBJECT_ID('SP_ObtenerMisEmpleadosPorUbicacion', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerMisEmpleadosPorUbicacion;
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_ObtenerMisEmpleadosPorUbicacion
    @id_empleado INT -- Parámetro para identificar al empleado que realiza la consulta
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
            -- Mostrar empleados de las ubicaciones asociadas al empleado
            SELECT DISTINCT 
                E.*, 
                CASE 
                    WHEN CHARINDEX('\\', img_empleado) > 0 
                    THEN RIGHT(img_empleado, CHARINDEX('\\', REVERSE(img_empleado)) - 1) 
                    ELSE ISNULL(img_empleado, '') 
                END AS Img_empleado_nombre, 
                P.nombre AS Puesto
            FROM 
                EMPLEADO E
            INNER JOIN 
                PUESTO P ON E.id_puesto = P.id_puesto
            INNER JOIN 
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion
            WHERE 
                UXE.id_empleado = @id_empleado
                AND E.id_empleado != 25 -- Excluir empleado con ID 25
            ORDER BY 
                E.id_empleado ASC; -- Ordenar por ID de empleado de manera ascendente
        END
        ELSE
        BEGIN
            -- Mostrar empleados filtrados por la ubicación principal del empleado
            SELECT 
                E.*, 
                CASE 
                    WHEN CHARINDEX('\\', img_empleado) > 0 
                    THEN RIGHT(img_empleado, CHARINDEX('\\', REVERSE(img_empleado)) - 1) 
                    ELSE ISNULL(img_empleado, '') 
                END AS Img_empleado_nombre, 
                P.nombre AS Puesto
            FROM 
                EMPLEADO E
            INNER JOIN 
                PUESTO P ON E.id_puesto = P.id_puesto
            WHERE 
                E.id_ubicacion = @Id_ubicacion_empleado
                AND E.id_empleado != 25 -- Excluir empleado con ID 25
            ORDER BY 
                E.id_empleado ASC; -- Ordenar por ID de empleado de manera ascendente
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
