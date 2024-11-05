using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class TiposIncidencias_DAL
    {
        private SqlHelper sqlHelper;

        public TiposIncidencias_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para obtener todas las tipos de incidencias
        public List<TiposIncidencias_E> GetAllTiposIncidencias()
        {
            List<TiposIncidencias_E> tiposIncidencias = new List<TiposIncidencias_E>();
            try
            {
                sqlHelper.OpenConnection();

                // Configura el comando para ejecutar el procedimiento almacenado o una consulta
                sqlHelper.Command.CommandText = "SELECT ID_TipoIncidencias, TipoIncidencia FROM TiposIncidencias";
                sqlHelper.Command.CommandType = CommandType.Text;
                sqlHelper.Command.Parameters.Clear();

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        TiposIncidencias_E tipoIncidencia = new TiposIncidencias_E
                        {
                            ID_TipoIncidencias = Convert.ToInt32(reader["ID_TipoIncidencias"]),
                            TipoIncidencia = reader["TipoIncidencia"].ToString()
                        };
                        tiposIncidencias.Add(tipoIncidencia);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los tipos de incidencias: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return tiposIncidencias;
        }

        // Método para obtener un tipo de incidencia por su ID
        public TiposIncidencias_E GetTiposIncidenciaById(int id)
        {
            TiposIncidencias_E tipoIncidencia = null;
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SELECT ID_TipoIncidencias, TipoIncidencia FROM TiposIncidencias WHERE ID_TipoIncidencias = @ID";
                sqlHelper.Command.CommandType = CommandType.Text;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@ID", id);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        tipoIncidencia = new TiposIncidencias_E
                        {
                            ID_TipoIncidencias = Convert.ToInt32(reader["ID_TipoIncidencias"]),
                            TipoIncidencia = reader["TipoIncidencia"].ToString()
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el tipo de incidencia: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return tipoIncidencia;
        }
    }
}
