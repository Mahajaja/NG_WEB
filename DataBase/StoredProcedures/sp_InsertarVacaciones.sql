USE NEO_GENESIS
GO 
CREATE PROCEDURE [dbo].[sp_InsertarVacaciones]
    @folio_registro NVARCHAR(50),
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_ubicacion INT,
    @id_empleado INT,
    @fecha_inicio DATE,
    @fecha_fin DATE,
    @dias_vacacion INT,
    @fecha_incorporacion DATE,
    @dias_restantes INT,
    @observaciones NVARCHAR(255),
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Validación de datos (ejemplo: fechas coherentes)
        IF @fecha_fin < @fecha_inicio
        BEGIN
            RAISERROR('La fecha de fin no puede ser anterior a la fecha de inicio.', 16, 1)
            RETURN
        END

        IF @dias_vacacion <= 0
        BEGIN
            RAISERROR('Los días de vacación deben ser mayores a 0.', 16, 1)
            RETURN
        END

        -- Inserción del registro
        INSERT INTO [NEO_GENESIS].[dbo].[VACACIONES] (
            folio_registro,
            fecha_registro,
            hora_registro,
            id_ubicacion,
            id_empleado,
            fecha_inicio,
            fecha_fin,
            dias_vacacion,
            fecha_incorporacion,
            dias_restantes,
            observaciones,
            id_usuario
        )
        VALUES (
            @folio_registro,
            @fecha_registro,
            @hora_registro,
            @id_ubicacion,
            @id_empleado,
            @fecha_inicio,
            @fecha_fin,
            @dias_vacacion,
            @fecha_incorporacion,
            @dias_restantes,
            @observaciones,
            @id_usuario
        )
        
        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
