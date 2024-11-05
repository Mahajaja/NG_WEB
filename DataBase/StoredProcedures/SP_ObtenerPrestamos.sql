USE NEO_GENESIS
GO

IF OBJECT_ID('SP_ObtenerPrestamos', 'P') IS NOT NULL
    DROP PROCEDURE SP_ObtenerPrestamos;
GO

CREATE PROCEDURE SP_ObtenerPrestamos
AS
BEGIN
    SELECT 
        P.id_prestamo,
        P.folio_prestamo,
        P.hora_registro,
        P.fecha_registro,
        P.id_ubicacion,
        P.id_empleado,
        P.cantidad_autorizada,
        P.descuento_semanal,
        P.fecha_entrega,
        P.fecha_inicio,
        P.fecha_fin,
        P.motivo,
        P.id_usuario,
        P.ID_Estatus,
		EST.Estatus,
		E.nombre, 
			E.apellido_paterno,
			E.apellido_materno,
			E.fecha_nacimiento
    FROM PRESTAMO P
	INNER JOIN ESTATUS EST ON P.ID_Estatus = EST.ID_Estatus
	INNER JOIN EMPLEADO E ON P.id_empleado = E.id_empleado
END;
GO
