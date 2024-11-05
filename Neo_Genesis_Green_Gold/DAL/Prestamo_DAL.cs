using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Prestamo_DAL
    {
        private SqlHelper sqlHelper;

        public Prestamo_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para obtener todos los préstamos
        public List<Prestamo_E> GetAllPrestamos()
        {
            List<Prestamo_E> prestamos = new List<Prestamo_E>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ObtenerPrestamos";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Prestamo_E prestamo = new Prestamo_E
                        {
                            IdPrestamo = Convert.ToInt32(reader["id_prestamo"]),
                            FolioPrestamo = reader["folio_prestamo"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            IdUbicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            CantidadAutorizada = reader["cantidad_autorizada"].ToString(),
                            DescuentoSemanal = reader["descuento_semanal"].ToString(),
                            FechaEntrega = reader["fecha_entrega"].ToString(),
                            FechaInicio = reader["fecha_inicio"].ToString(),
                            FechaFin = reader["fecha_fin"].ToString(),
                            Estatus = reader["Estatus"].ToString(),
                            Motivo = reader["motivo"].ToString(),
                            IdUsuario = Convert.ToInt32(reader["id_usuario"]),
                            IdEstatus = Convert.ToInt32(reader["ID_Estatus"]),
                            empleado = new Empleados_E
                            {
                                IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                                Nombre = reader["Nombre"].ToString(),
                                ApellidoPaterno = reader["apellido_paterno"].ToString(),
                                ApellidoMaterno = reader["apellido_materno"].ToString(),
                                FechaNacimiento = reader["fecha_nacimiento"].ToString()
                            }
                        };
                        prestamos.Add(prestamo);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los préstamos: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }

            return prestamos;
        }

        // Método para insertar un préstamo
        public bool InsertarPrestamo(int idUbicacion, int idEmpleado, string cantidadAutorizada, string fechaEntrega, string motivo, int idUsuario)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_InsertarPrestamo";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agrega los parámetros necesarios
                sqlHelper.Command.Parameters.AddWithValue("@id_ubicacion", idUbicacion);
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", idEmpleado);
                sqlHelper.Command.Parameters.AddWithValue("@cantidad_autorizada", cantidadAutorizada);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_entrega", fechaEntrega);
                sqlHelper.Command.Parameters.AddWithValue("@motivo", motivo);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", idUsuario);

                // Ejecuta el comando

                return true; // Devuelve true si se insertó correctamente
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar el préstamo: " + ex.Message);

            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }
        }


    }
}
