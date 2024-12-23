USE NEO_GENESIS
GO


-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Insertar_Ubicaciones_X_Empleado')
BEGIN
    DROP PROCEDURE SP_Insertar_Ubicaciones_X_Empleado
END
GO

CREATE PROCEDURE SP_Insertar_Ubicaciones_X_Empleado
    @Id_Ubicacion INT,
    @Id_Empleado INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Ubicaciones_X_Empleado (id_Ubicacion, id_Empleado)
        VALUES (@Id_Ubicacion, @Id_Empleado);

        SELECT SCOPE_IDENTITY() AS ID_Ubicaciones_X_Empleado; -- Retorna el ID generado
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
