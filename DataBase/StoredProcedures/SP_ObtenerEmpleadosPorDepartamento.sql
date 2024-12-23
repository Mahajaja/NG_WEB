USE NEO_GENESIS;
GO

IF OBJECT_ID('dbo.SP_ObtenerEmpleadosPorDepartamento', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SP_ObtenerEmpleadosPorDepartamento;
GO


CREATE PROCEDURE SP_ObtenerEmpleadosPorDepartamento
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        E.id_empleado, 
        E.nombre, 
        E.apellido_paterno, 
        E.apellido_materno
    FROM EMPLEADO E
    INNER JOIN DEPARTAMENTO D ON E.id_departamento = D.id_departamento
     WHERE E.id_departamento = 11
      AND E.id_empleado IN (72, 73, 74);
END;
GO
