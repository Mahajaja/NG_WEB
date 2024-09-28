--USE db_aad2f8_neogenesis
USE NEO_GENESIS
GO

-- Crear tabla AspNetRoles

CREATE TABLE AspNetRoles (
    Id NVARCHAR(128) NOT NULL PRIMARY KEY,
    Name NVARCHAR(256) NOT NULL
);

-- Crear índice único en el campo Name de AspNetRoles
CREATE UNIQUE INDEX RoleNameIndex ON AspNetRoles(Name);
GO

-- Inserción de registros en la tabla AspNetRoles
INSERT INTO AspNetRoles (Id, Name)
VALUES
('7ebfe35b-1916-4cda-8764-30e58ee8359c', 'Administrador'),
('8e7cdd51-9de5-4482-9009-c10b80424d2b', 'Colaborador'),
('1cb15730-dad6-42a7-8cce-abcb647e6478', 'Gerente'),
('c394e981-b01d-48c8-822c-a527645706c6', 'Lector'),
('311cccc6-0a27-4f15-b856-1f03df84cff3', 'SuperAdmin');
GO

SELECT * FROM USUARIO

-- Crear tabla AspNetUsers
CREATE TABLE AspNetUsers (
    Id NVARCHAR(128) NOT NULL PRIMARY KEY,
    id_usuario INT NOT NULL,
	id_empleado INT,
    Email NVARCHAR(256),
    EmailConfirmed BIT NOT NULL,
    PasswordHash NVARCHAR(MAX),
    SecurityStamp NVARCHAR(MAX),
    PhoneNumber NVARCHAR(MAX),
    PhoneNumberConfirmed BIT NOT NULL,
    TwoFactorEnabled BIT NOT NULL,
    LockoutEndDateUtc DATETIME,
    LockoutEnabled BIT NOT NULL,
    AccessFailedCount INT NOT NULL,
    UserName NVARCHAR(256) NOT NULL
);

-- Crear índice único en el campo UserName de AspNetUsers
CREATE UNIQUE INDEX UserNameIndex ON AspNetUsers(UserName);

-- Inserción de registros con valores para la columna Id
-- Inserción de registros con valores para la columna Id
INSERT INTO AspNetUsers (Id, id_usuario, id_empleado, Email, EmailConfirmed, PasswordHash, SecurityStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEndDateUtc, LockoutEnabled, AccessFailedCount, UserName)
VALUES
('0efdcc8e-7ac9-4ce5-810e-6bb33ed034f7', 0, NULL, 'spadmin@nggg.com', 0, 'AGIhjnlgVusiHx43NcnHTfUmZswCB4p/Sz5mvk7HIy75f5WiczLx92H5Y2DygF/xTw==', 'b04cdfdb-a717-4ea7-8e1e-d3c7544ef982', NULL, 0, 0, NULL, 0, 0, 'spadmin'),
('340110e0-baea-4427-a3c0-562c43500d83', 2, 13, 'GERENCIA@nggg.com', 0, 'AAuIlHAXdIDFiPg5cjj6/fJ6u2/nmy2YyE/j7B+YSwKwtIEX2x3dtX+Iaz+b1/hluA==', 'c94cbace-de35-497f-87f9-89731ddc6bbb', NULL, 0, 0, NULL, 0, 0, 'GERENCIA'),
('e208a1ee-43e8-4377-a122-5885882d888d', 3, 7, 'USUARIO3@nggg.com', 0, 'AKEkbxvxFgPtd49xDAub0BllUf9HQvtff4+b+2MmlwPyA887ecBokKdnC8ixPHE/Dw==', 'a7e0b813-bc7c-4133-abbb-1ac1103d61b1', NULL, 0, 0, NULL, 0, 0, 'USUARIO3'),
('6f126fc5-6963-476c-949a-9f67a3570055', 4, 14, 'COOR.RH@nggg.com', 0, 'ABmgBkRxUNEps5pHYUcLuC1x/jDqPaXk15ojXnLgeeNW9L4W75xym4Bm0GuKkYYShw==', '09c095b5-9b9c-4539-aad0-d882ec74b9ed', NULL, 0, 0, NULL, 0, 0, 'COOR.RH'),
('7b004fba-fac1-42e6-b453-f2c25783654c', 5, 10, 'TI@nggg.com', 0, 'AFZ3LQBaEtV+Pi8aH8HY0Nt84w0mLzwvBxmJ2CaJgSYhJli9iPu3dD4er3KkLGsF6w==', '6ab77d98-6ff3-46b4-b109-80c380f69317', NULL, 0, 0, NULL, 0, 0, 'TI'),
('562c3934-591c-49a6-ab8f-1275399f97c1', 10, 34, 'PRODUCCION@nggg.com', 0, 'AJ2oJLjrtRg+8LUXxTqdLrvM+OE4O1pCDEFGPZ2ArXvvnxKpRnUdYnPlgHhf1Fx8Zw==', '371424fa-779c-4259-b03c-d4e752faab08', NULL, 0, 0, NULL, 0, 0, 'PRODUCCION'),
('d304d418-f456-4f22-a827-d2c81e4dfd13', 11, 10, 'GESTION@nggg.com', 0, 'AFtdtD0T1z61ADHb1mGZbGChFQfXIjXC4sCc77SqHazmdZW6pAxpWinczOj9b2K9uw==', 'f2d25c86-96a5-49fd-b9c1-6520d255f8dd', NULL, 0, 0, NULL, 0, 0, 'GESTION');

