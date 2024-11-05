USE NEO_GENESIS
GO

-- Borrar el procedimiento almacenado si ya existe
IF OBJECT_ID('SP_ObtenerJustificantes', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerJustificantes;
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_ObtenerJustificantes
AS
BEGIN
    -- Ejecutar la consulta deseada
    SELECT J.id_justificante, 
           J.fecha_registro, 
		   J.Permiso_solicitado,
           J.observacion, 
           EST.Estatus, 
           E.nombre, 
           E.apellido_paterno,
           E.apellido_materno,
           E.fecha_nacimiento,
		   P.nombre AS Puesto
    FROM JUSTIFICANTE J
    INNER JOIN EMPLEADO E ON J.id_empleado = E.id_empleado
    INNER JOIN Estatus EST ON J.ID_Estatus = EST.ID_Estatus
	INNER JOIN PUESTO P ON E.id_puesto = P.id_puesto
END
GO

