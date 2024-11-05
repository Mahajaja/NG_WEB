--USE NEO_GENESIS
USE db_aad2f8_neogenesis
GO

-- Borrar el procedimiento almacenado si ya existe
IF OBJECT_ID('SP_ObtenerHorasExtras', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerHorasExtras;
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_ObtenerHorasExtras
AS
BEGIN
	    -- Ejecutar la consulta deseada
    SELECT HE.*, 
			EST.Estatus, 
			E.nombre, 
			E.apellido_paterno,
			E.apellido_materno,
			E.fecha_nacimiento
    FROM HORAS_EXTRAS HE
    INNER JOIN EMPLEADO E ON HE.id_empleado = E.id_empleado
	INNER JOIN Estatus EST ON HE.ID_Estatus = EST.ID_Estatus
END
GO
