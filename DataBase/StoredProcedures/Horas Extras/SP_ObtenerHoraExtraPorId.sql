USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_ObtenerHoraExtraPorId')
BEGIN
    DROP PROCEDURE SP_ObtenerHoraExtraPorId
END
GO

CREATE PROCEDURE [dbo].[SP_ObtenerHoraExtraPorId]
    @id_horaExtra INT
AS
BEGIN
    BEGIN TRY
        -- Selecciona los datos de la tabla Horas Extra por ID
        SELECT 
            he.id_horaExtra,
            he.folio_registro,
            he.fecha_registro,
            he.hora_registro,
            he.id_empleado,
            he.id_responsable,
            he.fecha_compensacion,
            he.costo_horaExtra,
            he.costo_horaDoble,
            he.horas_porPagar,
            he.costo_horaTriple,
            he.hora_triple,
            he.total_horaDoble,
            he.total_horaTriple,
            he.total_aPagar,
            he.motivo_hraExtra,
            he.observaciones,
            he.id_usuario,
            he.ID_Estatus,
            e.Nombre AS NombreEmpleado,
            e.apellido_paterno AS ApellidoPaternoEmpleado,
            e.apellido_materno AS ApellidoMaternoEmpleado
        FROM [dbo].[HORAS_EXTRAS] he
        LEFT JOIN [dbo].[EMPLEADO] e ON he.id_empleado = e.id_empleado
        WHERE he.id_horaExtra = @id_horaExtra;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
