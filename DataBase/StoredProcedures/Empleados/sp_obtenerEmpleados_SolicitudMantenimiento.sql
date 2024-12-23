USE NEO_GENESIS
GO

-- Verifica si el Stored Procedure existe, si es así, lo elimina
IF OBJECT_ID('dbo.sp_obtenerEmpleados_SolicitudMantenimiento_ubicacion', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_obtenerEmpleados_SolicitudMantenimiento_ubicacion;
GO

-- Creación del Stored Procedure
CREATE PROCEDURE [dbo].[sp_obtenerEmpleados_SolicitudMantenimiento_ubicacion]
AS
BEGIN
    SET NOCOUNT ON;

    -- Seleccionar empleados con los id_empleado especificados
    SELECT 
        id_empleado,
        folio_registro,
        hora_registro,
        fecha_registro,
        empleado,
        fecha_ingreso,
        apellido_paterno,
        apellido_materno,
        nombre,
        fecha_nacimiento,
        genero,
        domicilio,
        colonia,
        cp,
        municipio,
        peso,
        estatura,
        lugar_nacimiento,
        nacionalidad,
        telefono,
        celular,
        correo,
        estado_civil,
        curp,
        rfc,
        seguro,
        nss,
        licencia,
        clase,
        no_licencia,
        vigencia,
        afore,
        discapacidad,
        descripcion_discap,
        estado_salud,
        nivel_estudios,
        carrera,
        titulacion,
        cedula,
        nombre_contacto,
        parentesco_contacto,
        celular_contacto,
        domicilio_contacto,
        cp_contacto,
        nombre_contacto2,
        parentesco_contacto2,
        celular_contacto2,
        domicilio_contacto2,
        cp_contacto2,
        nombre_contacto3,
        parentesco_contacto3,
        celular_contacto3,
        domicilio_contacto3,
        cp_contacto3,
        id_puesto,
        id_departamento,
        id_ubicacion,
        id_empresa,
        horario_entrada,
        horario_salida,
        tipo_pago,
        tipo_periodo,
        sueldo_neto,
        salario,
        tipo_contrato,
        asignacion_equipo,
        asignacion_vehiculo,
        img_contrato,
        id_usuario,
        vacaciones,
        firma_digital
    FROM 
        EMPLEADO
    WHERE 
        id_empleado IN (13, 25, 31, 34, 36, 39, 64, 72, 50)
    ORDER BY 
        id_empleado ASC; -- Ordenar por ID de empleado en orden ascendente
END;
GO
