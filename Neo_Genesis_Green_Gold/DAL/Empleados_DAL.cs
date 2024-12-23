using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Empleados_DAL
    {
        private SqlHelper sqlHelper;

        public Empleados_DAL()
        {
            sqlHelper = new SqlHelper();  // Inicializa tu SqlHelper que maneja la conexión y el comando
        }

        // Método para obtener toda la información de un empleado a partir del id_empleado
        public Empleados_E GetEmpleadoById(int idEmpleado)
        {
            Empleados_E empleado = null;
            try
            {
                sqlHelper.OpenConnection();  // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el stored procedure
                sqlHelper.Command.CommandText = "SP_GetEmpleadoById";  // Nombre del stored procedure
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;  // Indicar que es un stored procedure
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@IdEmpleado", idEmpleado);  // Añadir el parámetro

                // Ejecuta el stored procedure y lee los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Mapea los datos del lector al objeto Empleados_E
                        empleado = new Empleados_E
                        {
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            FolioRegistro = reader["folio_registro"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            Empleado = Convert.ToInt32(reader["empleado"]),
                            FechaIngreso = reader["fecha_ingreso"].ToString(),
                            ApellidoPaterno = reader["apellido_paterno"].ToString(),
                            ApellidoMaterno = reader["apellido_materno"].ToString(),
                            Nombre = reader["nombre"].ToString(),
                            FechaNacimiento = reader["fecha_nacimiento"].ToString(),
                            Genero = reader["genero"].ToString(),
                            Domicilio = reader["domicilio"].ToString(),
                            Colonia = reader["colonia"].ToString(),
                            CP = reader["cp"].ToString(),
                            Municipio = reader["municipio"].ToString(),
                            Peso = reader["peso"].ToString(),
                            Estatura = reader["estatura"].ToString(),
                            LugarNacimiento = reader["lugar_nacimiento"].ToString(),
                            Nacionalidad = reader["nacionalidad"].ToString(),
                            Telefono = reader["telefono"].ToString(),
                            Celular = reader["celular"].ToString(),
                            Correo = reader["correo"].ToString(),
                            EstadoCivil = reader["estado_civil"].ToString(),
                            Curp = reader["curp"].ToString(),
                            RFC = reader["rfc"].ToString(),
                            Seguro = reader["seguro"].ToString(),
                            NSS = reader["nss"].ToString(),
                            Licencia = reader["licencia"].ToString(),
                            Clase = reader["clase"].ToString(),
                            NoLicencia = reader["no_licencia"].ToString(),
                            Vigencia = reader["vigencia"].ToString(),
                            Afore = reader["afore"].ToString(),
                            Discapacidad = reader["discapacidad"].ToString(),
                            DescripcionDiscap = reader["descripcion_discap"].ToString(),
                            EstadoSalud = reader["estado_salud"].ToString(),
                            NivelEstudios = reader["nivel_estudios"].ToString(),
                            Carrera = reader["carrera"].ToString(),
                            Titulacion = reader["titulacion"].ToString(),
                            Cedula = reader["cedula"].ToString(),
                            NombreContacto = reader["nombre_contacto"].ToString(),
                            ParentescoContacto = reader["parentesco_contacto"].ToString(),
                            CelularContacto = reader["celular_contacto"].ToString(),
                            DomicilioContacto = reader["domicilio_contacto"].ToString(),
                            CPContacto = reader["cp_contacto"].ToString(),
                            NombreContacto2 = reader["nombre_contacto2"].ToString(),
                            ParentescoContacto2 = reader["parentesco_contacto2"].ToString(),
                            CelularContacto2 = reader["celular_contacto2"].ToString(),
                            DomicilioContacto2 = reader["domicilio_contacto2"].ToString(),
                            CPContacto2 = reader["cp_contacto2"].ToString(),
                            NombreContacto3 = reader["nombre_contacto3"].ToString(),
                            ParentescoContacto3 = reader["parentesco_contacto3"].ToString(),
                            CelularContacto3 = reader["celular_contacto3"].ToString(),
                            DomicilioContacto3 = reader["domicilio_contacto3"].ToString(),
                            CPContacto3 = reader["cp_contacto3"].ToString(),
                            IdPuesto = Convert.ToInt32(reader["id_puesto"]),
                            IdDepartamento = Convert.ToInt32(reader["id_departamento"]),
                            IdUbicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            IdEmpresa = Convert.ToInt32(reader["id_empresa"]),
                            HorarioEntrada = reader["horario_entrada"].ToString(),
                            HorarioSalida = reader["horario_salida"].ToString(),
                            TipoPago = reader["tipo_pago"].ToString(),
                            TipoPeriodo = reader["tipo_periodo"].ToString(),
                            SueldoNeto = reader["sueldo_neto"].ToString(),
                            Salario = reader["salario"].ToString(),
                            TipoContrato = reader["tipo_contrato"].ToString(),
                            AsignacionEquipo = reader["asignacion_equipo"].ToString(),
                            AsignacionVehiculo = reader["asignacion_vehiculo"].ToString(),
                            Img_empleado_nombre = reader["Img_empleado_nombre"].ToString(),  // Aquí se utiliza Img_empleado_nombre del SP
                            ImgContrato = reader["img_contrato"].ToString(),
                            IdUsuario = Convert.ToInt32(reader["id_usuario"]),
                            Vacaciones = Convert.ToInt32(reader["vacaciones"]),
                            FirmaDigital = reader["firma_digital"].ToString(),
                            Puesto = reader["Puesto"].ToString()
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los datos del empleado: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();  // Asegúrate de cerrar la conexión a la base de datos
            }

            return empleado;
        }


        // Método para obtener la lista de empleados por idUbicacion
        public List<Empleados_E> GetEmpleadosByUbicacion(int idUbicacion)
        {
            List<Empleados_E> empleados = new List<Empleados_E>();
            try
            {
                sqlHelper.OpenConnection();  // Abre la conexión a la base de datos

                // Configura el comando para ejecutar la consulta
                sqlHelper.Command.CommandText = "SELECT E.*, " +
     "CASE WHEN CHARINDEX('\\', img_empleado) > 0 THEN RIGHT(img_empleado, CHARINDEX('\\', REVERSE(img_empleado)) - 1) " +
     "ELSE ISNULL(img_empleado, '') END AS Img_empleado_nombre, " +
     "P.nombre AS Puesto " +
     "FROM EMPLEADO E " +
     "INNER JOIN PUESTO P ON E.id_puesto = P.id_puesto " +
     "WHERE E.id_ubicacion = @IdUbicacion AND E.id_empleado != 25";
                sqlHelper.Command.CommandType = CommandType.Text;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@IdUbicacion", idUbicacion);


                // Ejecuta la consulta y lee los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Empleados_E empleado = new Empleados_E
                        {
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            Nombre = reader["nombre"].ToString(),
                            ApellidoPaterno = reader["apellido_paterno"].ToString(),
                            ApellidoMaterno = reader["apellido_materno"].ToString(),
                            Img_empleado_nombre = reader["Img_empleado_nombre"].ToString(),
                            Puesto = reader["Puesto"].ToString(),
                            // ... mapeo de las demás propiedades que consideres necesarias
                        };

                        empleados.Add(empleado);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la lista de empleados por ubicación: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();  // Asegúrate de cerrar la conexión a la base de datos
            }

            return empleados;
        }

        // Método para obtener empleados específicos con todos los campos especificados
        public List<Empleados_E> ObtenerEmpleadosSolicitudMantenimiento(int idUbicacion)
        {
            List<Empleados_E> empleados = new List<Empleados_E>();

            try
            {
                // Abrir la conexión a la base de datos
                sqlHelper.OpenConnection();

                // Configuración del comando para ejecutar el Stored Procedure
                sqlHelper.Command.CommandText = "sp_obtenerEmpleados_SolicitudMantenimiento";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añadir el parámetro id_ubicacion al comando
                sqlHelper.Command.Parameters.AddWithValue("@id_ubicacion", idUbicacion);

                // Ejecutar el comando y procesar los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        // Crear y llenar un objeto Empleados_E a partir del lector de datos
                        Empleados_E empleado = new Empleados_E
                        {
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            FolioRegistro = reader["folio_registro"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            Empleado = Convert.ToInt32(reader["empleado"]),
                            FechaIngreso = reader["fecha_ingreso"].ToString(),
                            ApellidoPaterno = reader["apellido_paterno"].ToString(),
                            ApellidoMaterno = reader["apellido_materno"].ToString(),
                            Nombre = reader["nombre"].ToString(),
                            FechaNacimiento = reader["fecha_nacimiento"].ToString(),
                            Genero = reader["genero"].ToString(),
                            Domicilio = reader["domicilio"].ToString(),
                            Colonia = reader["colonia"].ToString(),
                            CP = reader["cp"].ToString(),
                            Municipio = reader["municipio"].ToString(),
                            Peso = reader["peso"].ToString(),
                            Estatura = reader["estatura"].ToString(),
                            LugarNacimiento = reader["lugar_nacimiento"].ToString(),
                            Nacionalidad = reader["nacionalidad"].ToString(),
                            Telefono = reader["telefono"].ToString(),
                            Celular = reader["celular"].ToString(),
                            Correo = reader["correo"].ToString(),
                            EstadoCivil = reader["estado_civil"].ToString(),
                            Curp = reader["curp"].ToString(),
                            RFC = reader["rfc"].ToString(),
                            Seguro = reader["seguro"].ToString(),
                            NSS = reader["nss"].ToString(),
                            Licencia = reader["licencia"].ToString(),
                            Clase = reader["clase"].ToString(),
                            NoLicencia = reader["no_licencia"].ToString(),
                            Vigencia = reader["vigencia"].ToString(),
                            Afore = reader["afore"].ToString(),
                            Discapacidad = reader["discapacidad"].ToString(),
                            DescripcionDiscap = reader["descripcion_discap"].ToString(),
                            EstadoSalud = reader["estado_salud"].ToString(),
                            NivelEstudios = reader["nivel_estudios"].ToString(),
                            Carrera = reader["carrera"].ToString(),
                            Titulacion = reader["titulacion"].ToString(),
                            Cedula = reader["cedula"].ToString(),
                            NombreContacto = reader["nombre_contacto"].ToString(),
                            ParentescoContacto = reader["parentesco_contacto"].ToString(),
                            CelularContacto = reader["celular_contacto"].ToString(),
                            DomicilioContacto = reader["domicilio_contacto"].ToString(),
                            CPContacto = reader["cp_contacto"].ToString(),
                            NombreContacto2 = reader["nombre_contacto2"].ToString(),
                            ParentescoContacto2 = reader["parentesco_contacto2"].ToString(),
                            CelularContacto2 = reader["celular_contacto2"].ToString(),
                            DomicilioContacto2 = reader["domicilio_contacto2"].ToString(),
                            CPContacto2 = reader["cp_contacto2"].ToString(),
                            NombreContacto3 = reader["nombre_contacto3"].ToString(),
                            ParentescoContacto3 = reader["parentesco_contacto3"].ToString(),
                            CelularContacto3 = reader["celular_contacto3"].ToString(),
                            DomicilioContacto3 = reader["domicilio_contacto3"].ToString(),
                            CPContacto3 = reader["cp_contacto3"].ToString(),
                            IdPuesto = Convert.ToInt32(reader["id_puesto"]),
                            IdDepartamento = Convert.ToInt32(reader["id_departamento"]),
                            IdUbicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            IdEmpresa = Convert.ToInt32(reader["id_empresa"]),
                            HorarioEntrada = reader["horario_entrada"].ToString(),
                            HorarioSalida = reader["horario_salida"].ToString(),
                            TipoPago = reader["tipo_pago"].ToString(),
                            TipoPeriodo = reader["tipo_periodo"].ToString(),
                            SueldoNeto = reader["sueldo_neto"].ToString(),
                            Salario = reader["salario"].ToString(),
                            TipoContrato = reader["tipo_contrato"].ToString(),
                            AsignacionEquipo = reader["asignacion_equipo"].ToString(),
                            AsignacionVehiculo = reader["asignacion_vehiculo"].ToString(),
                            ImgContrato = reader["img_contrato"].ToString(),
                            IdUsuario = Convert.ToInt32(reader["id_usuario"]),
                            Vacaciones = Convert.ToInt32(reader["vacaciones"]),
                            FirmaDigital = reader["firma_digital"].ToString()
                        };

                        // Agregar el empleado a la lista
                        empleados.Add(empleado);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los empleados: " + ex.Message);
            }
            finally
            {
                // Cerrar la conexión
                sqlHelper.CloseConnection();
            }

            return empleados;
        }


        public List<Empleados_E> GetEmpleadosByDepartamento()
        {
            List<Empleados_E> empleados = new List<Empleados_E>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el stored procedure
                sqlHelper.Command.CommandText = "SP_ObtenerEmpleadosPorDepartamento";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Ejecuta el stored procedure y lee los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        // Mapea los datos del lector al objeto Empleados_E
                        Empleados_E empleado = new Empleados_E
                        {
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            Nombre = reader["nombre"].ToString(),
                            ApellidoPaterno = reader["apellido_paterno"].ToString(),
                            ApellidoMaterno = reader["apellido_materno"].ToString(),
                        };

                        empleados.Add(empleado); // Agrega el empleado a la lista
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los empleados por departamento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Asegúrate de cerrar la conexión a la base de datos
            }

            return empleados;
        }

        public List<Empleados_E> ObtenerEmpleadosPorUbicacion(int idUbicacion)
        {
            List<Empleados_E> empleados = new List<Empleados_E>();

            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_obtenerEmpleados_SolicitudMantenimiento_ubicacion";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@id_ubicacion", idUbicacion);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Empleados_E empleado = new Empleados_E
                        {
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            FolioRegistro = reader["folio_registro"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            FechaIngreso = reader["fecha_ingreso"].ToString(),
                            ApellidoPaterno = reader["apellido_paterno"].ToString(),
                            ApellidoMaterno = reader["apellido_materno"].ToString(),
                            Nombre = reader["nombre"].ToString(),
                            FechaNacimiento = reader["fecha_nacimiento"].ToString(),
                            Genero = reader["genero"].ToString()
                        };

                        empleados.Add(empleado);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener empleados: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return empleados;
        }

        public List<Empleados_E> ObtenerTodosLosEmpleados()
        {
            List<Empleados_E> empleados = new List<Empleados_E>();

            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Select_Empleados";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Empleados_E empleado = new Empleados_E
                        {
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            Nombre = reader["nombre"].ToString(),
                            ApellidoPaterno = reader["apellido_paterno"].ToString(),
                            ApellidoMaterno = reader["apellido_materno"].ToString(),
                            Puesto = reader["descripcion"].ToString()
                        };

                        empleados.Add(empleado);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la lista de empleados: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return empleados;
        }

        public List<Empleados_E> ObtenerMisEmpleadosPorUbicacion(int idEmpleado)
        {
            List<Empleados_E> empleados = new List<Empleados_E>();

            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el stored procedure
                sqlHelper.Command.CommandText = "SP_ObtenerMisEmpleadosPorUbicacion";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", idEmpleado); // Añade el parámetro del empleado

                // Ejecuta el stored procedure y lee los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        // Mapea los datos del lector al objeto Empleados_E
                        Empleados_E empleado = new Empleados_E
                        {
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            Nombre = reader["nombre"].ToString(),
                            ApellidoPaterno = reader["apellido_paterno"].ToString(),
                            ApellidoMaterno = reader["apellido_materno"].ToString(),
                            Img_empleado_nombre = reader["Img_empleado_nombre"].ToString(),
                            Puesto = reader["Puesto"].ToString(),
                            // Incluye otros campos si es necesario
                        };

                        empleados.Add(empleado); // Agrega el empleado a la lista
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los empleados por ubicaciones: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Asegúrate de cerrar la conexión a la base de datos
            }

            return empleados;
        }


    }
}
