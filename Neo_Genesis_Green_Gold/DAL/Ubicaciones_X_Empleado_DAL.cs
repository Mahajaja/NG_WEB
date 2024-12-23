using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Ubicaciones_X_Empleado_DAL
    {
        private SqlHelper sqlHelper;

        public Ubicaciones_X_Empleado_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para obtener las ubicaciones asignadas a un empleado
        public List<Ubicaciones_X_Empleado_E> ObtenerUbicacionesPorEmpleado(int idEmpleado)
        {
            List<Ubicaciones_X_Empleado_E> ubicaciones = new List<Ubicaciones_X_Empleado_E>();

            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Select_Ubicaciones_X_Empleado";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar el parámetro idEmpleado
                sqlHelper.Command.Parameters.AddWithValue("@Id_Empleado", idEmpleado);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Ubicaciones_X_Empleado_E ubicacion = new Ubicaciones_X_Empleado_E
                        {
                            ID_Ubicaciones_X_Empleado = Convert.ToInt32(reader["ID_Ubicaciones_X_Empleado"]),
                            Id_Ubicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            Id_Empleado = Convert.ToInt32(reader["id_empleado"]),
                            Ubicacion = new Ubicacion_E
                            {
                                Nombre = reader["NombreUbicacion"].ToString()
                            }
                        };

                        ubicaciones.Add(ubicacion);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener las ubicaciones del empleado: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return ubicaciones;
        }

        public int InsertarUbicacionXEmpleado(int idUbicacion, int idEmpleado)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Insertar_Ubicaciones_X_Empleado";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar parámetros
                sqlHelper.Command.Parameters.AddWithValue("@Id_Ubicacion", idUbicacion);
                sqlHelper.Command.Parameters.AddWithValue("@Id_Empleado", idEmpleado);

                // Ejecutar el SP y retornar el ID generado
                object result = sqlHelper.Command.ExecuteScalar();
                return Convert.ToInt32(result);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar la ubicación del empleado: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        public void BorrarUbicacionesPorEmpleado(int idEmpleado)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Borrar_Ubicaciones_X_Empleado";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar parámetro
                sqlHelper.Command.Parameters.AddWithValue("@Id_Empleado", idEmpleado);

                // Ejecutar el SP
                sqlHelper.Command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al borrar las ubicaciones del empleado: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }


    }
}
