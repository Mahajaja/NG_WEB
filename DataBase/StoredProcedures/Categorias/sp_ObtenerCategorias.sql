USE NEO_GENESIS
GO

IF OBJECT_ID('dbo.sp_ObtenerCategorias', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ObtenerCategorias;
GO

-- Crear el procedimiento almacenado
CREATE PROCEDURE sp_ObtenerCategorias
AS
BEGIN
    SET NOCOUNT ON;

    -- Obtener las categorías con id_categoria en (8, 9, 10, 29)
    SELECT 
        id_categoria,
        nombre_categoria,
        clasificacion,
        fecha_registro,
        hora_registro,
        id_usuario
    FROM 
        Categoria
    WHERE 
        id_categoria IN (8, 9, 10, 29)
    ORDER BY 
        fecha_registro DESC, hora_registro DESC;
END;
GO
