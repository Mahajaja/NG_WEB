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
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "SP_InsertVacacion";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añadir los parámetros al Stored Procedure
                sqlHelper.Command.Parameters.AddWithValue("@FolioRegistro", vacacion.FolioRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@FechaRegistro", vacacion.FechaRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@HoraRegistro", vacacion.HoraRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@IdEmpleado", vacacion.IdEmpleado);
                sqlHelper.Command.Parameters.AddWithValue("@FechaInicio", vacacion.FechaInicio);
                sqlHelper.Command.Parameters.AddWithValue("@FechaFin", vacacion.FechaFin);
                sqlHelper.Command.Parameters.AddWithValue("@DiasVacacion", vacacion.DiasVacacion);
                sqlHelper.Command.Parameters.AddWithValue("@FechaIncorporacion", vacacion.FechaIncorporacion);
                sqlHelper.Command.Parameters.AddWithValue("@DiasRestantes", vacacion.DiasRestantes);
                sqlHelper.Command.Parameters.AddWithValue("@Observaciones", vacacion.Observaciones);
                sqlHelper.Command.Parameters.AddWithValue("@IdUsuario", vacacion.IdUsuario);

                // Ejecuta el comando
                return sqlHelper.Command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar la vacación: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Asegúrate de cerrar la conexión
            }
        }

        // Método para obtener una vacación por su ID
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
                            IdVacacion = Convert.ToInt32(reader["IdVacacion"]),
                            FolioRegistro = reader["FolioRegistro"].ToString(),
                            FechaRegistro = reader["FechaRegistro"].ToString(),
                            HoraRegistro = reader["HoraRegistro"].ToString(),
                            IdUbicacion = Convert.ToInt32(reader["IdUbicacion"]),
                            IdEmpleado = Convert.ToInt32(reader["IdEmpleado"]),
                            FechaInicio = reader["FechaInicio"].ToString(),
                            FechaFin = reader["FechaFin"].ToString(),
                            DiasVacacion = Convert.ToInt32(reader["DiasVacacion"]),
                            FechaIncorporacion = reader["FechaIncorporacion"].ToString(),
                            DiasRestantes = Convert.ToInt32(reader["DiasRestantes"]),
                            Observaciones = reader["Observaciones"].ToString(),
                            IdUsuario = Convert.ToInt32(reader["IdUsuario"])
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
                            IdVacacion = Convert.ToInt32(reader["IdVacacion"]),
                            FolioRegistro = reader["FolioRegistro"].ToString(),
                            FechaRegistro = reader["FechaRegistro"].ToString(),
                            HoraRegistro = reader["HoraRegistro"].ToString(),
                            IdUbicacion = Convert.ToInt32(reader["IdUbicacion"]),
                            IdEmpleado = Convert.ToInt32(reader["IdEmpleado"]),
                            FechaInicio = reader["FechaInicio"].ToString(),
                            FechaFin = reader["FechaFin"].ToString(),
                            DiasVacacion = Convert.ToInt32(reader["DiasVacacion"]),
                            FechaIncorporacion = reader["FechaIncorporacion"].ToString(),
                            DiasRestantes = Convert.ToInt32(reader["DiasRestantes"]),
                            Observaciones = reader["Observaciones"].ToString(),
                            IdUsuario = Convert.ToInt32(reader["IdUsuario"])
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

        // Método para actualizar una vacación
        public int UpdateVacacion(Vacaciones_E vacacion)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "SP_UpdateVacacion";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añadir los parámetros al Stored Procedure
                sqlHelper.Command.Parameters.AddWithValue("@IdVacacion", vacacion.IdVacacion);
                sqlHelper.Command.Parameters.AddWithValue("@FolioRegistro", vacacion.FolioRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@FechaRegistro", vacacion.FechaRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@HoraRegistro", vacacion.HoraRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@IdUbicacion", vacacion.IdUbicacion);
                sqlHelper.Command.Parameters.AddWithValue("@IdEmpleado", vacacion.IdEmpleado);
                sqlHelper.Command.Parameters.AddWithValue("@FechaInicio", vacacion.FechaInicio);
                sqlHelper.Command.Parameters.AddWithValue("@FechaFin", vacacion.FechaFin);
                sqlHelper.Command.Parameters.AddWithValue("@DiasVacacion", vacacion.DiasVacacion);
                sqlHelper.Command.Parameters.AddWithValue("@FechaIncorporacion", vacacion.FechaIncorporacion);
                sqlHelper.Command.Parameters.AddWithValue("@DiasRestantes", vacacion.DiasRestantes);
                sqlHelper.Command.Parameters.AddWithValue("@Observaciones", vacacion.Observaciones);
                sqlHelper.Command.Parameters.AddWithValue("@IdUsuario", vacacion.IdUsuario);

                // Ejecuta el comando
                return sqlHelper.Command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar la vacación: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cerrar la conexión
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
                            Estatus = reader["Estatus"].ToString()  // Asume que tienes esta propiedad en Vacaciones_E
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
