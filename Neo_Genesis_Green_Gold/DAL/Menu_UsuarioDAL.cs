using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Menu_UsuarioDAL
    {
        private SqlHelper sqlHelper;

        public Menu_UsuarioDAL()
        {
            sqlHelper = new SqlHelper();
        }

        public List<string> GetMenusByUserID(string userId)
        {
            List<string> list = new List<string>();
            try
            {
                sqlHelper.OpenConnection();
                sqlHelper.Command.CommandText = "sp_GetMenusByUserID";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@ID_Usuario", userId);
                using (SqlDataReader sqlDataReader = sqlHelper.Command.ExecuteReader())
                {
                    while (sqlDataReader.Read())
                    {
                        list.Add(sqlDataReader["Nombre_Menu"].ToString());
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

            return list;
        }

        public List<MenuE> GetSubMenusByParentID(int? idPadre)
        {
            List<MenuE> list = new List<MenuE>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Prepara el comando para ejecutar el Stored Procedure
                sqlHelper.Command.CommandText = "sp_GetSubMenusByParentID";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@ID_PadreMenu", idPadre.HasValue ? (object)idPadre.Value : DBNull.Value);

                // Ejecuta el Stored Procedure y lee los resultados
                using (SqlDataReader sqlDataReader = sqlHelper.Command.ExecuteReader())
                {
                    while (sqlDataReader.Read())
                    {
                        // Mapear los datos del reader al objeto MenuE
                        MenuE menu = new MenuE
                        {
                            ID_Menu = Convert.ToInt32(sqlDataReader["ID_Menu"]),
                            Nombre_Menu = sqlDataReader["Nombre_Menu"].ToString(),
                            ID_PadreMenu = sqlDataReader["ID_PadreMenu"] == DBNull.Value ? (int?)null : Convert.ToInt32(sqlDataReader["ID_PadreMenu"]),
                            Fecha_Inserto = Convert.ToDateTime(sqlDataReader["Fecha_Inserto"]),
                            Controlador = sqlDataReader["Controlador"] == DBNull.Value ? null : sqlDataReader["Controlador"].ToString(),
                            Accion = sqlDataReader["Accion"] == DBNull.Value ? null : sqlDataReader["Accion"].ToString(),
                            Icono = sqlDataReader["Icono"] == DBNull.Value ? null : sqlDataReader["Icono"].ToString() // Cargar el icono
                        };
                        list.Add(menu);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los submenús: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Asegúrate de cerrar la conexión
            }

            return list;
        }


        public List<MenuE> GetMenusAndSubMenusBy_UserID(string userId)
        {
            List<MenuE> menus = new List<MenuE>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el Stored Procedure
                sqlHelper.Command.CommandText = "sp_GetMenusAndSubMenusByUserID"; // Nombre del Stored Procedure
                sqlHelper.Command.CommandType = CommandType.StoredProcedure; // Establecer el tipo de comando a Stored Procedure
                sqlHelper.Command.Parameters.Clear(); // Limpiar parámetros anteriores
                sqlHelper.Command.Parameters.AddWithValue("@ID_Usuario", userId); // Agregar parámetro

                // Ejecutar el Stored Procedure y leer los resultados
                using (SqlDataReader sqlDataReader = sqlHelper.Command.ExecuteReader())
                {
                    while (sqlDataReader.Read())
                    {
                        // Mapear los datos del reader al objeto MenuE
                        MenuE menu = new MenuE
                        {
                            ID_Menu = Convert.ToInt32(sqlDataReader["ID_Menu"]),
                            Nombre_Menu = sqlDataReader["Nombre_Menu"].ToString(),
                            ID_PadreMenu = sqlDataReader["ID_PadreMenu"] == DBNull.Value ? (int?)null : Convert.ToInt32(sqlDataReader["ID_PadreMenu"]),
                            Fecha_Inserto = Convert.ToDateTime(sqlDataReader["Fecha_Inserto"]),
                            Icono = sqlDataReader["Icono"] == DBNull.Value ? null : sqlDataReader["Icono"].ToString() // Cargar el icono
                        };
                        menus.Add(menu);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener menús y submenús por usuario: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cerrar la conexión
            }

            return menus;
        }


    }
}
