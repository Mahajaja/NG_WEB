using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Evidencias_DAL
    {
        private SqlHelper sqlHelper;

        public Evidencias_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para obtener evidencias por ID_Tabla
        public List<Evidencias_E> GetEvidenciasPorTabla(int idTabla)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_GetEvidenciasPorTabla";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar el parámetro necesario
                sqlHelper.Command.Parameters.AddWithValue("@ID_Tabla", idTabla);

                List<Evidencias_E> evidencias = new List<Evidencias_E>();

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Evidencias_E evidencia = new Evidencias_E
                        {
                            ID_Evidencia = Convert.ToInt32(reader["ID_Evidencia"]),
                            ID_Tabla = Convert.ToInt32(reader["ID_Tabla"]),
                            //Evidencia_Base64 = reader["Evidencia_Base64"]?.ToString(),
                            NombreArchivo = reader["NombreArchivo"]?.ToString(),
                            IdUsuario = Convert.ToInt32(reader["id_usuario"]),
                            FechaInserto = Convert.ToDateTime(reader["FechaInserto"]),
                            ID_TipoEvidencia = Convert.ToInt32(reader["ID_TipoEvidencia"])
                        };
                        evidencias.Add(evidencia);
                    }
                }

                return evidencias;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener evidencias: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }
    }
}
