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
