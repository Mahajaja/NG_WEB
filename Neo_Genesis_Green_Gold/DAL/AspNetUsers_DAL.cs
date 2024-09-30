using System;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class AspNetUsers_DAL
    {
        private SqlHelper sqlHelper;

        public AspNetUsers_DAL()
        {
            sqlHelper = new SqlHelper();  // Inicializa tu SqlHelper que maneja la conexión y el comando
        }

        // Método para obtener el id_empleado a partir del id del usuario (string id)
        public int GetIdEmpleadoByUserId(string id)
        {
            try
            {
                sqlHelper.OpenConnection();  // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el procedimiento almacenado o consulta
                sqlHelper.Command.CommandText = "SELECT id_empleado FROM AspNetUsers WHERE Id = @Id";
                sqlHelper.Command.CommandType = CommandType.Text;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@Id", id);

                // Ejecuta el comando y obtiene el resultado
                object result = sqlHelper.Command.ExecuteScalar();

                // Verifica si el resultado es nulo
                if (result != null && result != DBNull.Value)
                {
                    return Convert.ToInt32(result);  // Retorna el id_empleado como int
                }
                else
                {
                    return 0;  // Si no hay resultado, retorna null
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el id_empleado: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();  // Asegúrate de cerrar la conexión a la base de datos
            }
        }
    }
}
