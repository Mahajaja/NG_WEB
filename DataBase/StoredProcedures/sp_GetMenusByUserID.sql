CREATE PROCEDURE sp_GetMenusByUserID
    @ID_Usuario NVARCHAR(450)
AS
BEGIN
    -- Seleccionamos los menús a los que tiene acceso el usuario
    SELECT M.ID_Menu, M.Nombre_Menu, M.ID_PadreMenu, M.Fecha_Inserto
    FROM Menu M
    INNER JOIN Menu_Usuario MU ON M.ID_Menu = MU.ID_Menu
    WHERE MU.ID_Usuario = @ID_Usuario;
END
--EXEC sp_GetMenusByUserID 'd36b7f68-6eff-412e-a52c-593ed30c6d44';
