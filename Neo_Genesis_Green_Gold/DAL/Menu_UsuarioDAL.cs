using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{
    public class Menu_UsuarioDAL
    {
        private SqlHelper sqlHelper;

        public Menu_UsuarioDAL()
        {
            // Usamos la clase SqlHelper para inicializar la conexión y el comando
            sqlHelper = new SqlHelper();
        }

        // Método para obtener los menús por ID de usuario
        public List<string> GetMenusByUserID(string userId)
        {
            List<string> menus = new List<string>();

            try
            {
                // Abrimos la conexión
                sqlHelper.OpenConnection();

                // Configuramos el comando para ejecutar el Stored Procedure
                sqlHelper.Command.CommandText = "sp_GetMenusByUserID";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@ID_Usuario", userId);

                // Ejecutamos el procedimiento almacenado y leemos los resultados
                using (SqlDataReader dr = sqlHelper.Command.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        menus.Add(dr["Nombre_Menu"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los menús por usuario: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return menus;
        }
    }
}
