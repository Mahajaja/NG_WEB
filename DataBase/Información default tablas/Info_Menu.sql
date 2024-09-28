USE NEO_GENESIS
GO


INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Almac�n', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Compras', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Certificaciones', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Comprobaci�n de gastos', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Institucional', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Mantenimiento', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Producci�n', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Proyectos Especiales', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Recursos Humanos', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Veh�culos', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Ventas', NULL);
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu) VALUES ('Cat�logos', NULL);

-- Declaraci�n de variables para almacenar los IDs de los men�s principales
DECLARE @ID_PADRE_Almacen INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Almac�n');
DECLARE @ID_PADRE_Compras INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Compras');
DECLARE @ID_PADRE_Certificaciones INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Certificaciones');
DECLARE @ID_PADRE_ComprobacionGastos INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Comprobaci�n de gastos');
DECLARE @ID_PADRE_Institucional INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Institucional');
DECLARE @ID_PADRE_Mantenimiento INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Mantenimiento');
DECLARE @ID_PADRE_Produccion INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Producci�n');
DECLARE @ID_PADRE_ProyectosEspeciales INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Proyectos Especiales');
DECLARE @ID_PADRE_RecursosHumanos INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Recursos Humanos');
DECLARE @ID_PADRE_Vehiculos INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Veh�culos');
DECLARE @ID_PADRE_Ventas INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Ventas');
DECLARE @ID_PADRE_Catalogos INT = (SELECT ID_Menu FROM Menu WHERE Nombre_Menu = 'Cat�logos');

-- Almac�n Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Registro de Almac�n', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta de Productos', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Entradas', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Salidas', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Traspasos', @ID_PADRE_Almacen, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Asignaci�n de Maquinaria', @ID_PADRE_Almacen, '', '');

-- Compras Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta de Proveedores', @ID_PADRE_Compras, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Compra', @ID_PADRE_Compras, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Orden de Compra', @ID_PADRE_Compras, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Fondo Fijo', @ID_PADRE_Compras, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Cotizaciones', @ID_PADRE_Compras, '', '');

-- Certificaciones Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Calendario de Certificaciones', @ID_PADRE_Certificaciones, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Certificados', @ID_PADRE_Certificaciones, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Manuales', @ID_PADRE_Certificaciones, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('An�lisis de Laboratorio', @ID_PADRE_Certificaciones, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Lista de Productos Permitidos', @ID_PADRE_Certificaciones, '', '');

-- Comprobaci�n de Gastos Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Ingreso', @ID_PADRE_ComprobacionGastos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Egresos', @ID_PADRE_ComprobacionGastos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Reembolso', @ID_PADRE_ComprobacionGastos, '', '');

-- Institucional Submen�
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Documentos Oficiales', @ID_PADRE_Institucional, '', '');

-- Mantenimiento Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de mantenimiento', @ID_PADRE_Mantenimiento, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Mantenimientos Generales', @ID_PADRE_Mantenimiento, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Mis Mantenimientos', @ID_PADRE_Mantenimiento, '', '');

-- Producci�n Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Combustibles', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Fertilizaci�n', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Fumigadas', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Labores Culturales', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Plagas y Enfermedades', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Proyectos Especiales', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Uso del Agua', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Plan de Trabajo Semanal', @ID_PADRE_Produccion, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Estaci�n Meteorol�gica', @ID_PADRE_Produccion, '', '');

-- Proyectos Especiales Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Nueva obra', @ID_PADRE_ProyectosEspeciales, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Modificaci�n Estructural', @ID_PADRE_ProyectosEspeciales, '', '');

-- Recursos Humanos Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta del Empleado', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Vacaciones', @ID_PADRE_RecursosHumanos, 'Solicitud_Vacaciones', 'Index');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Incidencias', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Pr�stamos', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Horas Extras', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Asistencia', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Asignaci�n de Equipo', @ID_PADRE_RecursosHumanos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Solicitud de Justificante Laboral', @ID_PADRE_RecursosHumanos, '', '');

-- Veh�culos Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Revisi�n Trimestral', @ID_PADRE_Vehiculos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Eventos Unidades', @ID_PADRE_Vehiculos, '', '');

-- Ventas Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Programaci�n de Cortes', @ID_PADRE_Ventas, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Nacional', @ID_PADRE_Ventas, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Ca�do', @ID_PADRE_Ventas, '', '');

-- Cat�logos Submen�s
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Categor�a', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Departamento', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Maquinaria', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Mobiliario', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Subcategor�a', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Ubicaciones', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Veh�culos', @ID_PADRE_Catalogos, '', '');
INSERT INTO Menu (Nombre_Menu, ID_PadreMenu, Controlador, Accion) VALUES ('Alta Ventas (Calibres)', @ID_PADRE_Catalogos, '', '');
