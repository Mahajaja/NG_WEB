USE NEO_GENESIS
GO
-- Crear la tabla Evidencias con la llave foránea a TipoEvidencias
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Evidencias]') AND type in (N'U'))
BEGIN
    CREATE TABLE Evidencias
    (
        ID_Evidencia INT IDENTITY(1,1) PRIMARY KEY,     -- Clave primaria autoincrementable
        ID_Tabla INT NULL,								-- Relación con la tabla a la que va la evidencia
        Evidencia_Base64 NVARCHAR(MAX) NOT NULL,        -- Evidencia en formato Base64
        NombreArchivo NVARCHAR(255) NOT NULL,           -- Nombre del archivo asociado a la evidencia
        id_usuario INT NOT NULL,                        -- Usuario que insertó la evidencia
        FechaInserto DATETIME DEFAULT GETDATE(),        -- Fecha de inserción con valor por defecto la fecha actual
        ID_TipoEvidencia INT NOT NULL,                  -- Llave foránea que referencia a TipoEvidencias

        -- Definir la restricción de llave foránea
        CONSTRAINT FK_Evidencias_TipoEvidencias FOREIGN KEY (ID_TipoEvidencia)
        REFERENCES TipoEvidencias(ID_TipoEvidencia)
    );
END;
