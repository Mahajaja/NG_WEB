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
        -- Seleccionar los primeros 1000 registros de la tabla UBICACION
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
        FROM [NEO_GENESIS].[dbo].[UBICACION]
        ORDER BY [id_ubicacion] DESC;  -- Ordenar por ID de manera descendente
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
