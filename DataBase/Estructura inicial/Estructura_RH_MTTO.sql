/*
================================================================================================================================================
ESTRUCTURA DE BASE DE DATOS
================================================================================================================================================
*/
USE NEO_GENESIS
GO


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

CREATE TABLE Dias_inhabiles (
    ID_Dia_inhabil INT IDENTITY(1,1) PRIMARY KEY,  -- ID autoincremental para cada día inhábil
    Fecha_inhabil DATE NOT NULL,                   -- Fecha que se considera inhábil
    Descripcion NVARCHAR(255) NULL,                -- Descripción del motivo (opcional)
    Fecha_inserto DATETIME DEFAULT GETDATE(),      -- Fecha y hora de inserción del registro
    id_usuario INT NOT NULL                        -- ID del usuario que inserta el registro
);
GO

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

--INSERT INTO TipoEvidencias (TipoEvidencia)
--VALUES ('ORDEN_MTTO');

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
GO



USE NEO_GENESIS
GO

INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Almacén', NULL, 'fa-boxes-stacked');  -- Icono de archivo para Almacén
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
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Icono) VALUES ('Usuarios', NULL, 'fa-users');  -- Icono de libro para Catálogos
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
DECLARE @ID_PADRE_Usuarios INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Usuarios');

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
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Solicitud de mantenimiento', @ID_PADRE_Mantenimiento, 'Solicitud_Mantenimiento', 'Index', 'fa-wrench');
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
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Incidencias', @ID_PADRE_RecursosHumanos, 'Incidencias', 'Index', 'fa-exclamation-circle');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Solicitud de Préstamos', @ID_PADRE_RecursosHumanos, 'Solicitud_Prestamo', 'Index', 'fa-hand-holding-usd');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Horas Extras', @ID_PADRE_RecursosHumanos, 'HorasExtra', 'Index', 'fa-clock');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Asistencia', @ID_PADRE_RecursosHumanos, '', '', 'fa-calendar-check');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Asignación de Equipo', @ID_PADRE_RecursosHumanos, '', '', 'fa-laptop');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Solicitud de Justificante Laboral', @ID_PADRE_RecursosHumanos, 'Justificante_Laboral', 'Index', 'fa-file-alt');

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

--Usuarios
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion, Icono) VALUES ('Listado Usuarios', @ID_PADRE_Usuarios, 'AdminUsers', 'Index', 'fa-users');

GO



USE NEO_GENESIS
GO
-- Insertamos el acceso del usuario al menú de Recursos Humanos
DECLARE @IDUSUARIO NVARCHAR(450) = (SELECT Id FROM AspNetUsers WHERE Email = 'COOR.RH@nggg.com');
DECLARE @ID_MENU INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Recursos Humanos');
DECLARE @ID_MENU_Solicitud_Vacaciones INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Solicitud de Vacaciones');
DECLARE @ID_MENU_Incidencias INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Incidencias');
DECLARE @ID_MENU_Horas_Extra INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Horas Extras');
DECLARE @ID_MENU_Solicitud_Prestamo INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Solicitud de Préstamos');
DECLARE @ID_MENU_Justificante_Laboral INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Solicitud de Justificante Laboral');

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU, @IDUSUARIO);

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Solicitud_Vacaciones, @IDUSUARIO);

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Incidencias, @IDUSUARIO);

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Horas_Extra, @IDUSUARIO);


INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Solicitud_Prestamo, @IDUSUARIO);

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Justificante_Laboral, @IDUSUARIO);
GO

/*ACCESO A TODOS LOS MENUS PARA SP*/
DECLARE @IDUSUARIO NVARCHAR(450) = (SELECT Id FROM AspNetUsers WHERE Email = 'spadmin@nggg.com');

-- Insertamos el acceso del usuario 'spadmin@nggg.com' a todos los menús
INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
SELECT ID_Menu, @IDUSUARIO FROM Menu;
GO


/*ACCESO A TODOS LOS MENUS PARA SP*/
DECLARE @IDUSUARIO NVARCHAR(450) = (SELECT Id FROM AspNetUsers WHERE Email = 'TI@nggg.com');

-- Insertamos el acceso del usuario 'spadmin@nggg.com' a todos los menús
INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
SELECT ID_Menu, @IDUSUARIO FROM Menu;
GO

USE NEO_GENESIS
GO
-- Insertamos el acceso del usuario al menú de Recursos Humanos
DECLARE @IDUSUARIO NVARCHAR(450) = (SELECT Id FROM AspNetUsers WHERE Email = 'USUARIO3@nggg.com');
DECLARE @ID_MENU INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Recursos Humanos');
DECLARE @ID_MENU_Solicitud_Vacaciones INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Solicitud de Vacaciones');
DECLARE @ID_MENU_Incidencias INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Incidencias');
DECLARE @ID_MENU_Horas_Extra INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Horas Extras');
DECLARE @ID_MENU_Solicitud_Prestamo INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Solicitud de Préstamos');
DECLARE @ID_MENU_Justificante_Laboral INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Solicitud de Justificante Laboral');

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU, @IDUSUARIO);

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Solicitud_Vacaciones, @IDUSUARIO);

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Incidencias, @IDUSUARIO);

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Horas_Extra, @IDUSUARIO);


INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Solicitud_Prestamo, @IDUSUARIO);

INSERT INTO Menu_Usuario (ID_Menu, ID_Usuario)
VALUES (@ID_MENU_Justificante_Laboral, @IDUSUARIO);
GO



/*
*******************************************************************************************************************************
									EDITAMOS COLUMNAS DE BASE DE DATOS
*******************************************************************************************************************************
*/

-- Permitir NULL en la columna fecha_inicio
ALTER TABLE VACACIONES
ALTER COLUMN fecha_inicio CHAR(10) NULL;

-- Permitir NULL en la columna fecha_fin
ALTER TABLE VACACIONES
ALTER COLUMN fecha_fin CHAR(10) NULL;

-- Permitir NULL en la columna fecha_incorporacion
ALTER TABLE VACACIONES
ALTER COLUMN fecha_incorporacion CHAR(10) NULL;
GO

USE NEO_GENESIS
GO

ALTER TABLE [dbo].[INCIDENCIA]
ALTER COLUMN tipo_registro VARCHAR(10) NULL;
GO


USE NEO_GENESIS
GO


ALTER TABLE HORAS_EXTRAS
ALTER COLUMN id_empleado INT NULL;

ALTER TABLE HORAS_EXTRAS
ALTER COLUMN fecha_compensacion CHAR(10) NULL;

ALTER TABLE HORAS_EXTRAS
ALTER COLUMN motivo_hraExtra NVARCHAR(400) NULL;

ALTER TABLE JUSTIFICANTE
ALTER COLUMN naturaleza_permiso nvarchar(60) NULL;

ALTER TABLE JUSTIFICANTE
ALTER COLUMN permiso_solicitado nvarchar(100) NULL;

ALTER TABLE JUSTIFICANTE
ALTER COLUMN fecha_falta char(10) NULL;

ALTER TABLE JUSTIFICANTE
ALTER COLUMN horas_parcial char(2) NULL;

ALTER TABLE JUSTIFICANTE
ALTER COLUMN pago_horas varchar(50) NULL;

ALTER TABLE JUSTIFICANTE
ALTER COLUMN fecha_fin char(10) NULL;

ALTER TABLE JUSTIFICANTE
ALTER COLUMN institucion varchar(15) NULL;
GO



/*
*******************************************************************************************************************************
									AÑADIMOS COLUMNAS DE ESTATUS
*******************************************************************************************************************************
*/


CREATE TABLE TipoEstatus (
    ID_TipoEstatus INT IDENTITY(1,1) PRIMARY KEY,  -- ID autoincremental para el Tipo de Estatus
    TipoEstatus NVARCHAR(100) NOT NULL,            -- Nombre o descripción del estatus
    IsActivo BIT NOT NULL DEFAULT 1,               -- Indica si el estatus está activo (1 = Activo, 0 = Inactivo)
    FechaInserto DATETIME NOT NULL DEFAULT GETDATE() -- Fecha de inserción del registro
);

INSERT INTO TipoEstatus (TipoEstatus, IsActivo, FechaInserto)
VALUES ('Solicitud_Vacaciones', 1, GETDATE());

INSERT INTO TipoEstatus (TipoEstatus, IsActivo, FechaInserto)
VALUES ('Horas_Extra', 1, GETDATE());

INSERT INTO TipoEstatus (TipoEstatus, IsActivo, FechaInserto)
VALUES ('Incidencias', 1, GETDATE());

INSERT INTO TipoEstatus (TipoEstatus, IsActivo, FechaInserto)
VALUES ('Prestamo', 1, GETDATE());

INSERT INTO TipoEstatus (TipoEstatus, IsActivo, FechaInserto)
VALUES ('Justificante', 1, GETDATE());

CREATE TABLE Estatus (
    ID_Estatus INT IDENTITY(1,1) PRIMARY KEY,          -- ID autoincremental para cada estatus
    ID_TipoEstatus INT NOT NULL,                        -- Llave foránea de la tabla TipoEstatus
    Estatus NVARCHAR(100) NOT NULL,                    -- Nombre o descripción del estatus
    Color_Fondo NVARCHAR(20) NULL,                     -- Color de fondo (puede ser un código hexadecimal o nombre del color)
    Color_Texto NVARCHAR(20) NULL,                     -- Color del texto (puede ser un código hexadecimal o nombre del color)
    IsActivo BIT NOT NULL DEFAULT 1,                   -- Indica si el estatus está activo
    FechaInserto DATETIME NOT NULL DEFAULT GETDATE(),  -- Fecha de inserción del registro
    CONSTRAINT FK_TipoEstatus FOREIGN KEY (ID_TipoEstatus) REFERENCES TipoEstatus(ID_TipoEstatus) -- Llave foránea
);

-- Insertar "EN REVISION"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Solicitud_Vacaciones'), 
    'EN REVISION', 
    '#fbbc04',   -- Aquí puedes agregar el color de fondo
    '#000000',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "ACEPTADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Solicitud_Vacaciones'), 
    'ACEPTADA', 
    '#34a853',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "RECHAZADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Solicitud_Vacaciones'), 
    'RECHAZADA', 
    '#980000',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);


-- Insertar "EN REVISION" - HORAS EXTRA
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Horas_Extra'), 
    'EN REVISION', 
    '#fbbc04',   -- Aquí puedes agregar el color de fondo
    '#000000',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "ACEPTADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Horas_Extra'), 
    'ACEPTADA', 
    '#34a853',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "RECHAZADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Horas_Extra'), 
    'RECHAZADA', 
    '#980000',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "EN REVISION" - INCIDENCIAS
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Incidencias'), 
    'EN REVISION', 
    '#fbbc04',   -- Aquí puedes agregar el color de fondo
    '#000000',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "ACEPTADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Incidencias'), 
    'ACEPTADA', 
    '#34a853',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "RECHAZADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Incidencias'), 
    'RECHAZADA', 
    '#980000',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);
GO


-- Insertar "EN REVISION" - INCIDENCIAS
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Prestamo'), 
    'EN REVISION', 
    '#fbbc04',   -- Aquí puedes agregar el color de fondo
    '#000000',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "ACEPTADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Prestamo'), 
    'ACEPTADA', 
    '#34a853',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "RECHAZADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Prestamo'), 
    'RECHAZADA', 
    '#980000',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);
GO




-- Insertar "EN REVISION" - INCIDENCIAS
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Justificante'), 
    'EN REVISION', 
    '#fbbc04',   -- Aquí puedes agregar el color de fondo
    '#000000',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "ACEPTADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Justificante'), 
    'ACEPTADO', 
    '#34a853',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);

-- Insertar "RECHAZADA"
INSERT INTO Estatus (ID_TipoEstatus, Estatus, Color_Fondo, Color_Texto, IsActivo, FechaInserto)
VALUES (
    (SELECT ID_TipoEstatus FROM TipoEstatus WHERE TipoEstatus = 'Justificante'), 
    'RECHAZADO', 
    '#980000',   -- Aquí puedes agregar el color de fondo
    '#ffffff',   -- Aquí puedes agregar el color de texto
    1, 
    GETDATE()
);
GO



-- Añadir la columna ID_Estatus a la tabla VACACIONES
ALTER TABLE VACACIONES
ADD ID_Estatus INT;

