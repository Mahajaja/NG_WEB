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
        public List<Incidencia_E> GetAllIncidencias(int idEmpleado)
        {
            List<Incidencia_E> incidencias = new List<Incidencia_E>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ObtenerIncidencias";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar el parámetro @id_empleado
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", idEmpleado);

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Incidencia_E incidencia = new Incidencia_E
                        {
                            id_incidencia = reader["id_incidencia"] != DBNull.Value ? Convert.ToInt32(reader["id_incidencia"]) : 0,
                            folio_incidencia = reader["folio_incidencia"]?.ToString(),
                            hora_registro = reader["hora_registro"]?.ToString(),
                            fecha_registro = reader["fecha_registro"]?.ToString(),
                            id_ubicacion = reader["id_ubicacion"] != DBNull.Value ? Convert.ToInt32(reader["id_ubicacion"]) : (int?)null,
                            id_empleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : (int?)null,
                            tipo_registro = reader["tipo_registro"]?.ToString(),
                            tipo_incidencia = reader["tipo_incidencia"]?.ToString(),
                            tiempo_sancion = reader["tiempo_sancion"]?.ToString(),
                            descuento_dia = reader["descuento_dia"]?.ToString(),
                            dia = reader["dia"]?.ToString(),
                            fecha_inicio = reader["fecha_inicio"]?.ToString(),
                            descripcion = reader["descripcion"]?.ToString(),
                            goze = reader["goze"]?.ToString(),
                            horas = reader["horas"]?.ToString(),
                            Estatus = reader["Estatus"]?.ToString(),
                            id_usuario = reader["id_usuario"] != DBNull.Value ? Convert.ToInt32(reader["id_usuario"]) : (int?)null,
                            empleado = new Empleados_E
                            {
                                IdEmpleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : 0,
                                Nombre = reader["nombre"]?.ToString(),
                                ApellidoPaterno = reader["apellido_paterno"]?.ToString(),
                                ApellidoMaterno = reader["apellido_materno"]?.ToString(),
                                FechaNacimiento = reader["fecha_nacimiento"]?.ToString()
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


        public int InsertIncidencia(Incidencia_E incidencia)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_InsertarIncidencia";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                sqlHelper.Command.Parameters.AddWithValue("@fecha_registro", incidencia.fecha_registro);
                sqlHelper.Command.Parameters.AddWithValue("@hora_registro", incidencia.hora_registro);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", incidencia.id_usuario);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return Convert.ToInt32(reader["ID_Incidencia"]); // Asegúrate de que el alias coincida con el SP
                    }
                    else
                    {
                        throw new Exception("No se pudo obtener el ID de la incidencia.");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar la incidencia: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        public Incidencia_E ObtenerIncidenciaPorId(int idIncidencia)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_ObtenerIncidenciaPorId";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                sqlHelper.Command.Parameters.AddWithValue("@id_incidencia", idIncidencia);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return new Incidencia_E
                        {
                            id_incidencia = Convert.ToInt32(reader["id_incidencia"]),
                            folio_incidencia = reader["folio_incidencia"]?.ToString(),
                            hora_registro = reader["hora_registro"]?.ToString(),
                            fecha_registro = reader["fecha_registro"]?.ToString(),
                            id_ubicacion = reader["id_ubicacion"] != DBNull.Value ? Convert.ToInt32(reader["id_ubicacion"]) : (int?)null,
                            id_empleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : (int?)null,
                            tipo_registro = reader["tipo_registro"]?.ToString(),
                            tipo_incidencia = reader["tipo_incidencia"]?.ToString(),
                            tiempo_sancion = reader["tiempo_sancion"]?.ToString(),
                            descuento_dia = reader["descuento_dia"]?.ToString(),
                            dia = reader["dia"]?.ToString(),
                            fecha_inicio = reader["fecha_inicio"]?.ToString(),
                            descripcion = reader["descripcion"]?.ToString(),
                            goze = reader["goze"]?.ToString(),
                            horas = reader["horas"]?.ToString(),
                            id_usuario = reader["id_usuario"] != DBNull.Value ? Convert.ToInt32(reader["id_usuario"]) : (int?)null,
                            ID_Estatus = reader["ID_Estatus"] != DBNull.Value ? Convert.ToInt32(reader["ID_Estatus"]) : (int?)null
                        };
                    }
                    else
                    {
                        throw new Exception($"No se encontró una incidencia con el ID {idIncidencia}.");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la incidencia: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        public bool ActualizarIncidencia(Incidencia_E incidencia)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Update_Incidencia";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añadir los parámetros al stored procedure
                sqlHelper.Command.Parameters.AddWithValue("@id_incidencia", incidencia.id_incidencia);
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", incidencia.id_empleado);
                sqlHelper.Command.Parameters.AddWithValue("@tipo_registro", incidencia.tipo_registro ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@tipo_incidencia", incidencia.tipo_incidencia ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@tiempo_sancion", incidencia.tiempo_sancion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@descuento_dia", incidencia.descuento_dia ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@dia", incidencia.dia ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_inicio", incidencia.fecha_inicio ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@descripcion", incidencia.descripcion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@goze", incidencia.goze ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@horas", incidencia.horas ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", incidencia.id_usuario);

                // Ejecutar el procedimiento almacenado
                int rowsAffected = sqlHelper.Command.ExecuteNonQuery();

                return rowsAffected > 0; // Retorna true si se actualizó al menos una fila
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar la incidencia: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        public int Delete(int id)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "SP_Delete_INCIDENCIA";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@id", id);

                // Ejecuta el comando
                return sqlHelper.Command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al intentar eliminar el registro: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }
        }

    }
}
