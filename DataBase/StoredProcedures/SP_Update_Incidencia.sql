USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Update_Incidencia')
BEGIN
    DROP PROCEDURE SP_Update_Incidencia
END
GO

CREATE PROCEDURE [dbo].[SP_Update_Incidencia]
    @id_incidencia INT,
    @id_empleado INT,  
    @tipo_registro VARCHAR(50),  
    @tipo_incidencia VARCHAR(50),  
    @tiempo_sancion VARCHAR(50),  
    @descuento_dia CHAR(5),  
    @dia VARCHAR(10),  
    @fecha_inicio CHAR(10),  
    @descripcion NVARCHAR(MAX),  
    @goze CHAR(1),  
    @horas CHAR(5),  
    @id_usuario INT  
AS
BEGIN
    BEGIN TRY
		DECLARE @ID_Estatus INT = (SELECT E.ID_Estatus FROM Estatus E
							  INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
							  WHERE E.Estatus = 'EN REVISION' AND TE.TipoEstatus = 'Incidencias') 

        -- Validar que el registro exista
        IF NOT EXISTS (SELECT 1 FROM INCIDENCIA WHERE id_incidencia = @id_incidencia)
        BEGIN
            RAISERROR('No se encontró una incidencia con el ID proporcionado.', 16, 1)
            RETURN
        END

        -- Actualizar el registro existente
        UPDATE INCIDENCIA
        SET
            id_empleado = @id_empleado,
            tipo_registro = @tipo_registro,
            tipo_incidencia = @tipo_incidencia,
            tiempo_sancion = @tiempo_sancion,
            descuento_dia = @descuento_dia,
            dia = @dia,
            fecha_inicio = @fecha_inicio,
            descripcion = @descripcion,
            goze = @goze,
            horas = @horas,
            id_usuario = @id_usuario,
            hora_registro = CONVERT(CHAR(5), GETDATE(), 108), -- Actualiza la hora actual
            fecha_registro = CONVERT(DATE, GETDATE()), -- Actualiza la fecha actual
			ID_Estatus = @ID_Estatus
        WHERE id_incidencia = @id_incidencia;

        -- Confirmación de éxito
        SELECT 'Registro actualizado exitosamente.' AS Mensaje, @id_incidencia AS ID_Incidencia;

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
