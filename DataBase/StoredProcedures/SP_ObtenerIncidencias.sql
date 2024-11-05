USE NEO_GENESIS
GO

-- Borrar el procedimiento almacenado si ya existe
IF OBJECT_ID('SP_ObtenerIncidencias', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerIncidencias;
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_ObtenerIncidencias
AS
BEGIN
    -- Consulta para obtener todas las incidencias junto con los datos del empleado
    SELECT I.*, 
	EST.Estatus,
	E.nombre, 
	E.apellido_paterno,
	E.apellido_materno,
	E.fecha_nacimiento
    FROM INCIDENCIA I
    INNER JOIN EMPLEADO E ON I.id_empleado = E.id_empleado
	INNER JOIN Estatus EST ON I.ID_Estatus = EST.ID_Estatus
END
GO
