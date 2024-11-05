USE NEO_GENESIS
GO
CREATE TABLE Sanciones (
    ID_Sancion INT IDENTITY(1,1) PRIMARY KEY,
    Sancion NVARCHAR(255) NOT NULL
);

INSERT INTO Sanciones (Sancion)
VALUES 
    ('Horas'),
    ('Suspención de actividades'),
    ('Ninguna'),
    ('Día completo');