GO

USE NEO_GENESIS
GO
-- Crear tabla AspNetUserRoles (relación entre usuarios y roles)
CREATE TABLE AspNetUserRoles (
    UserId NVARCHAR(128) NOT NULL,
    RoleId NVARCHAR(128) NOT NULL,
    PRIMARY KEY (UserId, RoleId),
    CONSTRAINT FK_AspNetUserRoles_AspNetUsers FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE,
    CONSTRAINT FK_AspNetUserRoles_AspNetRoles FOREIGN KEY (RoleId) REFERENCES AspNetRoles(Id) ON DELETE CASCADE
);
GO

-- Inserción de registros en la tabla AspNetUserRoles
INSERT INTO AspNetUserRoles (UserId, RoleId)
VALUES
('0efdcc8e-7ac9-4ce5-810e-6bb33ed034f7', '311cccc6-0a27-4f15-b856-1f03df84cff3'), -- SuperAdmin
('340110e0-baea-4427-a3c0-562c43500d83', '7ebfe35b-1916-4cda-8764-30e58ee8359c'), -- Administrador
('e208a1ee-43e8-4377-a122-5885882d888d', '8e7cdd51-9de5-4482-9009-c10b80424d2b'), -- Colaborador
('6f126fc5-6963-476c-949a-9f67a3570055', '8e7cdd51-9de5-4482-9009-c10b80424d2b'), -- Colaborador
('7b004fba-fac1-42e6-b453-f2c25783654c', '7ebfe35b-1916-4cda-8764-30e58ee8359c'), -- Administrador
('562c3934-591c-49a6-ab8f-1275399f97c1', '7ebfe35b-1916-4cda-8764-30e58ee8359c'), -- Administrador
('d304d418-f456-4f22-a827-d2c81e4dfd13', '7ebfe35b-1916-4cda-8764-30e58ee8359c'); -- Administrador
GO

