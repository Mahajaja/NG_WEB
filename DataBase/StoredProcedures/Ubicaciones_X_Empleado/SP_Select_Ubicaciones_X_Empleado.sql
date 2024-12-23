USE NEO_GENESIS
GO


-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Select_Ubicaciones_X_Empleado')
BEGIN
    DROP PROCEDURE SP_Select_Ubicaciones_X_Empleado
END
GO

CREATE PROCEDURE SP_Select_Ubicaciones_X_Empleado
    @Id_Empleado INT
AS
BEGIN
    SELECT 
        UXE.ID_Ubicaciones_X_Empleado,
        UXE.id_ubicacion,
        UE.Nombre AS NombreUbicacion,
        UXE.id_empleado
    FROM 
        Ubicaciones_X_Empleado UXE
    INNER JOIN 
        UBICACION UE ON UXE.id_Ubicacion = UE.id_ubicacion
    WHERE 
        UXE.id_empleado = @Id_Empleado;
END;
