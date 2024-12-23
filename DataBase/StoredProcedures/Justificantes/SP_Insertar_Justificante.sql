USE NEO_GENESIS
GO

IF OBJECT_ID('SP_Insertar_Justificante', 'P') IS NOT NULL
    DROP PROCEDURE SP_Insertar_Justificante;
GO

CREATE PROCEDURE SP_Insertar_Justificante
    @id_ubicacion INT,
    @id_empleado INT,
    @naturaleza_permiso NVARCHAR(100),
    @especificacion_permiso VARCHAR(100),
    @permiso_solicitado NVARCHAR(100),
    @otro_permiso NVARCHAR(100),
    @fecha_falta CHAR(10),
    @horas_parcial CHAR(5),
    @pago_horas VARCHAR(50),
    @observacion NVARCHAR(255),
    @sueldos VARCHAR(50),
    @id_usuario INT,
    @fecha_fin CHAR(10),
    @institucion VARCHAR(50),
    @otra_institucion NVARCHAR(100)
AS
BEGIN
    DECLARE @ID_Estatus INT = (SELECT E.ID_Estatus 
                               FROM Estatus E
                               INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
                               WHERE E.Estatus = 'EN REVISION' 
                               AND TE.TipoEstatus = 'Justificante');
    
    DECLARE @fecha_registro CHAR(10) = CONVERT(CHAR(10), GETDATE(), 23); -- Obtiene solo la fecha
    DECLARE @hora_registro CHAR(8) = CONVERT(CHAR(8), GETDATE(), 108); -- Obtiene solo la hora
    DECLARE @folio_registro CHAR(20) = 'J' + CAST(NEXT VALUE FOR dbo.Seq_Justificante AS VARCHAR); -- Asigna el folio con prefijo 'J' y un valor único

    INSERT INTO Justificante (
        fecha_registro,
        hora_registro,
        folio_registro,
        id_ubicacion,
        id_empleado,
        naturaleza_permiso,
        especificacion_permiso,
        permiso_solicitado,
        otro_permiso,
        fecha_falta,
        horas_parcial,
        pago_horas,
        observacion,
        sueldos,
        id_usuario,
        fecha_fin,
        institucion,
        otra_institucion,
        ID_Estatus
    )
    VALUES (
        @fecha_registro,
        @hora_registro,
        @folio_registro,
        @id_ubicacion,
        @id_empleado,
        @naturaleza_permiso,
        @especificacion_permiso,
        @permiso_solicitado,
        @otro_permiso,
        @fecha_falta,
        @horas_parcial,
        @pago_horas,
        @observacion,
        @sueldos,
        @id_usuario,
        @fecha_fin,
        @institucion,
        @otra_institucion,
        @ID_Estatus
    );
END;
GO