USE NEO_GENESIS
GO
-- Crear tabla AspNetUserClaims (reclamaciones de usuarios)
CREATE TABLE AspNetUserClaims (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserId NVARCHAR(128) NOT NULL,
    ClaimType NVARCHAR(MAX),
    ClaimValue NVARCHAR(MAX),
    CONSTRAINT FK_AspNetUserClaims_AspNetUsers FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

-- Crear tabla AspNetUserLogins (logins externos de usuarios)
CREATE TABLE AspNetUserLogins (
    LoginProvider NVARCHAR(128) NOT NULL,
    ProviderKey NVARCHAR(128) NOT NULL,
    UserId NVARCHAR(128) NOT NULL,
    PRIMARY KEY (LoginProvider, ProviderKey, UserId),
    CONSTRAINT FK_AspNetUserLogins_AspNetUsers FOREIGN KEY (UserId) REFERENCES AspNetUsers(Id) ON DELETE CASCADE
);

-- Crear índices
CREATE INDEX IX_AspNetUserRoles_UserId ON AspNetUserRoles(UserId);
CREATE INDEX IX_AspNetUserRoles_RoleId ON AspNetUserRoles(RoleId);
CREATE INDEX IX_AspNetUserClaims_UserId ON AspNetUserClaims(UserId);
CREATE INDEX IX_AspNetUserLogins_UserId ON AspNetUserLogins(UserId);
GO

USE NEO_GENESIS
GO

CREATE TABLE Menu (
    ID_Menu INT PRIMARY KEY IDENTITY(1,1),
    Nombre_Menu NVARCHAR(100) NOT NULL,
    ID_PadreMenu INT DEFAULT 0, -- Para identificar menús padres
    Controlador NVARCHAR(100) DEFAULT '', -- Nombre del controlador
    Accion NVARCHAR(100) DEFAULT '', -- Nombre de la acción
    Icono NVARCHAR(100) DEFAULT 'fa-default', -- Nombre del icono (FontAwesome o similar)
    EsVisible BIT DEFAULT 1, -- Columna para indicar visibilidad del menú
    Fecha_Inserto DATETIME DEFAULT GETDATE() -- Fecha de inserción
);
GO


USE NEO_GENESIS
GO
CREATE TABLE Menu_Usuario (
    ID_Menu_Usuario INT PRIMARY KEY IDENTITY(1,1),
    ID_Menu INT NOT NULL,
    ID_Usuario NVARCHAR(450) NOT NULL,
    CONSTRAINT FK_Menu_Usuario_Menu FOREIGN KEY (ID_Menu) REFERENCES Menu(ID_Menu)
);
GO

USE NEO_GENESIS
GO

INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Almacén', NULL, 'fa-archive');  -- Icono de archivo para Almacén
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Compras', NULL, 'fa-shopping-cart');  -- Icono de carrito de compras para Compras
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Certificaciones', NULL, 'fa-certificate');  -- Icono de certificado para Certificaciones
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Comprobación de gastos', NULL, 'fa-money');  -- Icono de cheque para Comprobación de Gastos
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Institucional', NULL, 'fa-university');  -- Icono de universidad para Institucional
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Mantenimiento', NULL, 'fa-wrench');  -- Icono de herramientas para Mantenimiento
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Producción', NULL, 'fa-industry');  -- Icono de fábrica para Producción
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Proyectos Especiales', NULL, 'fa-tags');  -- Icono de proyectos para Proyectos Especiales
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Recursos Humanos', NULL, 'fa-users');  -- Icono de usuarios para Recursos Humanos
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Vehículos', NULL, 'fa-car');  -- Icono de automóvil para Vehículos
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Ventas', NULL, 'fa-dollar-sign');  -- Icono de dólar para Ventas
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Catálogos', NULL, 'fa-book');  -- Icono de libro para Catálogos

GO

USE NEO_GENESIS
GO
-- Declaración de variables para almacenar los IDs de los menús principales
DECLARE @ID_PADRE_Almacen INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Almacén');
DECLARE @ID_PADRE_Compras INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Compras');
DECLARE @ID_PADRE_Certificaciones INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Certificaciones');
DECLARE @ID_PADRE_ComprobacionGastos INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Comprobación de gastos');
DECLARE @ID_PADRE_Institucional INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Institucional');
DECLARE @ID_PADRE_Mantenimiento INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Mantenimiento');
DECLARE @ID_PADRE_Produccion INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Producción');
DECLARE @ID_PADRE_ProyectosEspeciales INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Proyectos Especiales');
DECLARE @ID_PADRE_RecursosHumanos INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Recursos Humanos');
DECLARE @ID_PADRE_Vehiculos INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Vehículos');
DECLARE @ID_PADRE_Ventas INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Ventas');
DECLARE @ID_PADRE_Catalogos INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Catálogos');

-- Almacén Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Registro de Almacén', @ID_PADRE_Almacen, '', '', 'fa-clipboard-list');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta de Productos', @ID_PADRE_Almacen, '', '', 'fa-box');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Entradas', @ID_PADRE_Almacen, '', '', 'fa-arrow-down');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Salidas', @ID_PADRE_Almacen, '', '', 'fa-arrow-up');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Traspasos', @ID_PADRE_Almacen, '', '', 'fa-exchange-alt');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Asignación de Maquinaria', @ID_PADRE_Almacen, '', '', 'fa-truck-moving');

