USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarCierreOrden')
BEGIN
    DROP PROCEDURE sp_InsertarCierreOrden
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarCierreOrden]
    @id_solicitud INT,
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Declarar variables para la fecha y hora actuales
        DECLARE @fecha_registro DATE = CAST(GETDATE() AS DATE)
        DECLARE @hora_registro TIME = CAST(GETDATE() AS TIME)
		DECLARE @id_orden INT;
        -- Generar el folio del cierre basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_cierreOrden), 0) + 1 FROM [dbo].[CIERRE_ORDEN]

        DECLARE @folio_cierre NVARCHAR(50)
        SET @folio_cierre = CONCAT('VM-', @nextId)

		SET @id_orden = (SELECT O.id_orden FROM ORDEN_MTTO O
INNER JOIN SOLICITUD_MTTO SM ON O.id_solicitud = SM.id_solicitud
WHERE SM.id_solicitud = 40 AND O.tipo_servicio IS NOT NULL );

        -- Inserción del registro
        INSERT INTO [dbo].[CIERRE_ORDEN] (
            folio_orden,
            fecha_registro,
            hora_registro,
            id_orden,
            id_usuario
			
        )
        VALUES (
            @folio_cierre,
            @fecha_registro,
            @hora_registro,
            @id_orden,
            @id_usuario
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_cierre INT
        SET @id_cierre = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro de cierre insertado exitosamente.' AS Mensaje, 
               @folio_cierre AS FolioGenerado, 
               @id_cierre AS ID_Cierre
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO
