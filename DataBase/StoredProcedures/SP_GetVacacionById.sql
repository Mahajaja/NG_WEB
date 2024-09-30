USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GetVacacionById')
BEGIN
    DROP PROCEDURE SP_GetVacacionById
END
GO

CREATE PROCEDURE SP_GetVacacionById
    @IdVacacion INT
AS
BEGIN
    SELECT id_vacacion, folio_registro, fecha_registro, hora_registro, id_ubicacion, id_empleado, fecha_inicio, fecha_fin, dias_vacacion, fecha_incorporacion, dias_restantes, observaciones, id_usuario
    FROM VACACIONES
    WHERE id_vacacion = @IdVacacion;
END
