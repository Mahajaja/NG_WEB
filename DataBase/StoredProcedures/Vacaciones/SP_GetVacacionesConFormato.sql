USE NEO_GENESIS
GO

-- Verificar si el procedimiento almacenado ya existe y eliminarlo
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GetVacacionesConFormato')
BEGIN
    DROP PROCEDURE SP_GetVacacionesConFormato
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_GetVacacionesConFormato
    @id_empleado INT -- Parámetro para identificar al empleado que hace la consulta
AS
BEGIN
    BEGIN TRY
        -- Declarar variables para identificar la ubicación principal del empleado
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);
        END

        -- Verificar si el empleado tiene acceso a múltiples ubicaciones mediante Ubicaciones_X_Empleado
        IF EXISTS (SELECT 1 FROM Ubicaciones_X_Empleado WHERE id_empleado = @id_empleado)
        BEGIN
            -- Mostrar todas las vacaciones de las ubicaciones asociadas al empleado
            SELECT DISTINCT 
                V.id_vacacion,
                E.nombre, 
                CONVERT(VARCHAR(10), V.fecha_inicio, 103) AS fecha_inicio,  -- Formato dd/MM/yyyy
                CONVERT(VARCHAR(10), V.fecha_incorporacion, 103) AS fecha_incorporacion,  -- Formato dd/MM/yyyy
                V.dias_vacacion, 
                EST.Estatus,
                V.observaciones
            FROM 
                VACACIONES V
            INNER JOIN 
                EMPLEADO E ON V.id_empleado = E.id_empleado
            LEFT JOIN 
                Estatus EST ON V.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion
            WHERE 
                UXE.id_empleado = @id_empleado
            ORDER BY 
                V.id_vacacion DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Mostrar solo las vacaciones de la ubicación principal del empleado
            SELECT 
                V.id_vacacion,
                E.nombre, 
                CONVERT(VARCHAR(10), V.fecha_inicio, 103) AS fecha_inicio,  -- Formato dd/MM/yyyy
                CONVERT(VARCHAR(10), V.fecha_incorporacion, 103) AS fecha_incorporacion,  -- Formato dd/MM/yyyy
                V.dias_vacacion, 
                EST.Estatus,
                V.observaciones
            FROM 
                VACACIONES V
            INNER JOIN 
                EMPLEADO E ON V.id_empleado = E.id_empleado
            LEFT JOIN 
                Estatus EST ON V.ID_Estatus = EST.ID_Estatus
            WHERE 
                E.id_ubicacion = @Id_ubicacion_empleado
            ORDER BY 
                V.id_vacacion DESC; -- Ordenar por ID de manera descendente
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