-- Establecer la columna ID_Estatus como una llave foránea que referencia a la tabla Estatus
ALTER TABLE VACACIONES
ADD CONSTRAINT FK_Vacaciones_Estatus FOREIGN KEY (ID_Estatus) REFERENCES Estatus(ID_Estatus);
GO

-- Añadir la columna ID_Estatus a la tabla Incidencias
ALTER TABLE INCIDENCIA
ADD ID_Estatus INT;

-- Establecer la columna ID_Estatus como una llave foránea que referencia a la tabla Estatus
ALTER TABLE INCIDENCIA
ADD CONSTRAINT FK_Incidencia_Estatus FOREIGN KEY (ID_Estatus) REFERENCES Estatus(ID_Estatus);
GO
-- Añadir la columna ID_Estatus a la tabla HORAS_EXTRA
ALTER TABLE HORAS_EXTRAS
ADD ID_Estatus INT;

-- Establecer la columna ID_Estatus como una llave foránea que referencia a la tabla Estatus
ALTER TABLE HORAS_EXTRAS
ADD CONSTRAINT FK_HorasExtras_Estatus FOREIGN KEY (ID_Estatus) REFERENCES Estatus(ID_Estatus);
GO

ALTER TABLE HORAS_EXTRAS
DROP COLUMN img_hraExtra;
GO

-- Añadir la columna ID_Estatus a la tabla Incidencias
ALTER TABLE PRESTAMO
ADD ID_Estatus INT;

-- Establecer la columna ID_Estatus como una llave foránea que referencia a la tabla Estatus
ALTER TABLE PRESTAMO
ADD CONSTRAINT FK_PRESTAMO_Estatus FOREIGN KEY (ID_Estatus) REFERENCES Estatus(ID_Estatus);
GO

-- Añadir la columna ID_Estatus a la tabla Incidencias
ALTER TABLE JUSTIFICANTE
ADD ID_Estatus INT;

-- Establecer la columna ID_Estatus como una llave foránea que referencia a la tabla Estatus
ALTER TABLE JUSTIFICANTE
ADD CONSTRAINT FK_Justificante_Estatus FOREIGN KEY (ID_Estatus) REFERENCES Estatus(ID_Estatus);
GO

CREATE TABLE Ubicaciones_X_Empleado (
    ID_Ubicaciones_X_Empleado INT IDENTITY(1,1) PRIMARY KEY,
    id_Ubicacion INT NOT NULL,
    id_Empleado INT NOT NULL,
    CONSTRAINT FK_Ubicaciones_X_Empleado_Ubicacion FOREIGN KEY (id_Ubicacion) REFERENCES UBICACION (id_ubicacion),
    CONSTRAINT FK_Ubicaciones_X_Empleado_Empleado FOREIGN KEY (id_Empleado) REFERENCES EMPLEADO (id_empleado)
);







/*
*******************************************************************************************************************************
									STORED PROCEDURES
*******************************************************************************************************************************
*/

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO


-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Select_Ubicaciones_X_Empleado')
BEGIN
    DROP PROCEDURE SP_Select_Ubicaciones_X_Empleado
END
GO

CREATE PROCEDURE SP_Select_Ubicaciones_X_Empleado
    @Id_Empleado INT
AS
BEGIN
    SELECT 
        UXE.ID_Ubicaciones_X_Empleado,
        UXE.id_ubicacion,
        UE.Nombre AS NombreUbicacion,
        UXE.id_empleado
    FROM 
        Ubicaciones_X_Empleado UXE
    INNER JOIN 
        UBICACION UE ON UXE.id_Ubicacion = UE.id_ubicacion
    WHERE 
        UXE.id_empleado = @Id_Empleado;
END;
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO


-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Insertar_Ubicaciones_X_Empleado')
BEGIN
    DROP PROCEDURE SP_Insertar_Ubicaciones_X_Empleado
END
GO

CREATE PROCEDURE SP_Insertar_Ubicaciones_X_Empleado
    @Id_Ubicacion INT,
    @Id_Empleado INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Ubicaciones_X_Empleado (id_Ubicacion, id_Empleado)
        VALUES (@Id_Ubicacion, @Id_Empleado);

        SELECT SCOPE_IDENTITY() AS ID_Ubicaciones_X_Empleado; -- Retorna el ID generado
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Borrar_Ubicaciones_X_Empleado')
BEGIN
    DROP PROCEDURE SP_Borrar_Ubicaciones_X_Empleado
END
GO

CREATE PROCEDURE SP_Borrar_Ubicaciones_X_Empleado
    @Id_Empleado INT
AS
BEGIN
    BEGIN TRY
        -- Eliminar todas las ubicaciones asociadas al empleado
        DELETE FROM Ubicaciones_X_Empleado
        WHERE id_Empleado = @Id_Empleado;
    END TRY
    BEGIN CATCH
        -- Manejar errores
        THROW;
    END CATCH
END;
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

