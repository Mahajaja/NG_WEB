USE NEO_GENESIS
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SP_Obtener_Usuario_PorId') AND type IN (N'P', N'PC'))
BEGIN
    DROP PROCEDURE SP_Obtener_Usuario_PorId;
END
GO

CREATE PROCEDURE SP_Obtener_Usuario_PorId
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        U.id_usuario,
        U.id_empleado,
        U.nom_usuario,
        U.permiso,
        U.contraseña,
        U.fecha_registro,
        U.hora_registro,
        CASE 
            WHEN ANU.Id IS NOT NULL THEN CAST(1 AS BIT) -- Existe en AspNetUsers
            ELSE CAST(0 AS BIT) -- No existe en AspNetUsers
        END AS ExistsInAspNetUsers,
		E.correo
    FROM USUARIO U
    LEFT JOIN AspNetUsers ANU ON U.id_usuario = ANU.id_usuario
	INNER JOIN EMPLEADO E ON U.id_empleado = E.id_empleado
    WHERE U.id_usuario = @IdUsuario;
END
GO
