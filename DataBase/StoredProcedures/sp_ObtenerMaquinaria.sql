USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('dbo.sp_ObtenerMaquinaria', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ObtenerMaquinaria;
GO

-- Creación del Stored Procedure
CREATE PROCEDURE [dbo].[sp_ObtenerMaquinaria]
    @id_ubicacion INT = NULL, -- Parámetro opcional para filtrar por id_ubicacion
    @id_categoria INT = NULL  -- Parámetro opcional para filtrar por id_categoria
AS
BEGIN
    SET NOCOUNT ON;

    -- Seleccionar todas las columnas de la tabla MAQUINARIA con filtros opcionales
    SELECT 
        id_maquinaria,
        no_economico,
        folio_registro,
        hora_registro,
        fecha_registro,
        marca,
        modelo,
        no_motor,
        especificacion,
        id_categoria_estado,
        id_ubicacion,
        id_categoria,
        id_subcategoria,
        img_maquinaria,
        img_factura,
        id_usuario
    FROM 
        MAQUINARIA
    WHERE 
        (@id_ubicacion IS NULL OR id_ubicacion = @id_ubicacion) AND
        (@id_categoria IS NULL OR id_categoria = @id_categoria)
    ORDER BY 
        id_maquinaria ASC; -- Ordenar por ID de maquinaria en orden ascendente
END;
GO


EXEC sp_ObtenerMaquinaria @id_ubicacion = 9, @id_categoria = 10;
