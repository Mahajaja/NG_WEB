USE NEO_GENESIS
GO

-- Verificar si el procedimiento almacenado ya existe y eliminarlo
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GetVacacionesConFormato')
BEGIN
    DROP PROCEDURE SP_GetVacacionesConFormato
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_GetVacacionesConFormato
AS
BEGIN
    SET NOCOUNT ON;

    -- Seleccionar los datos y formatear las fechas
    SELECT 
		V.id_vacacion,
        E.nombre, 
        CONVERT(VARCHAR(10), V.fecha_inicio, 103) AS fecha_inicio,  -- Formato dd/MM/yyyy
        CONVERT(VARCHAR(10), V.fecha_incorporacion, 103) AS fecha_incorporacion,  -- Formato dd/MM/yyyy
        V.dias_vacacion, 
        EST.Estatus
    FROM VACACIONES V
    INNER JOIN EMPLEADO E ON V.id_empleado = E.id_empleado
    INNER JOIN Estatus EST ON V.ID_Estatus = EST.ID_Estatus
END
GO
