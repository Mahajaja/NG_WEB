USE NEO_GENESIS
GO


IF OBJECT_ID('dbo.SP_ObtenerInstalacionesPorUbicacion', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SP_ObtenerInstalacionesPorUbicacion;
GO


CREATE PROCEDURE SP_ObtenerInstalacionesPorUbicacion
    @IdUbicacion INT
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
        Instalacion

		
SELECT * FROM UBICACION
    WHERE 
        id_ubicacion = @IdUbicacion;
END;

