USE NEO_GENESIS
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ActualizarVacaciones')
BEGIN
    DROP PROCEDURE sp_ActualizarVacaciones
END
GO

CREATE PROCEDURE [dbo].[sp_ActualizarVacaciones]
    @id_vacacion INT,
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
        -- Validación de datos
		DECLARE @ID_Estatus INT = (SELECT E.ID_Estatus FROM Estatus E
							  INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
							  WHERE E.Estatus = 'EN REVISION' AND TE.TipoEstatus = 'Solicitud_Vacaciones') 
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

        -- Validar existencia del registro
        IF NOT EXISTS (SELECT 1 FROM [dbo].[VACACIONES] WHERE id_vacacion = @id_vacacion)
        BEGIN
            RAISERROR('El registro con el ID especificado no existe.', 16, 1)
            RETURN
        END

        -- Actualización del registro
        UPDATE [dbo].[VACACIONES]
        SET 
            fecha_registro = @fecha_registro,
            hora_registro = @hora_registro,
            id_ubicacion = @id_ubicacion,
            id_empleado = @id_empleado,
            fecha_inicio = @fecha_inicio,
            fecha_fin = @fecha_fin,
            dias_vacacion = @dias_vacacion,
            fecha_incorporacion = @fecha_incorporacion,
            dias_restantes = @dias_restantes,
            observaciones = @observaciones,
            id_usuario = @id_usuario,
			ID_Estatus = @ID_Estatus
        WHERE id_vacacion = @id_vacacion

        -- Confirmación de éxito
        SELECT 'Registro actualizado exitosamente.' AS Mensaje
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO