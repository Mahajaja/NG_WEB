USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_GetMenusAndSubMenusByUserID')
BEGIN
    DROP PROCEDURE sp_GetMenusAndSubMenusByUserID
END
GO

-- Crea el Stored Procedure nuevamente
CREATE PROCEDURE sp_GetMenusAndSubMenusByUserID
    @ID_Usuario NVARCHAR(450) -- Ajusta el tipo de datos si es necesario
AS
BEGIN
    -- Manejo de errores
    BEGIN TRY
        -- Selección de menús y submenús asociados al usuario
        SELECT 
            M.ID_Menu, 
            M.Nombre_Menu, 
            M.ID_PadreMenu, 
            M.Fecha_Inserto,
            M.Controlador,   -- Incluir el controlador
            M.Accion,        -- Incluir la acción
            M.Icono          -- Incluir el icono si existe
        FROM 
            Menu M
        INNER JOIN 
            Menu_Usuario MU ON M.ID_Menu = MU.ID_Menu
        WHERE 
            MU.ID_Usuario = @ID_Usuario;
    END TRY
    BEGIN CATCH
        -- Captura y manejo de errores
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO
