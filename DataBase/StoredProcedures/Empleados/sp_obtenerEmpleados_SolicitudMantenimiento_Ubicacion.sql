USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Obtener_Ubicaciones')
BEGIN
    DROP PROCEDURE SP_Obtener_Ubicaciones
END
GO

-- Creación del Stored Procedure
CREATE PROCEDURE [dbo].[SP_Obtener_Ubicaciones]
    @id_empleado INT
AS
BEGIN
    BEGIN TRY
        -- Declarar variables para el ID de la ubicación principal del empleado
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);
        END

        -- Verificar si el id_empleado es 0
        IF @id_empleado = 0
        BEGIN
            -- Mostrar todas las ubicaciones
            SELECT TOP (1000) 
                [id_ubicacion],
                [folio_registro],
                [hora_registro],
                [fecha_registro],
                [nombre],
                [lugar],
                [coordenada_x],
                [coordenada_y],
                [direccion],
                [cp],
                [img_ubicacion],
                [id_usuario]
            FROM [dbo].[UBICACION]
            ORDER BY [id_ubicacion] DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Verificar si el empleado tiene acceso a más ubicaciones en la tabla Ubicaciones_X_Empleado
            IF EXISTS (SELECT 1 FROM Ubicaciones_X_Empleado WHERE id_empleado = @id_empleado)
            BEGIN
                -- Mostrar todas las ubicaciones a las que tiene acceso el empleado
                SELECT DISTINCT 
                    U.[id_ubicacion],
                    U.[folio_registro],
                    U.[hora_registro],
                    U.[fecha_registro],
                    U.[nombre],
                    U.[lugar],
                    U.[coordenada_x],
                    U.[coordenada_y],
                    U.[direccion],
                    U.[cp],
                    U.[img_ubicacion],
                    U.[id_usuario]
                FROM 
                    [dbo].[UBICACION] U
                INNER JOIN 
                    Ubicaciones_X_Empleado UXE ON U.id_ubicacion = UXE.id_ubicacion
                WHERE 
                    UXE.id_empleado = @id_empleado
                ORDER BY 
                    U.[id_ubicacion] DESC; -- Ordenar por ID de manera descendente
            END
            ELSE
            BEGIN
                -- Mostrar solo la ubicación principal del empleado si no tiene registros en Ubicaciones_X_Empleado
                SELECT 
                    [id_ubicacion],
                    [folio_registro],
                    [hora_registro],
                    [fecha_registro],
                    [nombre],
                    [lugar],
                    [coordenada_x],
                    [coordenada_y],
                    [direccion],
                    [cp],
                    [img_ubicacion],
                    [id_usuario]
                FROM 
                    [dbo].[UBICACION]
                WHERE 
                    [id_ubicacion] = @Id_ubicacion_empleado
                ORDER BY 
                    [id_ubicacion] DESC; -- Ordenar por ID de manera descendente
            END
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
