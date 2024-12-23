using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Usuarios_DAL
    {
        private SqlHelper sqlHelper;

        public Usuarios_DAL()
        {
            sqlHelper = new SqlHelper(); // Inicializa tu SqlHelper que maneja la conexión y el comando
        }

        // Método para obtener todos los usuarios
        public List<Usuario_E> GetUsuarios()
        {
            List<Usuario_E> usuarios = new List<Usuario_E>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el stored procedure
                sqlHelper.Command.CommandText = "SP_Obtener_Usuarios"; // Nombre del stored procedure
                sqlHelper.Command.CommandType = CommandType.StoredProcedure; // Indica que es un stored procedure
                sqlHelper.Command.Parameters.Clear(); // Limpia los parámetros del comando

                // Ejecuta el stored procedure y lee los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        // Mapea los datos del lector al objeto Usuario_E
                        Usuario_E usuario = new Usuario_E
                        {
                            Id_Usuario = Convert.ToInt32(reader["id_usuario"]),
                            Id_Empleado = Convert.ToInt32(reader["id_empleado"]),
                            Nom_Usuario = reader["nom_usuario"].ToString(),
                            Permiso = reader["permiso"].ToString(),
                            Contraseña = reader["contraseña"].ToString(),
                            Fecha_Registro = reader["fecha_registro"].ToString(),
                            Hora_Registro = reader["hora_registro"].ToString(),
                            Nom_Usuario_Web = reader["Nom_Usuario_Web"].ToString(),
                            ExistsInAspNetUsers = Convert.ToBoolean(reader["ExistsInAspNetUsers"]) // Nuevo campo mapeado
                        };

                        usuarios.Add(usuario);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la lista de usuarios: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Asegúrate de cerrar la conexión a la base de datos
            }

            return usuarios;
        }

        public Usuario_E GetUsuarioById(int idUsuario)
        {
            Usuario_E usuario = null;
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el stored procedure
                sqlHelper.Command.CommandText = "SP_Obtener_Usuario_PorId"; // Nombre del stored procedure
                sqlHelper.Command.CommandType = CommandType.StoredProcedure; // Indica que es un stored procedure
                sqlHelper.Command.Parameters.Clear(); // Limpia los parámetros del comando
                sqlHelper.Command.Parameters.AddWithValue("@IdUsuario", idUsuario); // Añade el parámetro de entrada

                // Ejecuta el stored procedure y lee los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read()) // Si se encuentra un registro
                    {
                        // Mapea los datos del lector al objeto Usuario_E
                        usuario = new Usuario_E
                        {
                            Id_Usuario = Convert.ToInt32(reader["id_usuario"]),
                            Id_Empleado = Convert.ToInt32(reader["id_empleado"]),
                            Nom_Usuario = reader["nom_usuario"].ToString(),
                            Permiso = reader["permiso"].ToString(),
                            Contraseña = reader["contraseña"].ToString(),
                            Fecha_Registro = reader["fecha_registro"].ToString(),
                            Hora_Registro = reader["hora_registro"].ToString(),
                            correo = reader["correo"].ToString(),
                            ExistsInAspNetUsers = Convert.ToBoolean(reader["ExistsInAspNetUsers"]) // Mapeo del nuevo campo
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el usuario por ID: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Asegúrate de cerrar la conexión a la base de datos
            }

            return usuario;
        }

        public List<Menu_E> GetMenusConEstado(int idUsuario)
        {
            List<Menu_E> menus = new List<Menu_E>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión a la base de datos

                // Configura el comando para ejecutar el stored procedure
                sqlHelper.Command.CommandText = "SP_Obtener_Menus_ConEstado"; // Nombre del stored procedure
                sqlHelper.Command.CommandType = CommandType.StoredProcedure; // Indica que es un stored procedure
                sqlHelper.Command.Parameters.Clear(); // Limpia los parámetros del comando
                sqlHelper.Command.Parameters.AddWithValue("@idUsuario", idUsuario); // Añade el parámetro de entrada

                // Ejecuta el stored procedure y lee los resultados
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read()) // Itera sobre los resultados
                    {
                        // Mapea los datos del lector al objeto Menu_E
                        Menu_E menu = new Menu_E
                        {
                            ID_Menu = Convert.ToInt32(reader["ID_Menu"]),
                            Nombre_Menu = reader["Nombre_Menu"].ToString(),                           
                            EstaAsignado = Convert.ToBoolean(reader["EstaAsignado"]) // Columna adicional que indica si está asignado
                        };

                        menus.Add(menu);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los menús con estado: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Asegúrate de cerrar la conexión a la base de datos
            }

            return menus;
        }
        public void ActualizarAccesosUsuario(int idUsuario, int[] selectedMenus)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión a la base de datos

                // Obtén el ID de AspNetUsers correspondiente al idUsuario
                sqlHelper.Command.CommandText = "SELECT Id FROM AspNetUsers WHERE id_usuario = @idUsuario";
                sqlHelper.Command.CommandType = CommandType.Text;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@idUsuario", idUsuario);

                string idAsp = sqlHelper.Command.ExecuteScalar()?.ToString();
                if (string.IsNullOrEmpty(idAsp))
                {
                    throw new Exception("No se encontró un usuario en AspNetUsers con el ID proporcionado.");
                }

                // Elimina los accesos existentes del usuario en la tabla Menu_Usuario
                sqlHelper.Command.CommandText = "DELETE FROM Menu_Usuario WHERE ID_Usuario = @idAsp";
                sqlHelper.Command.CommandType = CommandType.Text;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@idAsp", idAsp);
                sqlHelper.Command.ExecuteNonQuery();

                // Inserta los nuevos accesos seleccionados
                foreach (var menuId in selectedMenus)
                {
                    sqlHelper.Command.CommandText = "INSERT INTO Menu_Usuario (ID_Usuario, ID_Menu) VALUES (@idAsp, @idMenu)";
                    sqlHelper.Command.Parameters.Clear();
                    sqlHelper.Command.Parameters.AddWithValue("@idAsp", idAsp);
                    sqlHelper.Command.Parameters.AddWithValue("@idMenu", menuId);
                    sqlHelper.Command.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar los accesos del usuario: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión a la base de datos
            }
        }



    }
}