IF OBJECT_ID('dbo.sp_ObtenerCategorias', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ObtenerCategorias;
GO

-- Crear el procedimiento almacenado
CREATE PROCEDURE sp_ObtenerCategorias
AS
BEGIN
    SET NOCOUNT ON;

    -- Obtener las categorías con id_categoria en (8, 9, 10, 29)
    SELECT 
        id_categoria,
        nombre_categoria,
        clasificacion,
        fecha_registro,
        hora_registro,
        id_usuario
    FROM 
        Categoria
    WHERE 
        id_categoria IN (8, 9, 10, 29)
    ORDER BY 
        fecha_registro DESC, hora_registro DESC;
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('dbo.sp_ObtenerMaquinaria', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ObtenerMaquinaria;
GO

-- Creación del Stored Procedure
CREATE PROCEDURE [dbo].[sp_ObtenerMaquinaria]
    @id_ubicacion INT = NULL, -- Parámetro opcional para filtrar por id_ubicacion
    @id_categoria INT = NULL  -- Parámetro opcional para filtrar por id_categoria
AS
BEGIN
    SET NOCOUNT ON;

    -- Seleccionar todas las columnas de la tabla MAQUINARIA con filtros opcionales
    SELECT 
        id_maquinaria,
        no_economico,
        folio_registro,
        hora_registro,
        fecha_registro,
        marca,
        modelo,
        no_motor,
        especificacion,
        id_categoria_estado,
        id_ubicacion,
        id_categoria,
        id_subcategoria,
        img_maquinaria,
        img_factura,
        id_usuario
    FROM 
        MAQUINARIA
    WHERE 
        (@id_ubicacion IS NULL OR id_ubicacion = @id_ubicacion) AND
        (@id_categoria IS NULL OR id_categoria = @id_categoria)
    ORDER BY 
        id_maquinaria ASC; -- Ordenar por ID de maquinaria en orden ascendente
END;
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS;
GO

IF OBJECT_ID('dbo.SP_ObtenerEmpleadosPorDepartamento', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SP_ObtenerEmpleadosPorDepartamento;
GO


CREATE PROCEDURE SP_ObtenerEmpleadosPorDepartamento
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        E.id_empleado, 
        E.nombre, 
        E.apellido_paterno, 
        E.apellido_materno
    FROM EMPLEADO E
    INNER JOIN DEPARTAMENTO D ON E.id_departamento = D.id_departamento
     WHERE E.id_departamento = 11
      AND E.id_empleado IN (72, 73, 74);
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO


IF OBJECT_ID('dbo.SP_ObtenerInstalacionesPorUbicacion', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SP_ObtenerInstalacionesPorUbicacion;
GO


CREATE PROCEDURE SP_ObtenerInstalacionesPorUbicacion
    @IdUbicacion INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        id_instalacion,
        folio_instalacion,
        fecha_registro,
        hora_registro,
        id_ubicacion,
        id_almacen,
        nombre,
        uso,
        id_usuario,
        descripcion
    FROM 
        Instalacion

		
SELECT * FROM UBICACION
    WHERE 
        id_ubicacion = @IdUbicacion;
END;

GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------------------------------------------------


USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_GetSubMenusByParentID')
BEGIN
    DROP PROCEDURE sp_GetSubMenusByParentID
END
GO

-- Crea el Stored Procedure nuevamente
CREATE PROCEDURE sp_GetSubMenusByParentID
    @ID_PadreMenu INT,
    @ID_Usuario NVARCHAR(128) -- Especificamos el tamaño del NVARCHAR
AS
BEGIN
    SELECT 
        M.ID_Menu, 
        M.Nombre_Menu, 
        M.ID_PadreMenu, 
        M.Fecha_Inserto, 
        M.Controlador, 
        M.Accion,
        M.Icono -- Añadimos el campo Icono
    FROM Menu M
    INNER JOIN Menu_Usuario MU ON M.ID_Menu = MU.ID_Menu
    WHERE M.ID_PadreMenu = @ID_PadreMenu 
    AND MU.ID_Usuario = @ID_Usuario
END
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
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
        -- Verificamos si el usuario tiene menús asignados
        IF EXISTS (SELECT 1 FROM Menu_Usuario WHERE ID_Usuario = @ID_Usuario)
        BEGIN
            -- Seleccionamos los menús a los que tiene acceso el usuario
            SELECT M.ID_Menu, 
                   M.Nombre_Menu, 
                   M.ID_PadreMenu, 
                   M.Fecha_Inserto
            FROM Menu M
            INNER JOIN Menu_Usuario MU ON M.ID_Menu = MU.ID_Menu
            WHERE MU.ID_Usuario = @ID_Usuario
            ORDER BY M.ID_PadreMenu, M.ID_Menu; -- Ordenar por menú padre y luego por ID de menú
        END
        ELSE
        BEGIN
            -- Si no tiene menús asignados, devolvemos un mensaje indicando eso
            PRINT 'El usuario no tiene menús asignados.'
        END
    END TRY
    BEGIN CATCH
        -- En caso de error, devolvemos información relevante sobre el problema
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_GetMenusAndSubMenusByUserID')
BEGIN
    DROP PROCEDURE sp_GetMenusAndSubMenusByUserID
END
GO

-- Crea el Stored Procedure nuevamente
CREATE PROCEDURE sp_GetMenusAndSubMenusByUserID
    @ID_Usuario NVARCHAR(450) -- Ajusta el tipo de datos si es necesario
AS
BEGIN
    -- Manejo de errores
    BEGIN TRY
        -- Selección de menús y submenús asociados al usuario
        SELECT 
            M.ID_Menu, 
            M.Nombre_Menu, 
            M.ID_PadreMenu, 
            M.Fecha_Inserto,
            M.Controlador,   -- Incluir el controlador
            M.Accion,        -- Incluir la acción
            M.Icono          -- Incluir el icono si existe
        FROM 
            Menu M
        INNER JOIN 
            Menu_Usuario MU ON M.ID_Menu = MU.ID_Menu
        WHERE 
            MU.ID_Usuario = @ID_Usuario;
    END TRY
    BEGIN CATCH
        -- Captura y manejo de errores
        SELECT 
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------
USE NEO_GENESIS
GO
    
	IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GetEmpleadoById')
BEGIN
    DROP PROCEDURE SP_GetEmpleadoById
END
GO

CREATE PROCEDURE [dbo].[SP_GetEmpleadoById]    
    @IdEmpleado INT    
AS    
BEGIN    
    SET NOCOUNT ON;    
    
    -- Seleccionar los datos del empleado por su ID    
    SELECT     
        ISNULL(E.id_empleado, 0) AS id_empleado,    
        ISNULL(E.folio_registro, '') AS folio_registro,    
        ISNULL(E.hora_registro, '') AS hora_registro,    
        ISNULL(E.fecha_registro, '') AS fecha_registro,    
        ISNULL(E.empleado, 0) AS empleado,    
        ISNULL(E.fecha_ingreso, '') AS fecha_ingreso,    
        ISNULL(E.apellido_paterno, '') AS apellido_paterno,    
        ISNULL(E.apellido_materno, '') AS apellido_materno,    
        ISNULL(E.nombre, '') AS nombre,    
        ISNULL(E.fecha_nacimiento, '') AS fecha_nacimiento,    
        ISNULL(E.genero, '') AS genero,    
        ISNULL(E.domicilio, '') AS domicilio,    
        ISNULL(E.colonia, '') AS colonia,    
        ISNULL(E.cp, '') AS cp,    
        ISNULL(E.municipio, '') AS municipio,    
        ISNULL(E.peso, '') AS peso,    
        ISNULL(E.estatura, '') AS estatura,    
        ISNULL(E.lugar_nacimiento, '') AS lugar_nacimiento,    
        ISNULL(E.nacionalidad, '') AS nacionalidad,    
        ISNULL(E.telefono, '') AS telefono,    
        ISNULL(E.celular, '') AS celular,    
        ISNULL(E.correo, '') AS correo,    
        ISNULL(E.estado_civil, '') AS estado_civil,    
        ISNULL(E.curp, '') AS curp,    
        ISNULL(E.rfc, '') AS rfc,    
        ISNULL(E.seguro, '') AS seguro,    
        ISNULL(E.nss, '') AS nss,    
        ISNULL(E.licencia, '') AS licencia,    
        ISNULL(E.clase, '') AS clase,    
        ISNULL(E.no_licencia, '') AS no_licencia,    
        ISNULL(E.vigencia, '') AS vigencia,    
        ISNULL(E.afore, '') AS afore,    
        ISNULL(E.discapacidad, '') AS discapacidad,    
        ISNULL(E.descripcion_discap, '') AS descripcion_discap,    
        ISNULL(E.estado_salud, '') AS estado_salud,    
        ISNULL(E.nivel_estudios, '') AS nivel_estudios,    
        ISNULL(E.carrera, '') AS carrera,    
        ISNULL(E.titulacion, '') AS titulacion,    
        ISNULL(E.cedula, '') AS cedula,    
        ISNULL(E.nombre_contacto, '') AS nombre_contacto,    
        ISNULL(E.parentesco_contacto, '') AS parentesco_contacto,    
        ISNULL(E.celular_contacto, '') AS celular_contacto,    
        ISNULL(E.domicilio_contacto, '') AS domicilio_contacto,    
        ISNULL(E.cp_contacto, '') AS cp_contacto,    
        ISNULL(E.nombre_contacto2, '') AS nombre_contacto2,    
        ISNULL(E.parentesco_contacto2, '') AS parentesco_contacto2,    
        ISNULL(E.celular_contacto2, '') AS celular_contacto2,    
        ISNULL(E.domicilio_contacto2, '') AS domicilio_contacto2,    
        ISNULL(E.cp_contacto2, '') AS cp_contacto2,    
        ISNULL(E.nombre_contacto3, '') AS nombre_contacto3,    
        ISNULL(E.parentesco_contacto3, '') AS parentesco_contacto3,    
        ISNULL(E.celular_contacto3, '') AS celular_contacto3,    
        ISNULL(E.domicilio_contacto3, '') AS domicilio_contacto3,    
        ISNULL(E.cp_contacto3, '') AS cp_contacto3,    
        ISNULL(E.id_puesto, 0) AS id_puesto,    
        ISNULL(E.id_departamento, 0) AS id_departamento,    
        ISNULL(E.id_ubicacion, 0) AS id_ubicacion,    
        ISNULL(E.id_empresa, 0) AS id_empresa,    
        ISNULL(E.horario_entrada, '') AS horario_entrada,    
        ISNULL(E.horario_salida, '') AS horario_salida,    
        ISNULL(E.tipo_pago, '') AS tipo_pago,    
        ISNULL(E.tipo_periodo, '') AS tipo_periodo,    
        ISNULL(E.sueldo_neto, '') AS sueldo_neto,    
        ISNULL(E.salario, '') AS salario,    
        ISNULL(E.tipo_contrato, '') AS tipo_contrato,    
        ISNULL(E.asignacion_equipo, '') AS asignacion_equipo,    
        ISNULL(E.asignacion_vehiculo, '') AS asignacion_vehiculo,    
        ISNULL(E.id_usuario, 0) AS id_usuario,    
        ISNULL(E.vacaciones, 0) AS vacaciones,    
        ISNULL(E.firma_digital, '') AS firma_digital,    
        ISNULL(E.img_contrato, '') AS img_contrato,    
        CASE     
            WHEN CHARINDEX('\', E.img_empleado) > 0     
            THEN RIGHT(E.img_empleado, CHARINDEX('\', REVERSE(E.img_empleado)) - 1)    
            ELSE ISNULL(E.img_empleado, '')     
        END AS Img_empleado_nombre,    
  P.nombre AS Puesto    
    FROM EMPLEADO E     
 INNER JOIN PUESTO P ON E.id_puesto = P.id_puesto    
    WHERE id_empleado = @IdEmpleado;    
END    
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Obtener_Ubicaciones')
BEGIN
    DROP PROCEDURE SP_Obtener_Ubicaciones
END
GO

-- Creación del Stored Procedure
CREATE PROCEDURE [dbo].[SP_Obtener_Ubicaciones]
    @id_empleado INT
AS
BEGIN
    BEGIN TRY
        -- Declarar variables solo si el id_empleado no es 0
        DECLARE @Id_puesto_Coordinador INT;
        DECLARE @Id_Puesto_Empleado INT;
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_puesto_Coordinador = (SELECT id_puesto FROM PUESTO WHERE nombre = 'Coordinador Rh');
            SET @Id_Puesto_Empleado = (SELECT id_puesto FROM EMPLEADO WHERE id_empleado = @id_empleado);
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);
        END

        -- Verificar si el id_empleado es 0
        IF @id_empleado = 0
        BEGIN
            -- Mostrar todas las ubicaciones
            SELECT TOP (1000) 
                [id_ubicacion],
                [folio_registro],
                [hora_registro],
                [fecha_registro],
                [nombre],
                [lugar],
                [coordenada_x],
                [coordenada_y],
                [direccion],
                [cp],
                [img_ubicacion],
                [id_usuario]
            FROM [dbo].[UBICACION]
            ORDER BY [id_ubicacion] DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Verificar si el empleado es Coordinador Rh
            IF @Id_Puesto_Empleado = @Id_puesto_Coordinador
            BEGIN
                -- Mostrar todas las ubicaciones si el empleado es Coordinador Rh
                SELECT TOP (1000) 
                    [id_ubicacion],
                    [folio_registro],
                    [hora_registro],
                    [fecha_registro],
                    [nombre],
                    [lugar],
                    [coordenada_x],
                    [coordenada_y],
                    [direccion],
                    [cp],
                    [img_ubicacion],
                    [id_usuario]
                FROM [dbo].[UBICACION]
                ORDER BY [id_ubicacion] DESC; -- Ordenar por ID de manera descendente
            END
            ELSE
            BEGIN
                -- Mostrar solo la ubicación del empleado si no es Coordinador Rh
                SELECT 
                    [id_ubicacion],
                    [folio_registro],
                    [hora_registro],
                    [fecha_registro],
                    [nombre],
                    [lugar],
                    [coordenada_x],
                    [coordenada_y],
                    [direccion],
                    [cp],
                    [img_ubicacion],
                    [id_usuario]
                FROM [dbo].[UBICACION]
                WHERE [id_ubicacion] = @Id_ubicacion_empleado
                ORDER BY [id_ubicacion] DESC; -- Ordenar por ID de manera descendente
            END
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarVacaciones')
BEGIN
    DROP PROCEDURE sp_InsertarVacaciones
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarVacaciones]
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_vacacion), 0) + 1 FROM [dbo].[VACACIONES]

        DECLARE @folio_registro NVARCHAR(50)
        SET @folio_registro = CONCAT('SV-', @nextId)

        -- Inserción del registro
        INSERT INTO [dbo].[VACACIONES] (
            folio_registro,
            fecha_registro,
            hora_registro,           
            id_usuario
        )
        VALUES (
            @folio_registro,
            @fecha_registro,
            @hora_registro,
            @id_usuario
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_vacacion INT
        SET @id_vacacion = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_registro AS FolioGenerado, @id_vacacion AS ID_Vacacion
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GetVacacionById')
BEGIN
    DROP PROCEDURE SP_GetVacacionById
END
GO

CREATE PROCEDURE SP_GetVacacionById
    @IdVacacion INT
AS
BEGIN
    SELECT *
    FROM VACACIONES
    WHERE id_vacacion = @IdVacacion;
END

GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GetAllVacaciones')
BEGIN
    DROP PROCEDURE SP_GetAllVacaciones
END
GO

CREATE PROCEDURE SP_GetAllVacaciones
AS
BEGIN
    SELECT id_vacacion, folio_registro, fecha_registro, hora_registro, id_ubicacion, id_empleado, fecha_inicio, fecha_fin, dias_vacacion, fecha_incorporacion, dias_restantes, observaciones, id_usuario
    FROM VACACIONES;
END

GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ActualizarVacaciones')
BEGIN
    DROP PROCEDURE sp_ActualizarVacaciones
END
GO

CREATE PROCEDURE [dbo].[sp_ActualizarVacaciones]
    @id_vacacion INT,
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_ubicacion INT,
    @id_empleado INT,
    @fecha_inicio DATE,
    @fecha_fin DATE,
    @dias_vacacion INT,
    @fecha_incorporacion DATE,
    @dias_restantes INT,
    @observaciones NVARCHAR(255),
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Validación de datos
		DECLARE @ID_Estatus INT = (SELECT E.ID_Estatus FROM Estatus E
							  INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
							  WHERE E.Estatus = 'EN REVISION' AND TE.TipoEstatus = 'Solicitud_Vacaciones') 
        IF @fecha_fin < @fecha_inicio
        BEGIN
            RAISERROR('La fecha de fin no puede ser anterior a la fecha de inicio.', 16, 1)
            RETURN
        END

        IF @dias_vacacion <= 0
        BEGIN
            RAISERROR('Los días de vacación deben ser mayores a 0.', 16, 1)
            RETURN
        END

        -- Validar existencia del registro
        IF NOT EXISTS (SELECT 1 FROM [dbo].[VACACIONES] WHERE id_vacacion = @id_vacacion)
        BEGIN
            RAISERROR('El registro con el ID especificado no existe.', 16, 1)
            RETURN
        END

        -- Actualización del registro
        UPDATE [dbo].[VACACIONES]
        SET 
            fecha_registro = @fecha_registro,
            hora_registro = @hora_registro,
            id_ubicacion = @id_ubicacion,
            id_empleado = @id_empleado,
            fecha_inicio = @fecha_inicio,
            fecha_fin = @fecha_fin,
            dias_vacacion = @dias_vacacion,
            fecha_incorporacion = @fecha_incorporacion,
            dias_restantes = @dias_restantes,
            observaciones = @observaciones,
            id_usuario = @id_usuario,
			ID_Estatus = @ID_Estatus
        WHERE id_vacacion = @id_vacacion

        -- Confirmación de éxito
        SELECT 'Registro actualizado exitosamente.' AS Mensaje
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verificar si el procedimiento almacenado ya existe y eliminarlo
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_GetVacacionesConFormato')
BEGIN
    DROP PROCEDURE SP_GetVacacionesConFormato
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_GetVacacionesConFormato
    @id_empleado INT -- Parámetro para identificar al empleado que hace la consulta
AS
BEGIN
    BEGIN TRY
        -- Declarar variables para identificar la ubicación principal del empleado
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);
        END

        -- Verificar si el empleado tiene acceso a múltiples ubicaciones mediante Ubicaciones_X_Empleado
        IF EXISTS (SELECT 1 FROM Ubicaciones_X_Empleado WHERE id_empleado = @id_empleado)
        BEGIN
            -- Mostrar todas las vacaciones de las ubicaciones asociadas al empleado
            SELECT DISTINCT 
                V.id_vacacion,
                E.nombre, 
                CONVERT(VARCHAR(10), V.fecha_inicio, 103) AS fecha_inicio,  -- Formato dd/MM/yyyy
                CONVERT(VARCHAR(10), V.fecha_incorporacion, 103) AS fecha_incorporacion,  -- Formato dd/MM/yyyy
                V.dias_vacacion, 
                EST.Estatus,
                V.observaciones
            FROM 
                VACACIONES V
            INNER JOIN 
                EMPLEADO E ON V.id_empleado = E.id_empleado
            LEFT JOIN 
                Estatus EST ON V.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion
            WHERE 
                UXE.id_empleado = @id_empleado
            ORDER BY 
                V.id_vacacion DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Mostrar solo las vacaciones de la ubicación principal del empleado
            SELECT 
                V.id_vacacion,
                E.nombre, 
                CONVERT(VARCHAR(10), V.fecha_inicio, 103) AS fecha_inicio,  -- Formato dd/MM/yyyy
                CONVERT(VARCHAR(10), V.fecha_incorporacion, 103) AS fecha_incorporacion,  -- Formato dd/MM/yyyy
                V.dias_vacacion, 
                EST.Estatus,
                V.observaciones
            FROM 
                VACACIONES V
            INNER JOIN 
                EMPLEADO E ON V.id_empleado = E.id_empleado
            LEFT JOIN 
                Estatus EST ON V.ID_Estatus = EST.ID_Estatus
            WHERE 
                E.id_ubicacion = @Id_ubicacion_empleado
            ORDER BY 
                V.id_vacacion DESC; -- Ordenar por ID de manera descendente
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO



-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Borrar el procedimiento almacenado si ya existe
IF OBJECT_ID('SP_ObtenerIncidencias', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerIncidencias;
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_ObtenerIncidencias
    @id_empleado INT -- Parámetro para filtrar por empleado
AS
BEGIN
    BEGIN TRY
        -- Declarar variables para la ubicación principal del empleado
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);
        END

        -- Verificar si el empleado tiene acceso a múltiples ubicaciones mediante Ubicaciones_X_Empleado
        IF EXISTS (SELECT 1 FROM Ubicaciones_X_Empleado WHERE id_empleado = @id_empleado)
        BEGIN
            -- Mostrar todas las incidencias de las ubicaciones asociadas al empleado
            SELECT DISTINCT 
                I.*, 
                EST.Estatus,
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento
            FROM 
                INCIDENCIA I
            INNER JOIN 
                EMPLEADO E ON I.id_empleado = E.id_empleado
            INNER JOIN 
                Estatus EST ON I.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion
            WHERE 
                UXE.id_empleado = @id_empleado
            ORDER BY 
                I.id_incidencia DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Mostrar solo las incidencias de la ubicación principal del empleado
            SELECT 
                I.*, 
                EST.Estatus,
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento
            FROM 
                INCIDENCIA I
            INNER JOIN 
                EMPLEADO E ON I.id_empleado = E.id_empleado
            INNER JOIN 
                Estatus EST ON I.ID_Estatus = EST.ID_Estatus
            WHERE 
                E.id_ubicacion = @Id_ubicacion_empleado
            ORDER BY 
                I.id_incidencia DESC; -- Ordenar por ID de manera descendente
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ObtenerIncidenciaPorId')
BEGIN
    DROP PROCEDURE sp_ObtenerIncidenciaPorId
END
GO

CREATE PROCEDURE [dbo].[sp_ObtenerIncidenciaPorId]
    @id_incidencia INT
AS
BEGIN
    BEGIN TRY
        -- Selecciona el registro de la tabla INCIDENCIA basado en el ID proporcionado
        SELECT 
            [id_incidencia],
            [folio_incidencia],
            [hora_registro],
            [fecha_registro],
            [id_ubicacion],
            [id_empleado],
            [tipo_registro],
            [tipo_incidencia],
            [tiempo_sancion],
            [descuento_dia],
            [dia],
            [fecha_inicio],
            [descripcion],
            [goze],
            [horas],
            [id_usuario],
            [ID_Estatus]
        FROM 
          [dbo].[INCIDENCIA]
        WHERE 
            [id_incidencia] = @id_incidencia;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarIncidencia')
BEGIN
    DROP PROCEDURE sp_InsertarIncidencia
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarIncidencia]
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_incidencia), 0) + 1 FROM [dbo].[INCIDENCIA]

        DECLARE @folio_registro NVARCHAR(50)
        SET @folio_registro = CONCAT('INC-', @nextId)

        -- Inserción del registro
        INSERT INTO [dbo].[INCIDENCIA] (
            folio_incidencia,
            fecha_registro,
            hora_registro,
            id_usuario
        )
        VALUES (
            @folio_registro,
            @fecha_registro,
            @hora_registro,
            @id_usuario
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_incidencia INT
        SET @id_incidencia = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_registro AS FolioGenerado, @id_incidencia AS ID_Incidencia
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Update_Incidencia')
BEGIN
    DROP PROCEDURE SP_Update_Incidencia
END
GO

CREATE PROCEDURE [dbo].[SP_Update_Incidencia]
    @id_incidencia INT,
    @id_empleado INT,  
    @tipo_registro VARCHAR(50),  
    @tipo_incidencia VARCHAR(50),  
    @tiempo_sancion VARCHAR(50),  
    @descuento_dia CHAR(5),  
    @dia VARCHAR(10),  
    @fecha_inicio CHAR(10),  
    @descripcion NVARCHAR(MAX),  
    @goze CHAR(1),  
    @horas CHAR(5),  
    @id_usuario INT  
AS
BEGIN
    BEGIN TRY
        DECLARE @ID_Estatus INT = (SELECT E.ID_Estatus FROM Estatus E
                                  INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
                                  WHERE E.Estatus = 'EN REVISION' AND TE.TipoEstatus = 'Incidencias') 
		DECLARE @ID_Ubicacion INT = (SELECT id_ubicacion FROM EMPLEADO E WHERE id_empleado = @id_empleado)
        -- Validar que el registro exista
        IF NOT EXISTS (SELECT 1 FROM INCIDENCIA WHERE id_incidencia = @id_incidencia)
        BEGIN
            RAISERROR('No se encontró una incidencia con el ID proporcionado.', 16, 1)
            RETURN
        END

        -- Actualizar el registro existente
        UPDATE INCIDENCIA
        SET
            id_empleado = @id_empleado,
            tipo_registro = @tipo_registro,
            tipo_incidencia = REPLACE(@tipo_incidencia, ',', ''), -- Elimina las comas del valor
            tiempo_sancion = REPLACE(@tiempo_sancion, ',', ''), -- Elimina las comas del valor
            descuento_dia = @descuento_dia,
            dia = @dia,
            fecha_inicio = @fecha_inicio,
            descripcion = @descripcion,
            goze = @goze,
            horas = @horas,
            id_usuario = @id_usuario,
            hora_registro = CONVERT(CHAR(5), GETDATE(), 108), -- Actualiza la hora actual
            fecha_registro = CONVERT(DATE, GETDATE()), -- Actualiza la fecha actual
            ID_Estatus = @ID_Estatus,
			id_ubicacion = @ID_Ubicacion
        WHERE id_incidencia = @id_incidencia;

        -- Confirmación de éxito
        SELECT 'Registro actualizado exitosamente.' AS Mensaje, @id_incidencia AS ID_Incidencia;

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Delete_INCIDENCIA')
BEGIN
    DROP PROCEDURE SP_Delete_INCIDENCIA
END
GO

CREATE PROCEDURE SP_Delete_INCIDENCIA
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM INCIDENCIA
    WHERE id_incidencia = @id;
END;
GO



-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Borrar el procedimiento almacenado si ya existe
IF OBJECT_ID('SP_ObtenerHorasExtras', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerHorasExtras;
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_ObtenerHorasExtras
    @id_empleado INT -- Parámetro para identificar al empleado que realiza la consulta
AS
BEGIN
    BEGIN TRY
        -- Declarar variables para la ubicación principal del empleado
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);
        END

        -- Verificar si el empleado tiene acceso a múltiples ubicaciones mediante Ubicaciones_X_Empleado
        IF EXISTS (SELECT 1 FROM Ubicaciones_X_Empleado WHERE id_empleado = @id_empleado)
        BEGIN
            -- Mostrar todas las horas extras de las ubicaciones asociadas al empleado
            SELECT DISTINCT 
                HE.*, 
                EST.Estatus, 
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento
            FROM 
                HORAS_EXTRAS HE
            INNER JOIN 
                EMPLEADO E ON HE.id_empleado = E.id_empleado
            INNER JOIN 
                Estatus EST ON HE.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion
            WHERE 
                UXE.id_empleado = @id_empleado
            ORDER BY 
                HE.id_horaExtra DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Mostrar solo las horas extras de la ubicación principal del empleado
            SELECT 
                HE.*, 
                EST.Estatus, 
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento
            FROM 
                HORAS_EXTRAS HE
            INNER JOIN 
                EMPLEADO E ON HE.id_empleado = E.id_empleado
            INNER JOIN 
                Estatus EST ON HE.ID_Estatus = EST.ID_Estatus
            WHERE 
                E.id_ubicacion = @Id_ubicacion_empleado
            ORDER BY 
                HE.id_horaExtra DESC; -- Ordenar por ID de manera descendente
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarHorasExtra')
BEGIN
    DROP PROCEDURE sp_InsertarHorasExtra
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarHorasExtra]
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_horaExtra), 0) + 1 FROM [dbo].[HORAS_EXTRAS]

        DECLARE @folio_registro NVARCHAR(50)
        SET @folio_registro = CONCAT('HE-', @nextId)

        -- Inserción del registro
        INSERT INTO [dbo].[HORAS_EXTRAS] (
            folio_registro,
            fecha_registro,
            hora_registro,
            id_usuario
        )
        VALUES (
            @folio_registro,
            @fecha_registro,
            @hora_registro,
            @id_usuario
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_horaExtra INT
        SET @id_horaExtra = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_registro AS FolioGenerado, @id_horaExtra AS ID_HoraExtra
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_ObtenerHoraExtraPorId')
BEGIN
    DROP PROCEDURE SP_ObtenerHoraExtraPorId
END
GO

CREATE PROCEDURE [dbo].[SP_ObtenerHoraExtraPorId]
    @id_horaExtra INT
AS
BEGIN
    BEGIN TRY
        -- Selecciona los datos de la tabla Horas Extra por ID
        SELECT 
            he.id_horaExtra,
            he.folio_registro,
            he.fecha_registro,
            he.hora_registro,
            he.id_empleado,
            he.id_responsable,
            he.fecha_compensacion,
            he.costo_horaExtra,
            he.costo_horaDoble,
            he.horas_porPagar,
            he.costo_horaTriple,
            he.hora_triple,
            he.total_horaDoble,
            he.total_horaTriple,
            he.total_aPagar,
            he.motivo_hraExtra,
            he.observaciones,
            he.id_usuario,
            he.ID_Estatus,
            e.Nombre AS NombreEmpleado,
            e.apellido_paterno AS ApellidoPaternoEmpleado,
            e.apellido_materno AS ApellidoMaternoEmpleado
        FROM [dbo].[HORAS_EXTRAS] he
        LEFT JOIN [dbo].[EMPLEADO] e ON he.id_empleado = e.id_empleado
        WHERE he.id_horaExtra = @id_horaExtra;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------
USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Actualizar_HorasExtra')
BEGIN
    DROP PROCEDURE SP_Actualizar_HorasExtra
END
GO

CREATE PROCEDURE [dbo].[SP_Actualizar_HorasExtra]  
    @id_horaExtra INT,  
    @id_empleado INT,  
    @id_responsable INT,  
    @fecha_compensacion DATE, -- Cambiado de NVARCHAR(300) a DATE  
    @horas_porPagar INT,  
    @motivo_hraExtra NVARCHAR(400),  
    @observaciones NVARCHAR(400),  
    @id_usuario INT,  
    @Evidencia1 NVARCHAR(MAX) = NULL,  
    @Evidencia2 NVARCHAR(MAX) = NULL  
AS  
BEGIN  
    BEGIN TRY  
        -- Declarar variables locales  
        DECLARE @ID_Estatus INT = (SELECT E.ID_Estatus   
                                   FROM Estatus E  
                                   INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus  
                                   WHERE E.Estatus = 'EN REVISION' AND TE.TipoEstatus = 'Horas_Extra');  
  
        DECLARE @CostoHoraExtra FLOAT;  
        DECLARE @CostoHoraDoble FLOAT;  
        DECLARE @CostoHoraTriple FLOAT;  
        DECLARE @HoraTriple INT = 0;  
        DECLARE @TotalHoraDoble FLOAT;  
        DECLARE @TotalHoraTriple FLOAT = 0;  
        DECLARE @TotalAPagar FLOAT;  
  
        -- Validar si existe el registro con el ID proporcionado  
        IF NOT EXISTS (SELECT 1 FROM [dbo].[HORAS_EXTRAS] WHERE id_horaExtra = @id_horaExtra)  
        BEGIN  
            RAISERROR('No se encontró el registro con el ID proporcionado.', 16, 1)  
            RETURN  
        END  
  
        -- Validar si existe el empleado  
        IF NOT EXISTS (SELECT 1 FROM [dbo].[EMPLEADO] WHERE id_empleado = @id_empleado)  
        BEGIN  
            RAISERROR('No se encontró el empleado con el ID proporcionado.', 16, 1)  
            RETURN  
        END  
  
        -- Obtener el costo por hora del empleado  
        SELECT @CostoHoraExtra = TRY_CAST(salario AS FLOAT) / 7  FROM EMPLEADO  WHERE id_empleado = @id_empleado;  
  
        -- Calcular el costo por hora doble y triple  
        IF @horas_porPagar <= 9  
        BEGIN  
            SET @CostoHoraDoble = @CostoHoraExtra * 2;  
            SET @TotalHoraDoble = @CostoHoraDoble * @horas_porPagar;  
            SET @HoraTriple = 0;  
            SET @TotalHoraTriple = 0;  
        END  
        ELSE  
        BEGIN  
            SET @CostoHoraDoble = @CostoHoraExtra * 2;  
            SET @TotalHoraDoble = @CostoHoraDoble * 9;  
  
            -- Calcular las horas triples  
            SET @HoraTriple = FLOOR(@horas_porPagar - 9); -- Elimina decimales, si los hay  
            SET @CostoHoraTriple = @CostoHoraExtra * 3;  
            SET @TotalHoraTriple = @CostoHoraTriple * @HoraTriple;  
        END  
  
        -- Calcular el total a pagar  
        SET @TotalAPagar = @TotalHoraDoble + @TotalHoraTriple;  
  
        -- Actualización del registro  
        UPDATE [dbo].[HORAS_EXTRAS]  
        SET   
            id_empleado = @id_empleado,  
            id_responsable = @id_responsable,  
            fecha_compensacion = @fecha_compensacion,  
            horas_porPagar = @horas_porPagar,  
            motivo_hraExtra = @motivo_hraExtra,  
            observaciones = @observaciones,  
            id_usuario = @id_usuario,  
            ID_Estatus = @ID_Estatus,  
            costo_horaExtra = @CostoHoraExtra,  
            costo_horaDoble = @CostoHoraDoble,  
            costo_horaTriple = @CostoHoraTriple,  
            total_horaDoble = @TotalHoraDoble,  
            total_horaTriple = @TotalHoraTriple,  
            total_aPagar = @TotalAPagar,  
            hora_triple = @HoraTriple   
        WHERE id_horaExtra = @id_horaExtra;  
  
        -- Insertar evidencias  
        IF @Evidencia1 IS NOT NULL  
        BEGIN  
            INSERT INTO Evidencias (ID_Tabla, Evidencia_Base64, ID_TipoEvidencia, NombreArchivo, id_usuario, FechaInserto)  
            VALUES (  
                @id_horaExtra,  
                @Evidencia1,  
                (SELECT ID_TipoEvidencia FROM TIPOEVIDENCIAS WHERE TipoEvidencia = 'HORAS_EXTRAS'),  
                FORMAT(GETDATE(), 'yyyyMMdd_HHmmss') + '_HORAS_EXTRAS_1.jpeg',  
                @id_usuario,  
                GETDATE()  
            );  
        END  
  
        IF @Evidencia2 IS NOT NULL  
        BEGIN  
            INSERT INTO Evidencias (ID_Tabla, Evidencia_Base64, ID_TipoEvidencia, NombreArchivo, id_usuario, FechaInserto)  
            VALUES (  
                @id_horaExtra,  
                @Evidencia2,  
                (SELECT ID_TipoEvidencia FROM TIPOEVIDENCIAS WHERE TipoEvidencia = 'HORAS_EXTRAS'),  
                FORMAT(GETDATE(), 'yyyyMMdd_HHmmss') + '_HORAS_EXTRAS_2.jpeg',  
                @id_usuario,  
                GETDATE()  
            );  
        END  
  
        -- Confirmación de éxito  
        SELECT 'Registro actualizado exitosamente.' AS Mensaje;  
    END TRY  
    BEGIN CATCH  
        -- Manejo de errores  
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;  
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();  
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);  
    END CATCH  
