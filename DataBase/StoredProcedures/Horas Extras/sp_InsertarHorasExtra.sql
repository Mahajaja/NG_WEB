USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarHorasExtra')
BEGIN
    DROP PROCEDURE sp_InsertarHorasExtra
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarHorasExtra]
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_horaExtra), 0) + 1 FROM [dbo].[HORAS_EXTRAS]

        DECLARE @folio_registro NVARCHAR(50)
        SET @folio_registro = CONCAT('HE-', @nextId)

        -- Inserción del registro
        INSERT INTO [dbo].[HORAS_EXTRAS] (
            folio_registro,
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
        DECLARE @id_horaExtra INT
        SET @id_horaExtra = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_registro AS FolioGenerado, @id_horaExtra AS ID_HoraExtra
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO
