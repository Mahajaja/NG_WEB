USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_Select_Instalacion_ById', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_Select_Instalacion_ById;
END
GO

CREATE PROCEDURE SP_Select_Instalacion_ById
    @id_instalacion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        id_instalacion,
        folio_instalacion,
        fecha_registro,
        hora_registro,
        id_ubicacion,
        id_almacen,
        nombre,
        uso,
        id_usuario,
        descripcion
    FROM 
        INSTALACION
    WHERE 
        id_instalacion = @id_instalacion;
END;
