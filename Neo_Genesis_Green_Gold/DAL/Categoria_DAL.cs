using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Categoria_DAL
    {
        private SqlHelper sqlHelper;

        public Categoria_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para obtener todas las categorías
        public List<Categoria_E> ObtenerCategorias()
        {
            List<Categoria_E> categorias = new List<Categoria_E>();

            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_ObtenerCategorias";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Categoria_E categoria = new Categoria_E
                        {
                            Id_Categoria = Convert.ToInt32(reader["id_categoria"]),
                            Nombre_Categoria = reader["nombre_categoria"].ToString(),
                            Clasificacion = reader["clasificacion"].ToString(),
                            Fecha_Registro = reader["fecha_registro"].ToString(),
                            Hora_Registro = reader["hora_registro"].ToString(),
                            Id_Usuario = Convert.ToInt32(reader["id_usuario"])
                        };
                        categorias.Add(categoria);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener las categorías: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return categorias;
        }
    }
}
