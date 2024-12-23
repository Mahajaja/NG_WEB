USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Borrar_Ubicaciones_X_Empleado')
BEGIN
    DROP PROCEDURE SP_Borrar_Ubicaciones_X_Empleado
END
GO

CREATE PROCEDURE SP_Borrar_Ubicaciones_X_Empleado
    @Id_Empleado INT
AS
BEGIN
    BEGIN TRY
        -- Eliminar todas las ubicaciones asociadas al empleado
        DELETE FROM Ubicaciones_X_Empleado
        WHERE id_Empleado = @Id_Empleado;
    END TRY
    BEGIN CATCH
        -- Manejar errores
        THROW;
    END CATCH
END;
