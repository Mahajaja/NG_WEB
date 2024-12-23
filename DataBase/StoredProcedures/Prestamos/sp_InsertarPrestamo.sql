USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarPrestamo')
BEGIN
    DROP PROCEDURE sp_InsertarPrestamo
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarPrestamo]
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_prestamo), 0) + 1 FROM [dbo].[PRESTAMO]

        DECLARE @folio_prestamo NVARCHAR(50)
        SET @folio_prestamo = CONCAT('P-', @nextId)

        -- Inserción del registro
        INSERT INTO [dbo].[PRESTAMO] (
            folio_prestamo,
            fecha_registro,
            hora_registro,           
            id_usuario
        )
        VALUES (
            @folio_prestamo,
            @fecha_registro,
            @hora_registro,
            @id_usuario
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_prestamo INT
        SET @id_prestamo = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_prestamo AS FolioGenerado, @id_prestamo AS ID_Prestamo
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
