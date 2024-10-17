USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_InsertVacacion')
BEGIN
    DROP PROCEDURE SP_InsertVacacion
END
GO

CREATE PROCEDURE SP_InsertVacacion
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
	DECLARE @IDEstatus INT = (SELECT ID_Estatus FROM Estatus E
							INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
							WHERE TE.TipoEstatus = 'Solicitud_Vacaciones' AND E.Estatus = 'EN REVISION')
    INSERT INTO VACACIONES(folio_registro, fecha_registro, hora_registro, id_ubicacion, id_empleado, fecha_inicio, fecha_fin, dias_vacacion, fecha_incorporacion, dias_restantes, observaciones, id_usuario, ID_Estatus)
    VALUES (@FolioRegistro, @FechaRegistro, @HoraRegistro, @IdUbicacion, @IdEmpleado, @FechaInicio, @FechaFin, @DiasVacacion, @FechaIncorporacion, @DiasRestantes, @Observaciones, @IdUsuario, @IDEstatus);
    
    -- Return the last inserted ID (optional)
    SELECT SCOPE_IDENTITY();
END