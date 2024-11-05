using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Sanciones_DAL
    {
        private SqlHelper sqlHelper;

        public Sanciones_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para obtener todas las sanciones
        public List<Sanciones_E> GetAllSanciones()
        {
            List<Sanciones_E> sanciones = new List<Sanciones_E>();
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SELECT ID_Sancion, Sancion FROM Sanciones";
                sqlHelper.Command.CommandType = CommandType.Text;
                sqlHelper.Command.Parameters.Clear();

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Sanciones_E sancion = new Sanciones_E
                        {
                            ID_Sancion = Convert.ToInt32(reader["ID_Sancion"]),
                            Sancion = reader["Sancion"].ToString()
                        };
                        sanciones.Add(sancion);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener las sanciones: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return sanciones;
        }

        // Método para obtener una sanción por su ID
        public Sanciones_E GetSancionById(int id)
        {
            Sanciones_E sancion = null;
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SELECT ID_Sancion, Sancion FROM Sanciones WHERE ID_Sancion = @ID";
                sqlHelper.Command.CommandType = CommandType.Text;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@ID", id);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        sancion = new Sanciones_E
                        {
                            ID_Sancion = Convert.ToInt32(reader["ID_Sancion"]),
                            Sancion = reader["Sancion"].ToString()
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la sanción: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return sancion;
        }
    }
}
