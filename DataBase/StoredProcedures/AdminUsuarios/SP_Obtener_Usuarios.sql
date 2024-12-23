USE NEO_GENESIS
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SP_Obtener_Usuarios') AND type IN (N'P', N'PC'))
BEGIN
    DROP PROCEDURE SP_Obtener_Usuarios;
END
GO

CREATE PROCEDURE SP_Obtener_Usuarios
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        U.*,
        CASE 
            WHEN ANU.Id IS NOT NULL THEN CAST(1 AS BIT) -- Existe en AspNetUsers
            ELSE CAST(0 AS BIT) -- No existe en AspNetUsers
        END AS ExistsInAspNetUsers,
		ANU.UserName AS Nom_Usuario_Web
    FROM USUARIO U
    LEFT JOIN AspNetUsers ANU ON U.id_usuario = ANU.id_usuario;
END
GO