END;  
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Delete_HORAS_EXTRAS')
BEGIN
    DROP PROCEDURE SP_Delete_HORAS_EXTRAS
END
GO

CREATE PROCEDURE SP_Delete_HORAS_EXTRAS
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM HORAS_EXTRAS
    WHERE id_horaExtra = @id;
END;
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------


USE NEO_GENESIS
GO
  USE NEO_GENESIS
GO

IF OBJECT_ID('SP_ObtenerPrestamos', 'P') IS NOT NULL
    DROP PROCEDURE SP_ObtenerPrestamos;
GO

CREATE PROCEDURE SP_ObtenerPrestamos
    @id_empleado INT -- Parámetro para filtrar por empleado
AS
BEGIN
    BEGIN TRY
        -- Declarar variable para la ubicación principal del empleado
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);
        END

        -- Verificar si el empleado tiene acceso a múltiples ubicaciones mediante Ubicaciones_X_Empleado
        IF EXISTS (SELECT 1 FROM Ubicaciones_X_Empleado WHERE id_empleado = @id_empleado)
        BEGIN
            -- Mostrar todos los préstamos de las ubicaciones asociadas al empleado
            SELECT DISTINCT 
                P.id_prestamo,
                P.folio_prestamo,
                P.hora_registro,
                P.fecha_registro,
                P.id_ubicacion,
                P.id_empleado,
                P.cantidad_autorizada,
                P.descuento_semanal,
                P.fecha_entrega,
                P.fecha_inicio,
                P.fecha_fin,
                P.motivo,
                P.id_usuario,
                P.ID_Estatus,
                EST.Estatus,
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento
            FROM 
                PRESTAMO P
            INNER JOIN 
                ESTATUS EST ON P.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                EMPLEADO E ON P.id_empleado = E.id_empleado
            INNER JOIN 
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion
            WHERE 
                UXE.id_empleado = @id_empleado
            ORDER BY 
                P.id_prestamo DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Mostrar solo los préstamos de la ubicación principal del empleado
            SELECT 
                P.id_prestamo,
                P.folio_prestamo,
                P.hora_registro,
                P.fecha_registro,
                P.id_ubicacion,
                P.id_empleado,
                P.cantidad_autorizada,
                P.descuento_semanal,
                P.fecha_entrega,
                P.fecha_inicio,
                P.fecha_fin,
                P.motivo,
                P.id_usuario,
                P.ID_Estatus,
                EST.Estatus,
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento
            FROM 
                PRESTAMO P
            INNER JOIN 
                ESTATUS EST ON P.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                EMPLEADO E ON P.id_empleado = E.id_empleado
            WHERE 
                E.id_ubicacion = @Id_ubicacion_empleado
            ORDER BY 
                P.id_prestamo DESC; -- Ordenar por ID de manera descendente
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ObtenerPrestamoPorId', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerPrestamoPorId;
END
GO

