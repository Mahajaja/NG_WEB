using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Maquinaria_DAL
    {
        private SqlHelper sqlHelper;

        public Maquinaria_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para obtener toda la maquinaria
        // Método para obtener maquinaria con filtros opcionales por id_ubicacion e id_categoria
        public List<Maquinaria_E> ObtenerMaquinaria(int? idUbicacion = null, int? idCategoria = null)
        {
            List<Maquinaria_E> maquinarias = new List<Maquinaria_E>();

            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_ObtenerMaquinaria";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar parámetros opcionales
                sqlHelper.Command.Parameters.AddWithValue("@id_ubicacion", (object)idUbicacion ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_categoria", (object)idCategoria ?? DBNull.Value);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Maquinaria_E maquinaria = new Maquinaria_E
                        {
                            IdMaquinaria = reader["id_maquinaria"] != DBNull.Value ? Convert.ToInt32(reader["id_maquinaria"]) : 0,
                            NoEconomico = reader["no_economico"] != DBNull.Value ? reader["no_economico"].ToString() : string.Empty,
                            FolioRegistro = reader["folio_registro"] != DBNull.Value ? reader["folio_registro"].ToString() : string.Empty,
                            HoraRegistro = reader["hora_registro"] != DBNull.Value ? reader["hora_registro"].ToString() : string.Empty,
                            FechaRegistro = reader["fecha_registro"] != DBNull.Value ? reader["fecha_registro"].ToString() : string.Empty,
                            Marca = reader["marca"] != DBNull.Value ? reader["marca"].ToString() : string.Empty,
                            Modelo = reader["modelo"] != DBNull.Value ? reader["modelo"].ToString() : string.Empty,
                            NoMotor = reader["no_motor"] != DBNull.Value ? reader["no_motor"].ToString() : string.Empty,
                            Especificacion = reader["especificacion"] != DBNull.Value ? reader["especificacion"].ToString() : string.Empty,
                            IdCategoriaEstado = reader["id_categoria_estado"] != DBNull.Value ? Convert.ToInt32(reader["id_categoria_estado"]) : 0,
                            IdUbicacion = reader["id_ubicacion"] != DBNull.Value ? Convert.ToInt32(reader["id_ubicacion"]) : 0,
                            IdCategoria = reader["id_categoria"] != DBNull.Value ? Convert.ToInt32(reader["id_categoria"]) : 0,
                            IdSubcategoria = reader["id_subcategoria"] != DBNull.Value ? Convert.ToInt32(reader["id_subcategoria"]) : 0,
                            ImgMaquinaria = reader["img_maquinaria"] != DBNull.Value ? reader["img_maquinaria"].ToString() : string.Empty,
                            ImgFactura = reader["img_factura"] != DBNull.Value ? reader["img_factura"].ToString() : string.Empty,
                            IdUsuario = reader["id_usuario"] != DBNull.Value ? Convert.ToInt32(reader["id_usuario"]) : 0
                        };

                        maquinarias.Add(maquinaria);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la maquinaria: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return maquinarias;
        }

    }
}
