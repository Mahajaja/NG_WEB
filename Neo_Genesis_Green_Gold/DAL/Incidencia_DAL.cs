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
                            Estatus = reader["Estatus"].ToString(),
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

        // Método para insertar una nueva incidencia que retorna true o false
        public bool InsertarIncidencia(Incidencia_E incidencia)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_Insertar_Incidencia";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añadir los parámetros necesarios al stored procedure
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", incidencia.id_empleado);
                sqlHelper.Command.Parameters.AddWithValue("@tipo_registro", incidencia.tipo_registro);
                sqlHelper.Command.Parameters.AddWithValue("@tipo_incidencia", incidencia.tipo_incidencia);
                sqlHelper.Command.Parameters.AddWithValue("@tiempo_sancion", incidencia.tiempo_sancion);
                sqlHelper.Command.Parameters.AddWithValue("@descuento_dia", incidencia.descuento_dia);
                sqlHelper.Command.Parameters.AddWithValue("@dia", incidencia.dia);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_inicio", incidencia.fecha_inicio);
                sqlHelper.Command.Parameters.AddWithValue("@descripcion", incidencia.descripcion);
                sqlHelper.Command.Parameters.AddWithValue("@goze", incidencia.goze);
                sqlHelper.Command.Parameters.AddWithValue("@horas", incidencia.horas);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", incidencia.id_usuario);

                // Ejecutar el comando
                int rowsAffected = sqlHelper.Command.ExecuteNonQuery();

                // Retornar true si se insertó al menos una fila
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar la incidencia: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }
        }

    }
}