-- Compras Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta de Proveedores', @ID_PADRE_Compras, '', '', 'fa-user-tie');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Solicitud de Compra', @ID_PADRE_Compras, '', '', 'fa-file-invoice');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Orden de Compra', @ID_PADRE_Compras, '', '', 'fa-file-contract');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Fondo Fijo', @ID_PADRE_Compras, '', '', 'fa-wallet');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Cotizaciones', @ID_PADRE_Compras, '', '', 'fa-dollar-sign');

-- Certificaciones Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Calendario de Certificaciones', @ID_PADRE_Certificaciones, '', '', 'fa-calendar');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Certificados', @ID_PADRE_Certificaciones, '', '', 'fa-certificate');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Manuales', @ID_PADRE_Certificaciones, '', '', 'fa-book');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Análisis de Laboratorio', @ID_PADRE_Certificaciones, '', '', 'fa-flask');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Lista de Productos Permitidos', @ID_PADRE_Certificaciones, '', '', 'fa-list');

-- Comprobación de Gastos Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Ingreso', @ID_PADRE_ComprobacionGastos, '', '', 'fa-sign-in-alt');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Egresos', @ID_PADRE_ComprobacionGastos, '', '', 'fa-sign-out-alt');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Solicitud de Reembolso', @ID_PADRE_ComprobacionGastos, '', '', 'fa-money-check');

-- Institucional Submenú
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Documentos Oficiales', @ID_PADRE_Institucional, '', '', 'fa-file-alt');

-- Mantenimiento Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Solicitud de mantenimiento', @ID_PADRE_Mantenimiento, '', '', 'fa-wrench');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Mantenimientos Generales', @ID_PADRE_Mantenimiento, '', '', 'fa-toolbox');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Mis Mantenimientos', @ID_PADRE_Mantenimiento, '', '', 'fa-screwdriver');

-- Producción Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Combustibles', @ID_PADRE_Produccion, '', '', 'fa-gas-pump');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Fertilización', @ID_PADRE_Produccion, '', '', 'fa-seedling');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Fumigadas', @ID_PADRE_Produccion, '', '', 'fa-spray-can');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Labores Culturales', @ID_PADRE_Produccion, '', '', 'fa-leaf');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Plagas y Enfermedades', @ID_PADRE_Produccion, '', '', 'fa-bug');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Proyectos Especiales', @ID_PADRE_Produccion, '', '', 'fa-project-diagram');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Uso del Agua', @ID_PADRE_Produccion, '', '', 'fa-water');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Plan de Trabajo Semanal', @ID_PADRE_Produccion, '', '', 'fa-calendar-check');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Estación Meteorológica', @ID_PADRE_Produccion, '', '', 'fa-cloud-sun');

-- Proyectos Especiales Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Nueva obra', @ID_PADRE_ProyectosEspeciales, '', '', 'fa-hammer');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Modificación Estructural', @ID_PADRE_ProyectosEspeciales, '', '', 'fa-drafting-compass');

