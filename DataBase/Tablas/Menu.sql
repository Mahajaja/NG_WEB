CREATE TABLE Menu (
    ID_Menu INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Menu NVARCHAR(100) NOT NULL,
    ID_PadreMenu INT DEFAULT 0,
    Controlador NVARCHAR(100) DEFAULT '', -- Valor por defecto vacío
    Accion NVARCHAR(100) DEFAULT '', -- Valor por defecto vacío
    EsVisible BIT DEFAULT 1, -- Columna para indicar visibilidad del menú
    Fecha_Inserto DATETIME DEFAULT GETDATE()
);