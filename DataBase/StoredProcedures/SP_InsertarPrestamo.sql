USE NEO_GENESIS
GO

IF OBJECT_ID('SP_InsertarPrestamo', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_InsertarPrestamo;
END
GO

CREATE PROCEDURE SP_InsertarPrestamo
    @id_ubicacion INT,
    @id_empleado INT,
    @cantidad_autorizada VARCHAR(50),
    @fecha_entrega CHAR(10),
    @motivo NVARCHAR(255),
    @id_usuario INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_prestamo INT;
    DECLARE @folio_prestamo CHAR(10);
	DECLARE @ID_ESTATUS INT = (SELECT E.ID_Estatus FROM Estatus E
INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
WHERE E.Estatus = 'EN REVISION' AND TE.TipoEstatus = 'Prestamo');
    -- Validación para ver si ya existe un préstamo con los mismos parámetros y borrarlo
    IF EXISTS (SELECT 1 FROM PRESTAMO WHERE id_ubicacion = @id_ubicacion AND id_empleado = @id_empleado)
    BEGIN
        DELETE FROM PRESTAMO WHERE id_ubicacion = @id_ubicacion AND id_empleado = @id_empleado;
    END

    -- Generar el nuevo ID y Folio del préstamo
    SET @id_prestamo = (SELECT ISNULL(MAX(id_prestamo), 0) + 1 FROM PRESTAMO);
    SET @folio_prestamo = CONCAT('P-', @id_prestamo);

    -- Insertar el nuevo registro
    INSERT INTO PRESTAMO (
        folio_prestamo,
        hora_registro,
        fecha_registro,
        id_ubicacion,
        id_empleado,
        cantidad_autorizada,
        fecha_entrega,
        motivo,
        id_usuario,
        ID_Estatus
    )
    VALUES (
        @folio_prestamo,
        CONVERT(CHAR(8), GETDATE(), 108),  -- Hora actual
        CONVERT(CHAR(10), GETDATE(), 23),  -- Fecha actual sin hora
        @id_ubicacion,
        @id_empleado,
        @cantidad_autorizada,
        @fecha_entrega,
        @motivo,
        @id_usuario,
        @ID_ESTATUS
    );
END;
GO

