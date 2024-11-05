  
-- Crear el nuevo procedimiento almacenado  
CREATE PROCEDURE SP_GetEmpleadoById  
    @IdEmpleado INT  
AS  
BEGIN  
    SET NOCOUNT ON;  
  
    -- Seleccionar los datos del empleado por su ID  
    SELECT   
        ISNULL(id_empleado, 0) AS id_empleado,  
        ISNULL(folio_registro, '') AS folio_registro,  
        ISNULL(hora_registro, '') AS hora_registro,  
        ISNULL(fecha_registro, '') AS fecha_registro,  
        ISNULL(empleado, 0) AS empleado,  
        ISNULL(fecha_ingreso, '') AS fecha_ingreso,  
        ISNULL(apellido_paterno, '') AS apellido_paterno,  
        ISNULL(apellido_materno, '') AS apellido_materno,  
        ISNULL(nombre, '') AS nombre,  
        ISNULL(fecha_nacimiento, '') AS fecha_nacimiento,  
        ISNULL(genero, '') AS genero,  
        ISNULL(domicilio, '') AS domicilio,  
        ISNULL(colonia, '') AS colonia,  
        ISNULL(cp, '') AS cp,  
        ISNULL(municipio, '') AS municipio,  
        ISNULL(peso, '') AS peso,  
        ISNULL(estatura, '') AS estatura,  
        ISNULL(lugar_nacimiento, '') AS lugar_nacimiento,  
        ISNULL(nacionalidad, '') AS nacionalidad,  
        ISNULL(telefono, '') AS telefono,  
        ISNULL(celular, '') AS celular,  
        ISNULL(correo, '') AS correo,  
        ISNULL(estado_civil, '') AS estado_civil,  
        ISNULL(curp, '') AS curp,  
        ISNULL(rfc, '') AS rfc,  
        ISNULL(seguro, '') AS seguro,  
        ISNULL(nss, '') AS nss,  
        ISNULL(licencia, '') AS licencia,  
        ISNULL(clase, '') AS clase,  
        ISNULL(no_licencia, '') AS no_licencia,  
        ISNULL(vigencia, '') AS vigencia,  
        ISNULL(afore, '') AS afore,  
        ISNULL(discapacidad, '') AS discapacidad,  
        ISNULL(descripcion_discap, '') AS descripcion_discap,  
        ISNULL(estado_salud, '') AS estado_salud,  
        ISNULL(nivel_estudios, '') AS nivel_estudios,  
        ISNULL(carrera, '') AS carrera,  
        ISNULL(titulacion, '') AS titulacion,  
        ISNULL(cedula, '') AS cedula,  
        ISNULL(nombre_contacto, '') AS nombre_contacto,  
        ISNULL(parentesco_contacto, '') AS parentesco_contacto,  
        ISNULL(celular_contacto, '') AS celular_contacto,  
        ISNULL(domicilio_contacto, '') AS domicilio_contacto,  
        ISNULL(cp_contacto, '') AS cp_contacto,  
        ISNULL(nombre_contacto2, '') AS nombre_contacto2,  
        ISNULL(parentesco_contacto2, '') AS parentesco_contacto2,  
        ISNULL(celular_contacto2, '') AS celular_contacto2,  
        ISNULL(domicilio_contacto2, '') AS domicilio_contacto2,  
        ISNULL(cp_contacto2, '') AS cp_contacto2,  
        ISNULL(nombre_contacto3, '') AS nombre_contacto3,  
        ISNULL(parentesco_contacto3, '') AS parentesco_contacto3,  
        ISNULL(celular_contacto3, '') AS celular_contacto3,  
        ISNULL(domicilio_contacto3, '') AS domicilio_contacto3,  
        ISNULL(cp_contacto3, '') AS cp_contacto3,  
        ISNULL(id_puesto, 0) AS id_puesto,  
        ISNULL(id_departamento, 0) AS id_departamento,  
        ISNULL(id_ubicacion, 0) AS id_ubicacion,  
        ISNULL(id_empresa, 0) AS id_empresa,  
        ISNULL(horario_entrada, '') AS horario_entrada,  
        ISNULL(horario_salida, '') AS horario_salida,  
        ISNULL(tipo_pago, '') AS tipo_pago,  
        ISNULL(tipo_periodo, '') AS tipo_periodo,  
        ISNULL(sueldo_neto, '') AS sueldo_neto,  
        ISNULL(salario, '') AS salario,  
        ISNULL(tipo_contrato, '') AS tipo_contrato,  
        ISNULL(asignacion_equipo, '') AS asignacion_equipo,  
        ISNULL(asignacion_vehiculo, '') AS asignacion_vehiculo,  
        ISNULL(id_usuario, 0) AS id_usuario,  
        ISNULL(vacaciones, 0) AS vacaciones,  
        ISNULL(firma_digital, '') AS firma_digital,  
        ISNULL(img_contrato, '') AS img_contrato,  
        CASE   
            WHEN CHARINDEX('\', img_empleado) > 0   
            THEN RIGHT(img_empleado, CHARINDEX('\', REVERSE(img_empleado)) - 1)  
            ELSE ISNULL(img_empleado, '')   
        END AS Img_empleado_nombre  
    FROM EMPLEADO  
    WHERE id_empleado = @IdEmpleado;  
END  