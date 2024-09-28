USE NEO_GENESIS
GO

CREATE TABLE Menu (
    ID_Menu INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Menu NVARCHAR(100) NOT NULL,
    ID_PadreMenu INT NULL,
    Fecha_Inserto DATETIME DEFAULT GETDATE()
);


CREATE TABLE Menu_Usuario (
    ID_Menu_Usuario INT PRIMARY KEY IDENTITY(1,1),
    ID_Menu INT NOT NULL,
    ID_Usuario NVARCHAR(450) NOT NULL,
    CONSTRAINT FK_Menu_Usuario_Menu FOREIGN KEY (ID_Menu) REFERENCES Menu(ID_Menu)
);

/*GUARDANDO MENUS PRINCIPALES*/
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Almacén', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Compras', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Certificaciones', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Comprobación de gastos', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Institucional', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Mantenimiento', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Producción', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Proyectos Especiales', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Recursos Humanos', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Vehículos', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Ventas', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Catálogos', NULL);
GO

SELECT * FROM AspNetUsers
SELECT * FROM USUARIO
SELECT * FROM Menu
SELECT * FROM Menu_Usuario
GO


-- Insertamos el acceso del usuario al menú de Recursos Humanos
DECLARE @IDUSUARIO NVARCHAR(450) = (SELECT Id FROM AspNetUsers WHERE Email = 'COOR.RH@nggg.com');
DECLARE @ID_MENU INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Recursos Humanos');
INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU, @IDUSUARIO);
GO



/*ACCESO A TODOS LOS MENUS PARA SP*/
DECLARE @IDUSUARIO NVARCHAR(450) = (SELECT Id FROM AspNetUsers WHERE Email = 'spadmin@nggg.com');

-- Insertamos el acceso del usuario 'spadmin@nggg.com' a todos los menús
INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
SELECT ID_Menu, @IDUSUARIO FROM Menu;
GO

