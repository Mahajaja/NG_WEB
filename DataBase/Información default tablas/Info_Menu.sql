USE NEO_GENESIS
GO


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
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Registro de Almacén', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta de Productos', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Entradas', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Salidas', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Traspasos', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Asignación de Maquinaria', @ID_PADRE_Almacen, '', '');

-- Compras Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta de Proveedores', @ID_PADRE_Compras, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Compra', @ID_PADRE_Compras, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Orden de Compra', @ID_PADRE_Compras, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Fondo Fijo', @ID_PADRE_Compras, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Cotizaciones', @ID_PADRE_Compras, '', '');

-- Certificaciones Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Calendario de Certificaciones', @ID_PADRE_Certificaciones, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Certificados', @ID_PADRE_Certificaciones, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Manuales', @ID_PADRE_Certificaciones, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Análisis de Laboratorio', @ID_PADRE_Certificaciones, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Lista de Productos Permitidos', @ID_PADRE_Certificaciones, '', '');

-- Comprobación de Gastos Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Ingreso', @ID_PADRE_ComprobacionGastos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Egresos', @ID_PADRE_ComprobacionGastos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Reembolso', @ID_PADRE_ComprobacionGastos, '', '');

-- Institucional Submenú
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Documentos Oficiales', @ID_PADRE_Institucional, '', '');

-- Mantenimiento Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de mantenimiento', @ID_PADRE_Mantenimiento, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Mantenimientos Generales', @ID_PADRE_Mantenimiento, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Mis Mantenimientos', @ID_PADRE_Mantenimiento, '', '');

-- Producción Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Combustibles', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Fertilización', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Fumigadas', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Labores Culturales', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Plagas y Enfermedades', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Proyectos Especiales', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Uso del Agua', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Plan de Trabajo Semanal', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Estación Meteorológica', @ID_PADRE_Produccion, '', '');

-- Proyectos Especiales Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Nueva obra', @ID_PADRE_ProyectosEspeciales, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Modificación Estructural', @ID_PADRE_ProyectosEspeciales, '', '');

-- Recursos Humanos Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta del Empleado', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Vacaciones', @ID_PADRE_RecursosHumanos, 'Solicitud_Vacaciones', 'Index');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Incidencias', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Préstamos', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Horas Extras', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Asistencia', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Asignación de Equipo', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Justificante Laboral', @ID_PADRE_RecursosHumanos, '', '');

-- Vehículos Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Revisión Trimestral', @ID_PADRE_Vehiculos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Eventos Unidades', @ID_PADRE_Vehiculos, '', '');

-- Ventas Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Programación de Cortes', @ID_PADRE_Ventas, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Nacional', @ID_PADRE_Ventas, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Caído', @ID_PADRE_Ventas, '', '');

-- Catálogos Submenús
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Categoría', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Departamento', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Maquinaria', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Mobiliario', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Subcategoría', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Ubicaciones', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Vehículos', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Ventas (Calibres)', @ID_PADRE_Catalogos, '', '');
