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
        -- Declarar variables solo si el id_empleado no es 0
        DECLARE @Id_puesto_Coordinador INT;
        DECLARE @Id_Puesto_Empleado INT;
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_puesto_Coordinador = (SELECT id_puesto FROM PUESTO WHERE nombre = 'Coordinador Rh');
            SET @Id_Puesto_Empleado = (SELECT id_puesto FROM EMPLEADO WHERE id_empleado = @id_empleado);
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
            -- Verificar si el empleado es Coordinador Rh
            IF @Id_Puesto_Empleado = @Id_puesto_Coordinador
            BEGIN
                -- Mostrar todas las ubicaciones si el empleado es Coordinador Rh
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
                -- Mostrar solo la ubicación del empleado si no es Coordinador Rh
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
                FROM [dbo].[UBICACION]
                WHERE [id_ubicacion] = @Id_ubicacion_empleado
                ORDER BY [id_ubicacion] DESC; -- Ordenar por ID de manera descendente
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