CREATE PROCEDURE SP_ObtenerPrestamoPorId
    @id_prestamo INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT 
            p.id_prestamo,
            p.folio_prestamo,
            p.hora_registro,
            p.fecha_registro,
            p.id_ubicacion,
            p.id_empleado,
            p.cantidad_autorizada,
            p.descuento_semanal,
            p.fecha_entrega,
            p.fecha_inicio,
            p.fecha_fin
        FROM 
            PRESTAMO p
        WHERE 
            p.id_prestamo = @id_prestamo;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarPrestamo')
BEGIN
    DROP PROCEDURE sp_InsertarPrestamo
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarPrestamo]
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_prestamo), 0) + 1 FROM [dbo].[PRESTAMO]

        DECLARE @folio_prestamo NVARCHAR(50)
        SET @folio_prestamo = CONCAT('P-', @nextId)

        -- Inserción del registro
        INSERT INTO [dbo].[PRESTAMO] (
            folio_prestamo,
            fecha_registro,
            hora_registro,           
            id_usuario
        )
        VALUES (
            @folio_prestamo,
            @fecha_registro,
            @hora_registro,
            @id_usuario
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_prestamo INT
        SET @id_prestamo = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_prestamo AS FolioGenerado, @id_prestamo AS ID_Prestamo
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ActualizarPrestamo', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ActualizarPrestamo;
END
GO

CREATE PROCEDURE SP_ActualizarPrestamo
    @id_prestamo INT,
    
    @id_empleado INT = NULL,
    @cantidad_autorizada VARCHAR(50) = NULL,
    @fecha_entrega CHAR(10) = NULL,
    @motivo NVARCHAR(255) = NULL,
    @id_usuario INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
	DECLARE @ID_Estatus INT = (SELECT E.ID_Estatus FROM Estatus E
							  INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
							  WHERE E.Estatus = 'EN REVISION' AND TE.TipoEstatus = 'Prestamo'); 
	DECLARE @ID_Ubicacion INT = (SELECT id_ubicacion FROM EMPLEADO E WHERE id_empleado = @id_empleado);
        -- Validación para verificar que el préstamo existe antes de actualizarlo
        IF EXISTS (SELECT 1 FROM PRESTAMO WHERE id_prestamo = @id_prestamo)
        BEGIN
            UPDATE PRESTAMO
            SET 
                id_ubicacion = @ID_Ubicacion,
                id_empleado = ISNULL(@id_empleado, id_empleado),
                cantidad_autorizada = ISNULL(@cantidad_autorizada, cantidad_autorizada),
                fecha_entrega = ISNULL(@fecha_entrega, fecha_entrega),
                motivo = ISNULL(@motivo, motivo),
                id_usuario = ISNULL(@id_usuario, id_usuario),
                fecha_registro = CONVERT(CHAR(10), GETDATE(), 23), 
                hora_registro = CONVERT(CHAR(8), GETDATE(), 108),
				ID_Estatus = @ID_Estatus 
            WHERE 
                id_prestamo = @id_prestamo;

            -- Mensaje de confirmación
            SELECT 'Préstamo actualizado exitosamente.' AS Mensaje, @id_prestamo AS ID_Prestamo;
        END
        ELSE
        BEGIN
            -- Si no se encuentra el préstamo, lanza un error
            RAISERROR('No se encontró el préstamo con el ID especificado.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Delete_PRESTAMO')
BEGIN
    DROP PROCEDURE SP_Delete_PRESTAMO
END
GO

CREATE PROCEDURE SP_Delete_PRESTAMO
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM PRESTAMO
    WHERE id_prestamo = @id;
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Borrar el procedimiento almacenado si ya existe
IF OBJECT_ID('SP_ObtenerJustificantes', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerJustificantes;
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_ObtenerJustificantes
    @id_empleado INT -- Parámetro para filtrar
AS
BEGIN
    BEGIN TRY
        -- Declarar variable para la ubicación principal del empleado
        DECLARE @Id_ubicacion_empleado INT;

        IF @id_empleado != 0
        BEGIN
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);
        END

        -- Verificar si el empleado tiene acceso a múltiples ubicaciones mediante Ubicaciones_X_Empleado
        IF EXISTS (SELECT 1 FROM Ubicaciones_X_Empleado WHERE id_empleado = @id_empleado)
        BEGIN
            -- Mostrar todos los justificantes de las ubicaciones asociadas al empleado
            SELECT DISTINCT 
                J.id_justificante, 
                J.fecha_registro, 
                J.Permiso_solicitado,
                J.observacion, 
                EST.Estatus, 
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento,
                P.nombre AS Puesto
            FROM 
                JUSTIFICANTE J
            INNER JOIN 
                EMPLEADO E ON J.id_empleado = E.id_empleado
            INNER JOIN 
                Estatus EST ON J.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                PUESTO P ON E.id_puesto = P.id_puesto
            INNER JOIN 
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion
            WHERE 
                UXE.id_empleado = @id_empleado
            ORDER BY 
                J.id_justificante DESC; -- Ordenar por ID de manera descendente
        END
        ELSE
        BEGIN
            -- Mostrar justificantes filtrados por la ubicación principal del empleado
            SELECT 
                J.id_justificante, 
                J.fecha_registro, 
                J.Permiso_solicitado,
                J.observacion, 
                EST.Estatus, 
                E.nombre, 
                E.apellido_paterno,
                E.apellido_materno,
                E.fecha_nacimiento,
                P.nombre AS Puesto
            FROM 
                JUSTIFICANTE J
            INNER JOIN 
                EMPLEADO E ON J.id_empleado = E.id_empleado
            INNER JOIN 
                Estatus EST ON J.ID_Estatus = EST.ID_Estatus
            INNER JOIN 
                PUESTO P ON E.id_puesto = P.id_puesto
            WHERE 
                E.id_ubicacion = @Id_ubicacion_empleado
            ORDER BY 
                J.id_justificante DESC; -- Ordenar por ID de manera descendente
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------
USE NEO_GENESIS
GO

IF OBJECT_ID('dbo.SP_Obtener_Justificante', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SP_Obtener_Justificante;
GO

CREATE PROCEDURE SP_Obtener_Justificante
    @id_justificante INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Retornar el registro correspondiente al id_justificante
    SELECT *
    FROM JUSTIFICANTE
    WHERE id_justificante = @id_justificante;
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------
USE NEO_GENESIS
GO

IF OBJECT_ID('dbo.SP_Insertar_Justificante', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SP_Insertar_Justificante;
GO
  
CREATE PROCEDURE SP_Insertar_Justificante  
    @id_usuario INT,  
    @id_justificante INT OUTPUT -- Parámetro de salida para retornar el ID  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Variables para calcular fecha, hora y folio  
    DECLARE @fecha_registro CHAR(10) = CONVERT(CHAR(10), GETDATE(), 103); -- Formato dd/MM/yyyy  
    DECLARE @hora_registro CHAR(8) = CONVERT(CHAR(8), GETDATE(), 108); -- Formato HH:mm:ss  
    DECLARE @ultimo_id INT;  
    DECLARE @folio_registro CHAR(20);  
  
    -- Obtener el último ID de la tabla  
    SELECT @ultimo_id = ISNULL(MAX(id_justificante), 0) + 1 FROM JUSTIFICANTE;  
  
    -- Calcular el folio basado en el próximo ID  
    SET @folio_registro = CONCAT('J-', @ultimo_id);  
  
    -- Insertar directamente el folio calculado  
    BEGIN TRANSACTION;  
    BEGIN TRY  
        INSERT INTO JUSTIFICANTE (            
            fecha_registro,  
            hora_registro,  
            folio_registro,  
            id_usuario  
        )  
        VALUES (            
            @fecha_registro,  
            @hora_registro,  
            @folio_registro, -- Folio calculado previamente  
            @id_usuario  
        );  
  
        -- Obtener el ID recién insertado  
        SET @id_justificante = SCOPE_IDENTITY();  
  
        COMMIT TRANSACTION;  
    END TRY  
    BEGIN CATCH  
        ROLLBACK TRANSACTION;  
        THROW; -- Re-lanzar el error  
    END CATCH;  
END;  
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------
USE NEO_GENESIS
GO

IF OBJECT_ID('dbo.SP_Actualizar_Justificante', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SP_Actualizar_Justificante;
GO
  
  
CREATE PROCEDURE SP_Actualizar_Justificante  
    @id_justificante INT,  
    @id_ubicacion INT,  
    @id_empleado INT,  
    @naturaleza_permiso NVARCHAR(60),  
    @especificacion_permiso VARCHAR(100),  
    @permiso_solicitado NVARCHAR(100),  
    @otro_permiso NVARCHAR(100),  
    @fecha_falta CHAR(10),  
    @horas_parcial CHAR(2),  
    @pago_horas VARCHAR(50),  
    @observacion NVARCHAR(255),  
    @sueldos VARCHAR(50),  
    @id_usuario INT,  
    @fecha_fin CHAR(10),  
    @institucion VARCHAR(50),  
    @otra_institucion NVARCHAR(100)  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Variable para el ID_Estatus  
    DECLARE @ID_Estatus INT;  
  
    -- Obtener el ID_Estatus basado en las condiciones dadas  
    SELECT @ID_Estatus = E.ID_Estatus  
    FROM Estatus E  
    INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus  
    WHERE TE.TipoEstatus = 'Justificante' AND E.Estatus = 'EN REVISION';  
  
    -- Verificar si se encontró un ID_Estatus  
    IF @ID_Estatus IS NULL  
    BEGIN  
        RAISERROR('No se encontró un ID_Estatus con los criterios especificados.', 16, 1);  
        RETURN;  
    END  
  
    -- Actualizar el registro en la tabla JUSTIFICANTE  
    BEGIN TRANSACTION;  
    BEGIN TRY  
        UPDATE JUSTIFICANTE  
        SET   
            id_ubicacion = @id_ubicacion,  
            id_empleado = @id_empleado,  
            naturaleza_permiso = @naturaleza_permiso,  
            especificacion_permiso = @especificacion_permiso,  
            permiso_solicitado = @permiso_solicitado,  
            otro_permiso = @otro_permiso,  
            fecha_falta = @fecha_falta,  
            horas_parcial = @horas_parcial,  
            pago_horas = @pago_horas,  
            observacion = @observacion,  
            sueldos = @sueldos,  
            id_usuario = @id_usuario,  
            fecha_fin = @fecha_fin,  
            institucion = @institucion,  
            otra_institucion = @otra_institucion,  
            ID_Estatus = @ID_Estatus  
        WHERE id_justificante = @id_justificante;  
  
        COMMIT TRANSACTION;  
    END TRY  
    BEGIN CATCH  
        ROLLBACK TRANSACTION;  
        THROW; -- Relanzar el error para manejarlo externamente  
    END CATCH;  
END;  
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Delete_JUSTIFICANTE')
BEGIN
    DROP PROCEDURE SP_Delete_JUSTIFICANTE
END
GO

CREATE PROCEDURE SP_Delete_JUSTIFICANTE
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM JUSTIFICANTE
    WHERE id_justificante = @id;
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO
IF OBJECT_ID('SP_CheckDiaInhabil_Rango_Weekend', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_CheckDiaInhabil_Rango_Weekend;
END;
GO

-- Luego puedes recrear el stored procedure
CREATE PROCEDURE SP_CheckDiaInhabil_Rango_Weekend
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Variable para contar los días inhábiles
    DECLARE @DiasInhabiles INT = 0;

    -- Tabla temporal para almacenar los días del rango
    DECLARE @Dias TABLE (Fecha DATE);

    -- Insertar todas las fechas del rango en la tabla temporal
    INSERT INTO @Dias (Fecha)
    SELECT DATEADD(DAY, Number, @FechaInicio)
    FROM master..spt_values
    WHERE Type = 'P' AND DATEADD(DAY, Number, @FechaInicio) <= @FechaFin;

    -- Contar los días inhábiles que son fines de semana (sábado o domingo)
    SET @DiasInhabiles = @DiasInhabiles + (
        SELECT COUNT(*)
        FROM @Dias
        WHERE DATEPART(WEEKDAY, Fecha) IN (1, 7)  -- 1 = domingo, 7 = sábado (puede variar según configuración)
    );

    -- Contar los días inhábiles que coinciden con los feriados almacenados en tu tabla de feriados
    SET @DiasInhabiles = @DiasInhabiles + (
        SELECT COUNT(*)
        FROM @Dias
        WHERE Fecha IN (SELECT Fecha FROM Dias_inhabiles) -- Asegúrate de tener una tabla de feriados llamada 'DiasInhabiles'
    );

    -- Devolver el número de días inhábiles
    SELECT @DiasInhabiles AS DiasInhabiles;
END;
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

IF OBJECT_ID('SP_CheckDiaInhabil', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_CheckDiaInhabil;
END;
GO

CREATE PROCEDURE SP_CheckDiaInhabil
    @Fecha DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Variable para almacenar si el día es inhábil
    DECLARE @EsDiaInhabil BIT = 0;

    -- Verificar si la fecha es un fin de semana (sábado o domingo)
    IF DATEPART(WEEKDAY, @Fecha) IN (1, 7)  -- 1 = domingo, 7 = sábado (puede variar según configuración)
    BEGIN
        SET @EsDiaInhabil = 1;
    END

    -- Verificar si la fecha es un día inhábil registrado en la tabla DiasInhabiles
    IF EXISTS (SELECT 1 FROM Dias_inhabiles WHERE Fecha_inhabil = @Fecha)
    BEGIN
        SET @EsDiaInhabil = 1;
    END

    -- Devolver si es inhábil o no
    SELECT @EsDiaInhabil AS EsDiaInhabil;
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------


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
-------------------------------------------------------------------------------------------------------------------------------------------------------------

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




/*
*******************************************************************************************************************************
									ACTUALIZANDO ESTATUS
*******************************************************************************************************************************
*/

DECLARE @ID_ESTATUS_VACACIONES INT = (SELECT E.ID_Estatus FROM Estatus E 
									INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
									WHERE E.Estatus = 'ACEPTADA' AND TE.TipoEstatus = 'Solicitud_Vacaciones');

DECLARE @ID_ESTATUS_INCIDENCIAS INT = (SELECT E.ID_Estatus FROM Estatus E 
									INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
									WHERE E.Estatus = 'ACEPTADA' AND TE.TipoEstatus = 'Incidencias');

DECLARE @ID_ESTATUS_HORASEXTRA INT = (SELECT E.ID_Estatus FROM Estatus E 
									INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
									WHERE E.Estatus = 'ACEPTADA' AND TE.TipoEstatus = 'Horas_Extra');

DECLARE @ID_ESTATUS_PRESTAMOS INT = (SELECT E.ID_Estatus FROM Estatus E 
									INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
									WHERE E.Estatus = 'ACEPTADA' AND TE.TipoEstatus = 'Prestamo');

DECLARE @ID_ESTATUS_JUSTIFICANTES INT = (SELECT E.ID_Estatus FROM Estatus E 
									INNER JOIN TipoEstatus TE ON E.ID_TipoEstatus = TE.ID_TipoEstatus
									WHERE E.Estatus = 'ACEPTADO' AND TE.TipoEstatus = 'Justificante');

UPDATE VACACIONES
SET ID_Estatus = @ID_ESTATUS_VACACIONES

UPDATE INCIDENCIA
SET ID_Estatus = @ID_ESTATUS_INCIDENCIAS

UPDATE HORAS_EXTRAS
SET ID_Estatus = @ID_ESTATUS_HORASEXTRA

UPDATE PRESTAMO
SET ID_Estatus = @ID_ESTATUS_PRESTAMOS

UPDATE JUSTIFICANTE
SET ID_Estatus = @ID_ESTATUS_JUSTIFICANTES

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN descripcion_problema nvarchar(600) NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN img_evidencia varchar(200) NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN img_evidencia2 varchar(200) NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN img_evidencia3 varchar(200) NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN img_evidencia4 varchar(200) NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN estatus nvarchar(30) NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN costo_reparacion float NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN tipo_servicio varchar(20) NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN fecha_servicio char(10) NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN fecha_entrega char(10) NULL;
ALTER TABLE SOLICITUD_MTTO ALTER COLUMN grado_urgencia nvarchar(40) NULL;

ALTER TABLE SOLICITUD_MTTO
ADD Asignado NVARCHAR(MAX) NULL;

GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarSolicitudMtto')
BEGIN
    DROP PROCEDURE sp_InsertarSolicitudMtto
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarSolicitudMtto]
    @fecha_registro DATE,
    @hora_registro TIME,
    @id_usuario INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_solicitud), 0) + 1 FROM [dbo].[SOLICITUD_MTTO]

        DECLARE @folio_solicitud NVARCHAR(50)
        SET @folio_solicitud = CONCAT('SM-', @nextId)

        -- Inserción del registro
        INSERT INTO [dbo].[SOLICITUD_MTTO] (
            folio_solicitud,
            fecha_registro,
            hora_registro,
            id_usuario
        )
        VALUES (
            @folio_solicitud,
            @fecha_registro,
            @hora_registro,
            @id_usuario
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_solicitud INT
        SET @id_solicitud = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_solicitud AS FolioGenerado, @id_solicitud AS ID_Solicitud
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Borrar el procedimiento almacenado si ya existe
IF OBJECT_ID('SP_ObtenerSolicitudesMtto', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerSolicitudesMtto;
END
GO

-- Crear el nuevo procedimiento almacenado
CREATE PROCEDURE SP_ObtenerSolicitudesMtto
AS
BEGIN
    -- Ejecutar la consulta deseada
    SELECT 
        SMT.id_solicitud,
        SMT.id_instalacion,
        SMT.folio_solicitud,
        SMT.fecha_registro,
        SMT.hora_registro,
        SMT.id_ubicacion,
        SMT.id_empleado,
        E.nombre AS nombre_empleado,
        E.apellido_paterno AS apellido_empleado,
        E.apellido_materno AS materno_empleado,
        SMT.id_categoria,
        C.nombre_categoria,
        SMT.id_maquinaria,
        -- Usar CASE para decidir entre maquinaria o instalaciones
        CASE 
            WHEN SMT.id_categoria = 29 THEN I.nombre
            ELSE M.modelo
        END AS nombre_referencia,
        SMT.horometro,
        SMT.fecha_servicio,
        SMT.fecha_entrega,
        SMT.grado_urgencia,
        SMT.id_responsable,
        R.nombre AS nombre_responsable,
        R.apellido_paterno AS apellido_responsable,
        SMT.costo_reparacion,
        SMT.tipo_servicio,
        SMT.id_respReparacion,
        RR.nombre AS nombre_responsable_reparacion,
        SMT.proveedor_reparacion,
        SMT.descripcion_problema,
        SMT.img_evidencia,
        SMT.img_evidencia2,
        SMT.img_evidencia3,
        SMT.img_evidencia4,
        SMT.estatus,
        SMT.id_usuario,
        U.nombre AS NombreUbicacion,
        C.nombre_categoria AS categoria_nombre,
        M.no_economico,
		M.modelo AS nombre_maquinaria
    FROM SOLICITUD_MTTO SMT
    INNER JOIN EMPLEADO E ON SMT.id_empleado = E.id_empleado
    LEFT JOIN CATEGORIA C ON SMT.id_categoria = C.id_categoria
    LEFT JOIN MAQUINARIA M ON SMT.id_maquinaria = M.id_maquinaria
    LEFT JOIN INSTALACION I ON SMT.id_instalacion = I.id_instalacion -- Relación con instalaciones
    LEFT JOIN EMPLEADO R ON SMT.id_responsable = R.id_empleado
    LEFT JOIN EMPLEADO RR ON SMT.id_respReparacion = RR.id_empleado
    LEFT JOIN UBICACION U ON SMT.id_ubicacion = U.id_ubicacion
    ORDER BY id_solicitud DESC;
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ObtenerSolicitudMttoPorId')
BEGIN
    DROP PROCEDURE sp_ObtenerSolicitudMttoPorId
END
GO

CREATE PROCEDURE [dbo].[sp_ObtenerSolicitudMttoPorId]
    @id_solicitud INT
AS
BEGIN
    BEGIN TRY
        -- Selecciona el registro de la tabla SOLICITUD_MTTO por id_solicitud
        SELECT 
            SMT.id_solicitud,
            SMT.id_instalacion,
            SMT.folio_solicitud,
            SMT.fecha_registro,
            SMT.hora_registro,
            SMT.id_ubicacion,
            SMT.id_empleado,
            E.nombre AS nombre_empleado,
            E.apellido_paterno AS apellido_empleado,
            E.apellido_materno AS materno_empleado,
            SMT.id_categoria,
            C.nombre_categoria,
            SMT.id_maquinaria,
            -- Usar CASE para determinar si consultar INSTALACION o MAQUINARIA
            CASE 
                WHEN SMT.id_categoria = 29 THEN I.nombre
                ELSE M.modelo
            END AS nombre_referencia,
            SMT.horometro,
            SMT.fecha_servicio,
            SMT.fecha_entrega,
            SMT.grado_urgencia,
            SMT.id_responsable,
            R.nombre AS nombre_responsable,
            R.apellido_paterno AS apellido_responsable,
            SMT.costo_reparacion,
            SMT.tipo_servicio,
            SMT.id_respReparacion,
            RR.nombre AS nombre_responsable_reparacion,
            SMT.proveedor_reparacion,
            SMT.descripcion_problema,
            SMT.img_evidencia,
            SMT.img_evidencia2,
            SMT.img_evidencia3,
            SMT.img_evidencia4,
            SMT.estatus,
            SMT.id_usuario,
            U.nombre AS NombreUbicacion,
            C.nombre_categoria AS categoria_nombre,
            M.no_economico,
            SMT.Asignado,
			M.modelo AS nombre_maquinaria,
			I.descripcion AS instalacionDescripcion
        FROM SOLICITUD_MTTO SMT
        LEFT JOIN EMPLEADO E ON SMT.id_empleado = E.id_empleado
        LEFT JOIN CATEGORIA C ON SMT.id_categoria = C.id_categoria
        LEFT JOIN MAQUINARIA M ON SMT.id_maquinaria = M.id_maquinaria
        LEFT JOIN INSTALACION I ON SMT.id_instalacion = I.id_instalacion -- Relación con INSTALACION
        LEFT JOIN EMPLEADO R ON SMT.id_responsable = R.id_empleado
        LEFT JOIN EMPLEADO RR ON SMT.id_respReparacion = RR.id_empleado
        LEFT JOIN UBICACION U ON SMT.id_ubicacion = U.id_ubicacion
        WHERE SMT.id_solicitud = @id_solicitud
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ActualizarSolicitudMtto', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ActualizarSolicitudMtto;
END
GO

CREATE PROCEDURE SP_ActualizarSolicitudMtto
    @id_solicitud INT,
    @id_ubicacion INT = NULL,
    @id_empleado INT = NULL,
    @id_categoria INT = NULL,
    @id_maquinaria INT = NULL,
    @horometro INT = NULL,
    @fecha_servicio DATE = NULL, -- Cambiado a DATE
    @fecha_entrega DATE = NULL, -- Cambiado a DATE
    @grado_urgencia NVARCHAR(80) = NULL,
    @id_responsable INT = NULL,
    @costo_reparacion FLOAT = NULL,
    @tipo_servicio VARCHAR(20) = NULL,
    @id_respReparacion INT = NULL,
    @proveedor_reparacion NVARCHAR(200) = NULL,
    @descripcion_problema NVARCHAR(1200) = NULL,
    @asignado NVARCHAR(1200) = NULL,
    @estatus NVARCHAR(60) = NULL,
    @id_usuario INT = NULL,
    @NombreArchivo1 NVARCHAR(200) = NULL,
    @NombreArchivo2 NVARCHAR(200) = NULL,
    @NombreArchivo3 NVARCHAR(200) = NULL,
    @NombreArchivo4 NVARCHAR(200) = NULL,
    @idInstalacion INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validación para verificar que la solicitud existe antes de actualizarla
        IF EXISTS (SELECT 1 FROM SOLICITUD_MTTO WHERE id_solicitud = @id_solicitud)
        BEGIN
            -- Convertir las fechas a formato DD/MM/YYYY
            DECLARE @FechaServicioFormatted CHAR(10) = NULL;
            DECLARE @FechaEntregaFormatted CHAR(10) = NULL;

            IF @fecha_servicio IS NOT NULL
                SET @FechaServicioFormatted = CONVERT(CHAR(10), @fecha_servicio, 103); -- Formato DD/MM/YYYY

            IF @fecha_entrega IS NOT NULL
                SET @FechaEntregaFormatted = CONVERT(CHAR(10), @fecha_entrega, 103); -- Formato DD/MM/YYYY

            -- Actualizar la solicitud
            UPDATE SOLICITUD_MTTO
            SET 
                id_ubicacion = ISNULL(@id_ubicacion, id_ubicacion),
                id_empleado = ISNULL(@id_empleado, id_empleado),
                id_categoria = ISNULL(@id_categoria, id_categoria),
                id_maquinaria = ISNULL(@id_maquinaria, id_maquinaria),
                horometro = ISNULL(@horometro, horometro),
                fecha_servicio = ISNULL(@FechaServicioFormatted, fecha_servicio),
                fecha_entrega = ISNULL(@FechaEntregaFormatted, fecha_entrega),
                grado_urgencia = ISNULL(@grado_urgencia, grado_urgencia),
                id_responsable = ISNULL(@id_responsable, id_responsable),
                costo_reparacion = ISNULL(@costo_reparacion, costo_reparacion),
                tipo_servicio = ISNULL(@tipo_servicio, tipo_servicio),
                id_respReparacion = ISNULL(@id_respReparacion, id_respReparacion),
                proveedor_reparacion = ISNULL(@proveedor_reparacion, proveedor_reparacion),
                descripcion_problema = ISNULL(@descripcion_problema, descripcion_problema),
                id_usuario = ISNULL(@id_usuario, id_usuario),
                fecha_registro = CONVERT(CHAR(10), GETDATE(), 103),
                hora_registro = CONVERT(CHAR(8), GETDATE(), 108),
                estatus = 'En Proceso',
                Asignado = @asignado,
                img_evidencia = @NombreArchivo1,
                img_evidencia2 = @NombreArchivo2,
                img_evidencia3 = @NombreArchivo3,
                img_evidencia4 = @NombreArchivo4,
                id_instalacion = @idInstalacion
            WHERE 
                id_solicitud = @id_solicitud;

            -- Mensaje de confirmación
            SELECT 'Solicitud de mantenimiento actualizada exitosamente.' AS Mensaje, @id_solicitud AS ID_Solicitud;
        END
        ELSE
        BEGIN
            -- Si no se encuentra la solicitud, lanza un error
            RAISERROR('No se encontró la solicitud de mantenimiento con el ID especificado.', 16, 1);
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------
USE NEO_GENESIS
GO
ALTER TABLE ORDEN_MTTO
ALTER COLUMN tipo_servicio CHAR(20) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN refacciones VARCHAR(30) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN falla_corregida CHAR(2) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN tiempo_invertido VARCHAR(20) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN img_solucion VARCHAR(200) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN img_solucion2 VARCHAR(200) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN img_solucion3 VARCHAR(200) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN img_solucion4 VARCHAR(200) NULL;

ALTER TABLE ORDEN_MTTO
ALTER COLUMN diagnostico_falla NVARCHAR(600) NULL;

GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Get_ORDEN_MTTO')
BEGIN
    DROP PROCEDURE SP_Get_ORDEN_MTTO
END
GO

CREATE PROCEDURE SP_Get_ORDEN_MTTO
    @id_orden INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Seleccionar el registro correspondiente al id_orden
        SELECT *
        FROM ORDEN_MTTO
        WHERE id_orden = @id_orden;
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_InsertarOrdenMtto')
BEGIN
    DROP PROCEDURE sp_InsertarOrdenMtto
END
GO

CREATE PROCEDURE [dbo].[sp_InsertarOrdenMtto]
    
    @id_solicitud INT
AS
BEGIN
    BEGIN TRY
        -- Generar el folio de registro basado en el próximo ID
        DECLARE @nextId INT
        SELECT @nextId = ISNULL(MAX(id_orden), 0) + 1 FROM [dbo].[ORDEN_MTTO]

        DECLARE @folio_orden NVARCHAR(50)
        SET @folio_orden = CONCAT('OM-', @nextId)

		DECLARE @ID_Empleado INT = (SELECT id_empleado FROM SOLICITUD_MTTO WHERE id_solicitud = @id_solicitud);

        -- Obtener la fecha y hora actual
        DECLARE @fecha_registro CHAR(10)
        DECLARE @hora_registro CHAR(8)
        SELECT @fecha_registro = CONVERT(CHAR(10), GETDATE(), 120), -- yyyy-MM-dd
               @hora_registro = CONVERT(CHAR(8), GETDATE(), 108)    -- HH:mm:ss

        -- Inserción del registro
        INSERT INTO [dbo].[ORDEN_MTTO] (
            folio_orden,
            fecha_registro,
            hora_registro,
            id_solicitud,
			id_empleado
        )
        VALUES (
            @folio_orden,
            @fecha_registro,
            @hora_registro,
            @id_solicitud,
			@ID_Empleado
        )

        -- Obtener el ID del registro insertado
        DECLARE @id_orden INT
        SET @id_orden = SCOPE_IDENTITY()

        -- Confirmación de éxito
        SELECT 'Registro insertado exitosamente.' AS Mensaje, @folio_orden AS FolioGenerado, @id_orden AS ID_Orden
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ActualizarOrdenMtto', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ActualizarOrdenMtto;
END
GO

CREATE PROCEDURE SP_ActualizarOrdenMtto
    @id_orden INT,
    @tipo_servicio CHAR(20) = NULL,
    @id_empleado INT = NULL,
    @atendido_externo NVARCHAR(200) = NULL,
    @diagnostico_falla NVARCHAR(1200) = NULL,
    @observaciones NVARCHAR(1200) = NULL,
    @refacciones VARCHAR(200) = NULL,
    @folio_almacen VARCHAR(50) = NULL,
    @folio_compras VARCHAR(50) = NULL,
    @falla_corregida CHAR(2) = NULL,
    @tiempo_invertido VARCHAR(50) = NULL,
    @id_usuario INT = NULL,
	@img_solucion NVARCHAR(MAX) = NULL,
	@img_solucion2 NVARCHAR(MAX) = NULL,	
	@img_solucion3 NVARCHAR(MAX) = NULL,
	@img_solucion4 NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validación para verificar que la orden existe antes de actualizarla
        IF EXISTS (SELECT 1 FROM ORDEN_MTTO WHERE id_orden = @id_orden)
        BEGIN
            UPDATE ORDEN_MTTO
            SET 
                tipo_servicio = ISNULL(@tipo_servicio, tipo_servicio),
                --id_empleado = ISNULL(@id_empleado, id_empleado),
                atendido_externo = ISNULL(@atendido_externo, atendido_externo),
                diagnostico_falla = ISNULL(@diagnostico_falla, diagnostico_falla),
                observaciones = ISNULL(@observaciones, observaciones),
                refacciones = ISNULL(@refacciones, refacciones),
                folio_almacen = ISNULL(@folio_almacen, folio_almacen),
                folio_compras = ISNULL(@folio_compras, folio_compras),
                falla_corregida = ISNULL(@falla_corregida, falla_corregida),
                tiempo_invertido = ISNULL(@tiempo_invertido, tiempo_invertido),
				img_solucion = ISNULL(@img_solucion, img_solucion),
				img_solucion2 = ISNULL(@img_solucion2, img_solucion2),
				img_solucion3 = ISNULL(@img_solucion3, img_solucion3),
				img_solucion4 = ISNULL(@img_solucion4, img_solucion4)
            WHERE 
                id_orden = @id_orden;

			UPDATE SOLICITUD_MTTO
			SET estatus = 'Finalizado'
			WHERE id_solicitud = (SELECT id_solicitud FROM ORDEN_MTTO WHERE id_orden = @id_orden)
            -- Mensaje de confirmación
            SELECT 'Orden de mantenimiento actualizada exitosamente.' AS Mensaje, @id_orden AS ID_Orden;
        END
        ELSE
        BEGIN
            -- Si no se encuentra la orden, lanza un error
            RAISERROR('No se encontró la orden de mantenimiento con el ID especificado.', 16, 1);
        END

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ActualizarOrdenMtto', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ActualizarOrdenMtto;
END
GO

CREATE PROCEDURE SP_ActualizarOrdenMtto
    @id_orden INT,
    @tipo_servicio CHAR(20) = NULL,
    @id_empleado INT = NULL,
    @atendido_externo NVARCHAR(200) = NULL,
    @diagnostico_falla NVARCHAR(1200) = NULL,
    @observaciones NVARCHAR(1200) = NULL,
    @refacciones VARCHAR(200) = NULL,
    @folio_almacen VARCHAR(50) = NULL,
    @folio_compras VARCHAR(50) = NULL,
    @falla_corregida CHAR(2) = NULL,
    @tiempo_invertido VARCHAR(50) = NULL,
    @id_usuario INT = NULL,
	@img_solucion NVARCHAR(MAX) = NULL,
	@img_solucion2 NVARCHAR(MAX) = NULL,	
	@img_solucion3 NVARCHAR(MAX) = NULL,
	@img_solucion4 NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Validación para verificar que la orden existe antes de actualizarla
        IF EXISTS (SELECT 1 FROM ORDEN_MTTO WHERE id_orden = @id_orden)
        BEGIN
            UPDATE ORDEN_MTTO
            SET 
                tipo_servicio = ISNULL(@tipo_servicio, tipo_servicio),
                --id_empleado = ISNULL(@id_empleado, id_empleado),
                atendido_externo = ISNULL(@atendido_externo, atendido_externo),
                diagnostico_falla = ISNULL(@diagnostico_falla, diagnostico_falla),
                observaciones = ISNULL(@observaciones, observaciones),
                refacciones = ISNULL(@refacciones, refacciones),
                folio_almacen = ISNULL(@folio_almacen, folio_almacen),
                folio_compras = ISNULL(@folio_compras, folio_compras),
                falla_corregida = ISNULL(@falla_corregida, falla_corregida),
                tiempo_invertido = ISNULL(@tiempo_invertido, tiempo_invertido),
				img_solucion = ISNULL(@img_solucion, img_solucion),
				img_solucion2 = ISNULL(@img_solucion2, img_solucion2),
				img_solucion3 = ISNULL(@img_solucion3, img_solucion3),
				img_solucion4 = ISNULL(@img_solucion4, img_solucion4)
            WHERE 
                id_orden = @id_orden;

			UPDATE SOLICITUD_MTTO
			SET estatus = 'Finalizado'
			WHERE id_solicitud = (SELECT id_solicitud FROM ORDEN_MTTO WHERE id_orden = @id_orden)
            -- Mensaje de confirmaciónSP_Obtener_Usuarios
            SELECT 'Orden de mantenimiento actualizada exitosamente.' AS Mensaje, @id_orden AS ID_Orden;
        END
        ELSE
        BEGIN
            -- Si no se encuentra la orden, lanza un error
            RAISERROR('No se encontró la orden de mantenimiento con el ID especificado.', 16, 1);
        END

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_Obtener_Menus_ConEstado', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_Obtener_Menus_ConEstado;
END
GO

 CREATE PROCEDURE SP_Obtener_Menus_ConEstado     @idUsuario INT 
 AS BEGIN     
 SET NOCOUNT ON;  
 DECLARE @IDASP NVARCHAR(MAX)= (SELECT Id FROM AspNetUsers WHERE id_usuario = @idUsuario);    
 SELECT          M.ID_Menu,         M.Nombre_Menu,
 CASE              WHEN MU.ID_Usuario IS NOT NULL THEN CAST(1 AS BIT) -- Si existe en Menu_Usuario, retorna TRUE   
 ELSE CAST(0 AS BIT) -- Si no existe, retorna FALSE      
   END AS EstaAsignado     FROM Menu M     LEFT JOIN Menu_Usuario MU ON MU.ID_Menu = M.ID_Menu AND MU.ID_Usuario = @IDASP; END 

-------------------------------------------------------------------------------------------------------------------------------------------------------------

USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_Select_Empleados', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_Select_Empleados;
END
GO

  
CREATE PROCEDURE SP_Select_Empleados  
AS  
BEGIN  
    SELECT   
        E.id_empleado,  
        E.nombre,  
        E.apellido_paterno,  
  E.apellido_materno,  
        P.descripcion  
    FROM   
        EMPLEADO E  
  INNER JOIN PUESTO P ON E.id_puesto = P.id_puesto;  
END;  
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------


USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_ObtenerMisEmpleadosPorUbicacion', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_ObtenerMisEmpleadosPorUbicacion;
END
GO

  
-- Crear el nuevo procedimiento almacenado  
CREATE PROCEDURE SP_ObtenerMisEmpleadosPorUbicacion  
    @id_empleado INT -- Parámetro para identificar al empleado que realiza la consulta  
AS  
BEGIN  
    BEGIN TRY  
        -- Declarar variable para la ubicación principal del empleado  
        DECLARE @Id_ubicacion_empleado INT;  
  
        IF @id_empleado != 0  
        BEGIN  
            SET @Id_ubicacion_empleado = (SELECT id_ubicacion FROM EMPLEADO WHERE id_empleado = @id_empleado);  
        END  
  
        -- Verificar si el empleado tiene acceso a múltiples ubicaciones mediante Ubicaciones_X_Empleado  
        IF EXISTS (SELECT 1 FROM Ubicaciones_X_Empleado WHERE id_empleado = @id_empleado)  
        BEGIN  
            -- Mostrar empleados de las ubicaciones asociadas al empleado  
            SELECT DISTINCT   
                E.*,   
                CASE   
                    WHEN CHARINDEX('\\', img_empleado) > 0   
                    THEN RIGHT(img_empleado, CHARINDEX('\\', REVERSE(img_empleado)) - 1)   
                    ELSE ISNULL(img_empleado, '')   
                END AS Img_empleado_nombre,   
                P.nombre AS Puesto  
            FROM   
                EMPLEADO E  
            INNER JOIN   
                PUESTO P ON E.id_puesto = P.id_puesto  
            INNER JOIN   
                Ubicaciones_X_Empleado UXE ON E.id_ubicacion = UXE.id_ubicacion  
            WHERE   
                UXE.id_empleado = @id_empleado  
                AND E.id_empleado != 25 -- Excluir empleado con ID 25  
            ORDER BY   
                E.id_empleado ASC; -- Ordenar por ID de empleado de manera ascendente  
        END  
        ELSE  
        BEGIN  
            -- Mostrar empleados filtrados por la ubicación principal del empleado  
            SELECT   
                E.*,   
                CASE   
                    WHEN CHARINDEX('\\', img_empleado) > 0   
                    THEN RIGHT(img_empleado, CHARINDEX('\\', REVERSE(img_empleado)) - 1)   
                    ELSE ISNULL(img_empleado, '')   
                END AS Img_empleado_nombre,   
                P.nombre AS Puesto  
            FROM   
                EMPLEADO E  
            INNER JOIN   
                PUESTO P ON E.id_puesto = P.id_puesto  
            WHERE   
                E.id_ubicacion = @Id_ubicacion_empleado  
                AND E.id_empleado != 25 -- Excluir empleado con ID 25  
            ORDER BY   
                E.id_empleado ASC; -- Ordenar por ID de empleado de manera ascendente  
        END  
    END TRY  
    BEGIN CATCH  
        -- Manejo de errores  
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;  
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();  
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);  
    END CATCH  
END;  
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------


USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('sp_obtenerEmpleados_SolicitudMantenimiento_ubicacion', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_obtenerEmpleados_SolicitudMantenimiento_ubicacion;
END
GO
  
-- Creación del Stored Procedure  
CREATE PROCEDURE [dbo].[sp_obtenerEmpleados_SolicitudMantenimiento_ubicacion]  
    @id_ubicacion INT -- Parámetro para filtrar por ubicación  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Seleccionar empleados desde ambas fuentes con un DISTINCT  
    SELECT DISTINCT   
        E.id_empleado,  
        E.folio_registro,  
        E.hora_registro,  
        E.fecha_registro,  
        E.empleado,  
        E.fecha_ingreso,  
        E.apellido_paterno,  
        E.apellido_materno,  
        E.nombre,  
        E.fecha_nacimiento,  
        E.genero,  
        E.domicilio,  
        E.colonia,  
        E.cp,  
        E.municipio,  
        E.peso,  
        E.estatura,  
        E.lugar_nacimiento,  
        E.nacionalidad,  
        E.telefono,  
        E.celular,  
        E.correo,  
        E.estado_civil,  
        E.curp,  
        E.rfc,  
        E.seguro,  
        E.nss,  
        E.licencia,  
        E.clase,  
        E.no_licencia,  
        E.vigencia,  
        E.afore,  
        E.discapacidad,  
        E.descripcion_discap,  
        E.estado_salud,  
        E.nivel_estudios,  
        E.carrera,  
        E.titulacion,  
        E.cedula,  
        E.nombre_contacto,  
        E.parentesco_contacto,  
        E.celular_contacto,  
        E.domicilio_contacto,  
        E.cp_contacto,  
        E.nombre_contacto2,  
        E.parentesco_contacto2,  
        E.celular_contacto2,  
        E.domicilio_contacto2,  
        E.cp_contacto2,  
        E.nombre_contacto3,  
        E.parentesco_contacto3,  
        E.celular_contacto3,  
        E.domicilio_contacto3,  
        E.cp_contacto3,  
        E.id_puesto,  
        E.id_departamento,  
        E.id_ubicacion,  
        E.id_empresa,  
        E.horario_entrada,  
        E.horario_salida,  
        E.tipo_pago,  
        E.tipo_periodo,  
        E.sueldo_neto,  
        E.salario,  
        E.tipo_contrato,  
        E.asignacion_equipo,  
        E.asignacion_vehiculo,  
        E.img_contrato,  
        E.id_usuario,  
        E.vacaciones,  
        E.firma_digital  
    FROM   
        EMPLEADO E  
    LEFT JOIN   
        Ubicaciones_X_Empleado UXE ON E.id_empleado = UXE.id_empleado  
    WHERE   
        (UXE.id_ubicacion = @id_ubicacion OR E.id_ubicacion = @id_ubicacion)  
        AND E.id_empleado IN (  
            31, 34, 39, 36, 13, 72, 50, 25, 44, 63,  
            35, 77, 37, 69  
        )  
    ORDER BY   
        E.id_empleado ASC; -- Ordenar por ID de empleado en orden ascendente  
END;  
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------


USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('SP_GetEvidenciasPorTabla', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE SP_GetEvidenciasPorTabla;
END
GO
  

    
-- Crea el Stored Procedure  
CREATE PROCEDURE SP_GetEvidenciasPorTabla  
    @ID_Tabla INT  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    BEGIN TRY  
        -- Selecciona los registros de la tabla Evidencias filtrando por ID_Tabla y ID_TipoEvidencia = 2  
        SELECT ID_Evidencia, ID_Tabla, NombreArchivo, id_usuario, FechaInserto, ID_TipoEvidencia  
        FROM Evidencias  
        WHERE ID_Tabla = @ID_Tabla  
          AND ID_TipoEvidencia = 2;  
  
    END TRY  
    BEGIN CATCH  
        -- Manejo de errores  
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;  
        SELECT @ErrorMsg = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();  
        RAISERROR(@ErrorMsg, @ErrorSeverity, @ErrorState);  
    END CATCH  
END;  

GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------



