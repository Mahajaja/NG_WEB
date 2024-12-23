USE NEO_GENESIS
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SP_Obtener_Menus_ConEstado') AND type IN (N'P', N'PC'))
BEGIN
    DROP PROCEDURE SP_Obtener_Menus_ConEstado;
END
GO

CREATE PROCEDURE SP_Obtener_Menus_ConEstado
    @idUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @IDASP NVARCHAR(MAX)= (SELECT Id FROM AspNetUsers WHERE id_usuario = @idUsuario);
    SELECT 
        M.ID_Menu,
        M.Nombre_Menu, -- Reemplaza con los nombres de las columnas que necesites de la tabla Menu
       
        CASE 
            WHEN MU.ID_Usuario IS NOT NULL THEN CAST(1 AS BIT) -- Si existe en Menu_Usuario, retorna TRUE
            ELSE CAST(0 AS BIT) -- Si no existe, retorna FALSE
        END AS EstaAsignado
    FROM Menu M
    LEFT JOIN Menu_Usuario MU ON MU.ID_Menu = M.ID_Menu AND MU.ID_Usuario = @IDASP;
END
GO