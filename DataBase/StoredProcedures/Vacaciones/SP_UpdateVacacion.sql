USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_UpdateVacacion')
BEGIN
    DROP PROCEDURE SP_UpdateVacacion
END
GO

CREATE PROCEDURE SP_UpdateVacacion
    @IdVacacion INT,
    @FolioRegistro CHAR(20),
    @FechaRegistro CHAR(10),
    @HoraRegistro CHAR(8),
    @IdUbicacion INT,
    @IdEmpleado INT,
    @FechaInicio CHAR(10),
    @FechaFin CHAR(10),
    @DiasVacacion INT,
    @FechaIncorporacion CHAR(10),
    @DiasRestantes INT,
    @Observaciones NVARCHAR(MAX),
    @IdUsuario INT
AS
BEGIN
    UPDATE VACACIONES
    SET folio_registro = @FolioRegistro,
        fecha_registro = @FechaRegistro,
        hora_registro = @HoraRegistro,
        id_ubicacion = @IdUbicacion,
        id_empleado = @IdEmpleado,
        fecha_inicio = @FechaInicio,
        fecha_fin = @FechaFin,
        dias_vacacion = @DiasVacacion,
        fecha_incorporacion = @FechaIncorporacion,
        dias_restantes = @DiasRestantes,
        observaciones = @Observaciones,
        id_usuario = @IdUsuario
    WHERE id_vacacion = @IdVacacion;
END
