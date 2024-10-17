using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Incidencia_DAL
    {
        private SqlHelper sqlHelper;

        public Incidencia_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para obtener todas las incidencias
        public List<Incidencia_E> GetAllIncidencias()
        {
            List<Incidencia_E> incidencias = new List<Incidencia_E>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ObtenerIncidencias";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Incidencia_E incidencia = new Incidencia_E
                        {
                            id_incidencia = Convert.ToInt32(reader["id_incidencia"]),
                            folio_incidencia = reader["folio_incidencia"].ToString(),
                            hora_registro = reader["hora_registro"].ToString(),
                            fecha_registro = reader["fecha_registro"].ToString(),
                            id_ubicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            id_empleado = Convert.ToInt32(reader["id_empleado"]),
                            tipo_registro = reader["tipo_registro"].ToString(),
                            tipo_incidencia = reader["tipo_incidencia"].ToString(),
                            tiempo_sancion = reader["tiempo_sancion"].ToString(),
                            descuento_dia = reader["descuento_dia"].ToString(),
                            dia = reader["dia"].ToString(),
                            fecha_inicio = reader["fecha_inicio"].ToString(),
                            descripcion = reader["descripcion"].ToString(),
                            goze = reader["goze"].ToString(),
                            horas = reader["horas"].ToString(),
                            id_usuario = Convert.ToInt32(reader["id_usuario"]),
                            empleado = new Empleados_E
                            {
                                IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                                Nombre = reader["Nombre"].ToString(),
                                ApellidoPaterno = reader["apellido_paterno"].ToString(),
                                ApellidoMaterno = reader["apellido_materno"].ToString(),
                                FechaNacimiento = reader["fecha_nacimiento"].ToString()
                            }
                        };
                        incidencias.Add(incidencia);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener las incidencias: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cerrar la conexión
            }

            return incidencias;
        }
    }
}
