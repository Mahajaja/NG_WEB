using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Ubicacion_DAL
    {
        private SqlHelper sqlHelper;

        public Ubicacion_DAL()
        {
            sqlHelper = new SqlHelper();  // Inicializa tu SqlHelper que maneja la conexión y el comando
        }

        // Método para obtener toda la información de una ubicación a partir del id_ubicacion
        public Ubicacion_E GetUbicacionById(int idUbicacion)
        {
            Ubicacion_E ubicacion = null;
            try
            {
                sqlHelper.OpenConnection();  // Abre la conexión a la base de datos

                // Configura el comando para ejecutar la consulta
                sqlHelper.Command.CommandText = "SELECT * FROM Ubicacion WHERE id_ubicacion = @IdUbicacion";
                sqlHelper.Command.CommandType = CommandType.Text;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@IdUbicacion", idUbicacion);

                // Ejecuta la consulta y lee los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Mapea los datos del lector al objeto Ubicacion_E
                        ubicacion = new Ubicacion_E
                        {
                            IdUbicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            FolioRegistro = reader["folio_registro"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            Nombre = reader["nombre"].ToString(),
                            Lugar = reader["lugar"].ToString(),
                            CoordenadaX = reader["coordenada_x"].ToString(),
                            Direccion = reader["direccion"].ToString(),
                            CP = reader["cp"].ToString(),
                            ImgUbicacion = reader["img_ubicacion"].ToString(),
                            CoordenadaY = reader["coordenada_y"].ToString(),
                            //IdUsuario = Convert.ToInt32(reader["id_usuario"])
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la ubicación: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();  // Asegúrate de cerrar la conexión a la base de datos
            }

            return ubicacion;
        }

        // Método para obtener todas las ubicaciones consumiendo el SP_Obtener_Ubicaciones
        public List<Ubicacion_E> GetAllUbicaciones(int idEmpleado)
        {
            List<Ubicacion_E> ubicaciones = new List<Ubicacion_E>();

            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_Obtener_Ubicaciones";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear(); // Limpia los parámetros en caso de residuos

                // Agrega el parámetro requerido por el procedimiento almacenado
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", idEmpleado);

                // Ejecuta el procedimiento almacenado y lee los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        // Mapea los datos del lector al objeto Ubicacion_E
                        Ubicacion_E ubicacion = new Ubicacion_E
                        {
                            IdUbicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            FolioRegistro = reader["folio_registro"]?.ToString(),
                            HoraRegistro = reader["hora_registro"]?.ToString(),
                            FechaRegistro = reader["fecha_registro"]?.ToString(),
                            Nombre = reader["nombre"]?.ToString(),
                            Lugar = reader["lugar"]?.ToString(),
                            CoordenadaX = reader["coordenada_x"]?.ToString(),
                            CoordenadaY = reader["coordenada_y"]?.ToString(),
                            Direccion = reader["direccion"]?.ToString(),
                            CP = reader["cp"]?.ToString(),
                            ImgUbicacion = reader["img_ubicacion"]?.ToString(),
                            //IdUsuario = reader["id_usuario"] != DBNull.Value ? Convert.ToInt32(reader["id_usuario"]) : (int?)null
                        };

                        ubicaciones.Add(ubicacion); // Añade la ubicación a la lista
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener las ubicaciones: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Asegúrate de cerrar la conexión a la base de datos
            }

            return ubicaciones; // Devuelve la lista de ubicaciones
        }



    }
}
