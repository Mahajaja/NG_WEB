USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_GetSubMenusByParentID')
BEGIN
    DROP PROCEDURE sp_GetSubMenusByParentID
END
GO

-- Crea el Stored Procedure nuevamente
CREATE PROCEDURE sp_GetSubMenusByParentID
    @ID_PadreMenu INT,
    @ID_Usuario NVARCHAR(128) -- Especificamos el tamaño del NVARCHAR
AS
BEGIN
    SELECT 
        M.ID_Menu, 
        M.Nombre_Menu, 
        M.ID_PadreMenu, 
        M.Fecha_Inserto, 
        M.Controlador, 
        M.Accion,
        M.Icono -- Añadimos el campo Icono
    FROM Menu M
    INNER JOIN Menu_Usuario MU ON M.ID_Menu = MU.ID_Menu
    WHERE M.ID_PadreMenu = @ID_PadreMenu 
    AND MU.ID_Usuario = @ID_Usuario
END
GO
