using System;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class DiasInhabiles_DAL
    {
        private SqlHelper sqlHelper;

        public DiasInhabiles_DAL()
        {
            sqlHelper = new SqlHelper();  // Asegúrate de que tu SqlHelper esté configurado correctamente
        }

        // Método para verificar si una fecha es un día inhábil
        public bool CheckDiaInhabil(DateTime fecha)
        {
            bool existe = false;
            try
            {
                sqlHelper.OpenConnection();  // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el Stored Procedure
                sqlHelper.Command.CommandText = "SP_CheckDiaInhabil";  // Nombre del SP
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@Fecha", fecha);

                // Ejecutar el Stored Procedure y obtener el resultado
                object result = sqlHelper.Command.ExecuteScalar();

                if (result != null && result != DBNull.Value)
                {
                    existe = Convert.ToBoolean(result);  // Convertir el resultado a booleano
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al verificar si la fecha es día inhábil: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();  // Asegúrate de cerrar la conexión
            }

            return existe;
        }

        public bool CheckDiaInhabilEnRango(DateTime fechaInicio, DateTime fechaFin)
        {
            bool existe = false;
            try
            {
                sqlHelper.OpenConnection();  // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el Stored Procedure
                sqlHelper.Command.CommandText = "SP_CheckDiaInhabil_Rango";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@FechaInicio", fechaInicio);
                sqlHelper.Command.Parameters.AddWithValue("@FechaFin", fechaFin);

                // Ejecutar el Stored Procedure y obtener el resultado
                object result = sqlHelper.Command.ExecuteScalar();

                if (result != null && result != DBNull.Value)
                {
                    existe = Convert.ToBoolean(result);  // Convertir el resultado a booleano
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al verificar si hay días inhábiles en el rango: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();  // Asegúrate de cerrar la conexión
            }

            return existe;
        }

        public int GetNumeroDiasInhabilesEnRango_weekend(DateTime fechaInicio, DateTime fechaFin)
        {
            int diasInhabiles = 0;
            try
            {
                sqlHelper.OpenConnection();  // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el Stored Procedure
                sqlHelper.Command.CommandText = "SP_CheckDiaInhabil_Rango_Weekend";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@FechaInicio", fechaInicio);
                sqlHelper.Command.Parameters.AddWithValue("@FechaFin", fechaFin);

                // Ejecutar el Stored Procedure y obtener el resultado
                object result = sqlHelper.Command.ExecuteScalar();

                if (result != null && result != DBNull.Value)
                {
                    diasInhabiles = Convert.ToInt32(result);  // Convertir el resultado a entero
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el número de días inhábiles en el rango: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();  // Asegúrate de cerrar la conexión
            }

            return diasInhabiles;
        }


    }
}
