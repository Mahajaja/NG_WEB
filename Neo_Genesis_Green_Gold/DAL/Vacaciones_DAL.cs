using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Vacaciones_DAL
    {
        private SqlHelper sqlHelper;

        public Vacaciones_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para insertar una nueva vacación
        public int InsertVacacion(Vacaciones_E vacacion)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_InsertarVacaciones";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                sqlHelper.Command.Parameters.AddWithValue("@fecha_registro", vacacion.fecha_registro);
                sqlHelper.Command.Parameters.AddWithValue("@hora_registro", vacacion.hora_registro);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", vacacion.id_usuario);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return Convert.ToInt32(reader["ID_Vacacion"]); // Asegúrate de que el alias coincida con el SP
                    }
                    else
                    {
                        throw new Exception("No se pudo obtener el ID de la vacación.");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar la vacación: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }



        public Vacaciones_E GetVacacionById(int idVacacion)
        {
            Vacaciones_E vacacion = null;
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "SP_GetVacacionById";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@IdVacacion", idVacacion);

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        vacacion = new Vacaciones_E
                        {
                            id_vacacion = reader["id_vacacion"] != DBNull.Value ? Convert.ToInt32(reader["id_vacacion"]) : 0,
                            folio_registro = reader["folio_registro"] != DBNull.Value ? reader["folio_registro"].ToString() : null,
                            fecha_registro = reader["fecha_registro"] != DBNull.Value ? reader["fecha_registro"].ToString() : null,
                            hora_registro = reader["hora_registro"] != DBNull.Value ? reader["hora_registro"].ToString() : null,
                            id_ubicacion = reader["id_ubicacion"] != DBNull.Value ? Convert.ToInt32(reader["id_ubicacion"]) : (int?)null,
                            id_empleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : (int?)null,
                            fecha_inicio = reader["fecha_inicio"] != DBNull.Value ? reader["fecha_inicio"].ToString() : null,
                            fecha_fin = reader["fecha_fin"] != DBNull.Value ? reader["fecha_fin"].ToString() : null,
                            dias_vacacion = reader["dias_vacacion"] != DBNull.Value ? Convert.ToInt32(reader["dias_vacacion"]) : (int?)null,
                            fecha_incorporacion = reader["fecha_incorporacion"] != DBNull.Value ? reader["fecha_incorporacion"].ToString() : null,
                            dias_restantes = reader["dias_restantes"] != DBNull.Value ? Convert.ToInt32(reader["dias_restantes"]) : (int?)null,
                            observaciones = reader["observaciones"] != DBNull.Value ? reader["observaciones"].ToString() : null,
                            id_usuario = reader["id_usuario"] != DBNull.Value ? Convert.ToInt32(reader["id_usuario"]) : 0,
                            ID_Estatus = reader["ID_Estatus"] != DBNull.Value ? Convert.ToInt32(reader["ID_Estatus"]) : (int?)null
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la vacación: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cerrar la conexión
            }

            return vacacion;
        }


        // Método para obtener todas las vacaciones
        public List<Vacaciones_E> GetAllVacaciones()
        {
            List<Vacaciones_E> vacaciones = new List<Vacaciones_E>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "SP_GetAllVacaciones";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Vacaciones_E vacacion = new Vacaciones_E
                        {
                            id_vacacion = Convert.ToInt32(reader["IdVacacion"]),
                            folio_registro = reader["FolioRegistro"].ToString(),
                            fecha_registro = reader["FechaRegistro"].ToString(),
                            hora_registro = reader["HoraRegistro"].ToString(),
                            id_ubicacion = Convert.ToInt32(reader["IdUbicacion"]),
                            id_empleado = Convert.ToInt32(reader["IdEmpleado"]),
                            fecha_inicio = reader["FechaInicio"].ToString(),
                            fecha_fin = reader["FechaFin"].ToString(),
                            dias_vacacion = Convert.ToInt32(reader["DiasVacacion"]),
                            fecha_incorporacion = reader["FechaIncorporacion"].ToString(),
                            dias_restantes = Convert.ToInt32(reader["DiasRestantes"]),
                            observaciones = reader["Observaciones"].ToString(),
                            id_usuario = Convert.ToInt32(reader["IdUsuario"])
                        };
                        vacaciones.Add(vacacion);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la lista de vacaciones: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cerrar la conexión
            }

            return vacaciones;
        }

        public int UpdateVacacion(Vacaciones_E vacacion)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "sp_ActualizarVacaciones";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añadir los parámetros al Stored Procedure
                sqlHelper.Command.Parameters.AddWithValue("@id_vacacion", vacacion.id_vacacion);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_registro", vacacion.fecha_registro);
                sqlHelper.Command.Parameters.AddWithValue("@hora_registro", vacacion.hora_registro);
                sqlHelper.Command.Parameters.AddWithValue("@id_ubicacion", vacacion.id_ubicacion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", vacacion.id_empleado ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_inicio", vacacion.fecha_inicio ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_fin", vacacion.fecha_fin ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@dias_vacacion", vacacion.dias_vacacion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_incorporacion", vacacion.fecha_incorporacion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@dias_restantes", vacacion.dias_restantes ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@observaciones", vacacion.observaciones ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", vacacion.id_usuario);

                // Ejecuta el comando
                return sqlHelper.Command.ExecuteNonQuery(); // Devuelve el número de filas afectadas
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar la vacación: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }
        }


        // Método para eliminar una vacación
        public int DeleteVacacion(int idVacacion)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "SP_DeleteVacacion";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@IdVacacion", idVacacion);

                // Ejecuta el comando
                return sqlHelper.Command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar la vacación: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cerrar la conexión
            }
        }

        // Método para obtener todas las vacaciones con formato de fecha (dd/MM/yyyy)
        public List<SolicitudesVacacionesViewModel> GetVacacionesConFormato()
        {
            List<SolicitudesVacacionesViewModel> vacaciones = new List<SolicitudesVacacionesViewModel>();

            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_GetVacacionesConFormato";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        SolicitudesVacacionesViewModel vacacion = new SolicitudesVacacionesViewModel
                        {
                            id_vacacion = Convert.ToInt32(reader["id_vacacion"]),
                            Nombre = reader["nombre"].ToString(),  // Asume que tienes esta propiedad en Vacaciones_E
                            FechaInicio = reader["fecha_inicio"].ToString(),
                            FechaIncorporacion = reader["fecha_incorporacion"].ToString(),
                            DiasSolicitados = Convert.ToInt32(reader["dias_vacacion"]),
                            Estatus = reader["Estatus"].ToString(),  // Asume que tienes esta propiedad en Vacaciones_E
                            Observaciones = reader["observaciones"].ToString()  // Asume que tienes esta propiedad en Vacaciones_E
                        };
                        vacaciones.Add(vacacion);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener las vacaciones con formato: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cerrar la conexión
            }

            return vacaciones;
        }

    }
}
