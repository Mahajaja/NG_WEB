using System;
using System.Configuration;
using System.Data.SqlClient;

namespace DAL
{
    public class SqlHelper
    {
        public SqlConnection Connection { get; private set; }
        public SqlCommand Command { get; private set; }

        // Constructor que inicializa la conexión y el comando
        public SqlHelper()
        {
            Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString());
            Command = new SqlCommand
            {
                Connection = Connection
            };
        }

        // Método para abrir la conexión
        public void OpenConnection()
        {
            if (Connection.State == System.Data.ConnectionState.Closed)
            {
                Connection.Open();
            }
        }

        // Método para cerrar la conexión
        public void CloseConnection()
        {
            if (Connection.State == System.Data.ConnectionState.Open)
            {
                Connection.Close();
            }
        }
    }
}
