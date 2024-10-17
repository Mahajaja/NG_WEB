USE NEO_GENESIS
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
    SELECT * 
    FROM HORAS_EXTRAS HE
    INNER JOIN EMPLEADO E ON HE.id_empleado = E.id_empleado;
END
GO