-- Recursos Humanos Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta del Empleado', @ID_PADRE_RecursosHumanos, '', '', 'fa-user-plus');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Solicitud de Vacaciones', @ID_PADRE_RecursosHumanos, 'Solicitud_Vacaciones', 'Index', 'fa-calendar');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Incidencias', @ID_PADRE_RecursosHumanos, '', '', 'fa-exclamation-circle');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Solicitud de Préstamos', @ID_PADRE_RecursosHumanos, '', '', 'fa-hand-holding-usd');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Horas Extras', @ID_PADRE_RecursosHumanos, '', '', 'fa-clock');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Asistencia', @ID_PADRE_RecursosHumanos, '', '', 'fa-calendar-check');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Asignación de Equipo', @ID_PADRE_RecursosHumanos, '', '', 'fa-laptop');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Solicitud de Justificante Laboral', @ID_PADRE_RecursosHumanos, '', '', 'fa-file-alt');

-- Vehículos Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Revisión Trimestral', @ID_PADRE_Vehiculos, '', '', 'fa-calendar-check');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Eventos Unidades', @ID_PADRE_Vehiculos, '', '', 'fa-car');

-- Ventas Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Programación de Cortes', @ID_PADRE_Ventas, '', '', 'fa-calendar-alt');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Nacional', @ID_PADRE_Ventas, '', '', 'fa-globe');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Caído', @ID_PADRE_Ventas, '', '', 'fa-leaf');

-- Catálogos Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta Categoría', @ID_PADRE_Catalogos, '', '', 'fa-list-alt');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta Departamento', @ID_PADRE_Catalogos, '', '', 'fa-building');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta Maquinaria', @ID_PADRE_Catalogos, '', '', 'fa-cogs');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta Mobiliario', @ID_PADRE_Catalogos, '', '', 'fa-couch');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta Subcategoría', @ID_PADRE_Catalogos, '', '', 'fa-list-ul');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta Ubicaciones', @ID_PADRE_Catalogos, '', '', 'fa-map-marker-alt');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta Vehículos', @ID_PADRE_Catalogos, '', '', 'fa-car');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Alta Ventas (Calibres)', @ID_PADRE_Catalogos, '', '', 'fa-chart-bar');
GO



USE NEO_GENESIS
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

--------------------------- MODIFICANDO LLAVES FORANEAS ---------------------------------
USE NEO_GENESIS
GO
--EMPLEADO
ALTER TABLE EMPLEADO
DROP CONSTRAINT FK__EMPLEADO__id_usu__74794A92;
go

CREATE UNIQUE INDEX UX_id_usuario_ASPNETUser ON AspNetUsers(id_usuario);
go
ALTER TABLE EMPLEADO
ADD CONSTRAINT FK_id_usuario_ASPNETUser
FOREIGN KEY (id_usuario) 
REFERENCES AspNetUsers(id_usuario);

go

--VACACIONES

ALTER TABLE VACACIONES
DROP CONSTRAINT FK__VACACIONE__id_us__65F62111;
go

ALTER TABLE VACACIONES
ADD CONSTRAINT FK_id_usuario_ASPNETUser_VACACIONES
FOREIGN KEY (id_usuario) 
REFERENCES AspNetUsers(id_usuario);

go

-- CATEGORIA
ALTER TABLE CATEGORIA
DROP CONSTRAINT FK__CATEGORIA__id_us__56B3DD81;
go

ALTER TABLE CATEGORIA
ADD CONSTRAINT FK_id_usuario_ASPNETUser_CATEGORIA
FOREIGN KEY (id_usuario) 
REFERENCES AspNetUsers(id_usuario);
go

-- SUBCATEGORIA
ALTER TABLE SUBCATEGORIA
DROP CONSTRAINT FK__SUBCATEGO__id_us__6225902D;
go

ALTER TABLE SUBCATEGORIA
ADD CONSTRAINT FK_id_usuario_ASPNETUser_SUBCATEGORIA
FOREIGN KEY (id_usuario) 
REFERENCES AspNetUsers(id_usuario);

go







--SELECT * FROM AspNetUsers
--SELECT * FROM USUARIO
--UPDATE AspNetUsers
--SET UserName = 'spadmin'
--WHERE Id = 'd36b7f68-6eff-412e-a52c-593ed30c6d44'