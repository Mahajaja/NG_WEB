using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Instalacion_DAL
    {
        private readonly SqlHelper _sqlHelper;

        public Instalacion_DAL()
        {
            _sqlHelper = new SqlHelper();
        }

        public List<Instalacion_E> ObtenerInstalacionesPorUbicacion(int idUbicacion)
        {
            List<Instalacion_E> instalaciones = new List<Instalacion_E>();

            try
            {
                _sqlHelper.OpenConnection();

                _sqlHelper.Command.CommandText = "SP_ObtenerInstalacionesPorUbicacion";
                _sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                _sqlHelper.Command.Parameters.Clear();
                _sqlHelper.Command.Parameters.AddWithValue("@IdUbicacion", idUbicacion);

                using (SqlDataReader reader = _sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Instalacion_E instalacion = new Instalacion_E
                        {
                            IdInstalacion = Convert.ToInt32(reader["id_instalacion"]),
                            FolioInstalacion = reader["folio_instalacion"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),
                            IdUbicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            IdAlmacen = Convert.ToInt32(reader["id_almacen"]),
                            Nombre = reader["nombre"].ToString(),
                            Uso = reader["uso"].ToString(),
                            IdUsuario = Convert.ToInt32(reader["id_usuario"]),
                            Descripcion = reader["descripcion"].ToString()
                        };

                        instalaciones.Add(instalacion);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener instalaciones: " + ex.Message);
            }
            finally
            {
                _sqlHelper.CloseConnection();
            }

            return instalaciones;
        }

        public Instalacion_E ObtenerInstalacionPorId(int idInstalacion)
        {
            Instalacion_E instalacion = null;

            try
            {
                _sqlHelper.OpenConnection();

                _sqlHelper.Command.CommandText = "SP_Select_Instalacion_ById";
                _sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                _sqlHelper.Command.Parameters.Clear();
                _sqlHelper.Command.Parameters.AddWithValue("@id_instalacion", idInstalacion);

                using (SqlDataReader reader = _sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read()) // Si encuentra un registro
                    {
                        instalacion = new Instalacion_E
                        {
                            IdInstalacion = Convert.ToInt32(reader["id_instalacion"]),
                            FolioInstalacion = reader["folio_instalacion"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),
                            IdUbicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            IdAlmacen = Convert.ToInt32(reader["id_almacen"]),
                            Nombre = reader["nombre"].ToString(),
                            Uso = reader["uso"].ToString(),
                            IdUsuario = Convert.ToInt32(reader["id_usuario"]),
                            Descripcion = reader["descripcion"].ToString()
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener instalación por ID: " + ex.Message);
            }
            finally
            {
                _sqlHelper.CloseConnection();
            }

            return instalacion;
        }


    }
}
