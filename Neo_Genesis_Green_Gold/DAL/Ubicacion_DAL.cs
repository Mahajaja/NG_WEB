using System;
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
    }
}
