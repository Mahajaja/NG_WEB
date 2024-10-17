USE NEO_GENESIS
GO

-- Crear la tabla TipoEvidencias si no existe
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TipoEvidencias]') AND type in (N'U'))
BEGIN
    CREATE TABLE TipoEvidencias
    (
        ID_TipoEvidencia INT IDENTITY(1,1) PRIMARY KEY,  -- Clave primaria autoincrementable
        TipoEvidencia NVARCHAR(255) NOT NULL            -- Descripción del tipo de evidencia: Es importante que vaya el nombre exacto de la tabla
    );
END;
GO
INSERT INTO TipoEvidencias (TipoEvidencia)
VALUES ('HORAS_EXTRAS');