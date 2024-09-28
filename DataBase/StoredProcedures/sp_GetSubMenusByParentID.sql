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
    @ID_PadreMenu INT
AS
BEGIN
    SELECT 
        ID_Menu, 
        Nombre_Menu, 
        ID_PadreMenu, 
        Fecha_Inserto, 
        Controlador, 
        Accion,
        Icono -- Añadimos el campo Icono
    FROM Menu
    WHERE ID_PadreMenu = @ID_PadreMenu
END
GO
