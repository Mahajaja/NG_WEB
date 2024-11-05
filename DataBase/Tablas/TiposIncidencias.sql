USE NEO_GENESIS
GO

CREATE TABLE TiposIncidencias (
    ID_TipoIncidencias INT IDENTITY(1,1) PRIMARY KEY,
    TipoIncidencia NVARCHAR(255) NOT NULL
);

INSERT INTO TiposIncidencias (TipoIncidencia)
VALUES 
    ('Solicitud de dia de descanso'),
    ('Reporte'),
    ('Llamada de atención'),
    ('Solicitud de dia de descanso');

