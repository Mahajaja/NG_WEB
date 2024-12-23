USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarOrdenMtto')
BEGIN
    DROP PROCEDURE sp_InsertarOrdenMtto
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarOrdenMtto]
    
    @id_solicitud INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_orden), 0) + 1 FROM [dbo].[ORDEN_MTTO]

        DECLARE @folio_orden NVARCHAR(50)
        SET @folio_orden = CONCAT('OM-', @nextId)

		DECLARE @ID_Empleado INT = (SELECT id_empleado FROM SOLICITUD_MTTO WHERE id_solicitud = @id_solicitud);

        -- Obtener la fecha y hora actual
        DECLARE @fecha_registro CHAR(10)
        DECLARE @hora_registro CHAR(8)
        SELECT @fecha_registro = CONVERT(CHAR(10), GETDATE(), 120), -- yyyy-MM-dd
               @hora_registro = CONVERT(CHAR(8), GETDATE(), 108)    -- HH:mm:ss

        -- Inserción del registro
        INSERT INTO [dbo].[ORDEN_MTTO] (
            folio_orden,
            fecha_registro,
            hora_registro,
            id_solicitud,
			id_empleado
        )
        VALUES (
            @folio_orden,
            @fecha_registro,
            @hora_registro,
            @id_solicitud,
			@ID_Empleado
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_orden INT
        SET @id_orden = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_orden AS FolioGenerado, @id_orden AS ID_Orden
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

