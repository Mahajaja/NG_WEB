USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es as�, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_GetMenusByUserID')
BEGIN
    DROP PROCEDURE sp_GetMenusByUserID
END
GO

-- Crea el Stored Procedure nuevamente
CREATE PROCEDURE sp_GetMenusByUserID
    @ID_Usuario NVARCHAR(450)
AS
BEGIN
    -- Manejo de errores
    BEGIN TRY
        -- Verificamos si el usuario tiene men�s asignados
        IF EXISTS (SELECT 1 FROM Menu_Usuario WHERE ID_Usuario = @ID_Usuario)
        BEGIN
            -- Seleccionamos los men�s a los que tiene acceso el usuario
            SELECT M.ID_Menu, 
                   M.Nombre_Menu, 
                   M.ID_PadreMenu, 
                   M.Fecha_Inserto
            FROM Menu M
            INNER JOIN Menu_Usuario MU ON M.ID_Menu = MU.ID_Menu
            WHERE MU.ID_Usuario = @ID_Usuario
            ORDER BY M.ID_PadreMenu, M.ID_Menu; -- Ordenar por men� padre y luego por ID de men�
        END
        ELSE
        BEGIN
            -- Si no tiene men�s asignados, devolvemos un mensaje indicando eso
            PRINT 'El usuario no tiene men�s asignados.'
        END
    END TRY
    BEGIN CATCH
        -- En caso de error, devolvemos informaci�n relevante sobre el problema
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO
