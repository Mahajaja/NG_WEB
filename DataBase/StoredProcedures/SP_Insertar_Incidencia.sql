USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarIncidencia')
BEGIN
    DROP PROCEDURE sp_InsertarIncidencia
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarIncidencia]
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_incidencia), 0) + 1 FROM [NEO_GENESIS].[dbo].[INCIDENCIA]

        DECLARE @folio_registro NVARCHAR(50)
        SET @folio_registro = CONCAT('INC-', @nextId)

        -- Inserción del registro
        INSERT INTO [NEO_GENESIS].[dbo].[INCIDENCIA] (
            folio_incidencia,
            fecha_registro,
            hora_registro,
            id_usuario
        )
        VALUES (
            @folio_registro,
            @fecha_registro,
            @hora_registro,
            @id_usuario
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_incidencia INT
        SET @id_incidencia = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_registro AS FolioGenerado, @id_incidencia AS ID_Incidencia
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
