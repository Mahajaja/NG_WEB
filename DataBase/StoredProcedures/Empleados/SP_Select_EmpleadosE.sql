
USE NEO_GENESIS
GO


-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Select_Empleados')
BEGIN
    DROP PROCEDURE SP_Select_Empleados
END
GO

CREATE PROCEDURE SP_Select_Empleados
AS
BEGIN
    SELECT 
        E.id_empleado,
        E.nombre,
        E.apellido_paterno,
		E.apellido_materno,
        P.descripcion
    FROM 
        EMPLEADO E
		INNER JOIN PUESTO P ON E.id_puesto = P.id_puesto;
END;
