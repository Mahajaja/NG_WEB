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
        public List<Prestamo_E> GetAllPrestamos(int idEmpleado)
        {
            List<Prestamo_E> prestamos = new List<Prestamo_E>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ObtenerPrestamos";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar el parámetro @id_empleado
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", idEmpleado);

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Prestamo_E prestamo = new Prestamo_E
                        {
                            IdPrestamo = reader["id_prestamo"] != DBNull.Value ? Convert.ToInt32(reader["id_prestamo"]) : 0,
                            FolioPrestamo = reader["folio_prestamo"]?.ToString(),
                            HoraRegistro = reader["hora_registro"]?.ToString(),
                            FechaRegistro = reader["fecha_registro"]?.ToString(),
                            IdUbicacion = reader["id_ubicacion"] != DBNull.Value ? Convert.ToInt32(reader["id_ubicacion"]) : 0,
                            IdEmpleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : 0,
                            CantidadAutorizada = reader["cantidad_autorizada"]?.ToString(),
                            DescuentoSemanal = reader["descuento_semanal"]?.ToString(),
                            FechaEntrega = reader["fecha_entrega"]?.ToString(),
                            FechaInicio = reader["fecha_inicio"]?.ToString(),
                            FechaFin = reader["fecha_fin"]?.ToString(),
                            Estatus = reader["Estatus"]?.ToString(),
                            Motivo = reader["motivo"]?.ToString(),
                            IdUsuario = reader["id_usuario"] != DBNull.Value ? Convert.ToInt32(reader["id_usuario"]) : 0,
                            IdEstatus = reader["ID_Estatus"] != DBNull.Value ? Convert.ToInt32(reader["ID_Estatus"]) : 0,
                            empleado = new Empleados_E
                            {
                                IdEmpleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : 0,
                                Nombre = reader["nombre"]?.ToString(),
                                ApellidoPaterno = reader["apellido_paterno"]?.ToString(),
                                ApellidoMaterno = reader["apellido_materno"]?.ToString(),
                                FechaNacimiento = reader["fecha_nacimiento"]?.ToString()
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


        public int InsertPrestamo(Prestamo_E prestamo)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_InsertarPrestamo";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                sqlHelper.Command.Parameters.AddWithValue("@fecha_registro", prestamo.FechaRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@hora_registro", prestamo.HoraRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", prestamo.IdUsuario);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return Convert.ToInt32(reader["ID_Prestamo"]); // Asegúrate de que el alias coincida con el SP
                    }
                    else
                    {
                        throw new Exception("No se pudo obtener el ID del préstamo.");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar el préstamo: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        public bool ActualizarPrestamo(Prestamo_E prestamoE)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ActualizarPrestamo";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agrega los parámetros necesarios
                sqlHelper.Command.Parameters.AddWithValue("@id_prestamo", prestamoE.IdPrestamo);

               

                if (prestamoE.IdEmpleado != null)
                    sqlHelper.Command.Parameters.AddWithValue("@id_empleado", prestamoE.IdEmpleado);

                if (!string.IsNullOrEmpty(prestamoE.CantidadAutorizada))
                    sqlHelper.Command.Parameters.AddWithValue("@cantidad_autorizada", prestamoE.CantidadAutorizada);

                if (!string.IsNullOrEmpty(prestamoE.FechaEntrega))
                    sqlHelper.Command.Parameters.AddWithValue("@fecha_entrega", prestamoE.FechaEntrega);

                if (!string.IsNullOrEmpty(prestamoE.Motivo))
                    sqlHelper.Command.Parameters.AddWithValue("@motivo", prestamoE.Motivo);

                if (prestamoE.IdUsuario != null)
                    sqlHelper.Command.Parameters.AddWithValue("@id_usuario", prestamoE.IdUsuario);

                // Ejecutar el comando
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string mensaje = reader["Mensaje"].ToString();
                        if (mensaje == "Préstamo actualizado exitosamente.")
                        {
                            return true; // La actualización fue exitosa
                        }
                        else
                        {
                            throw new Exception("Error al actualizar el préstamo: " + mensaje);
                        }
                    }
                    else
                    {
                        throw new Exception("No se obtuvo una respuesta del servidor.");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar el préstamo: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }
        }
        public Prestamo_E GetPrestamoById(int idPrestamo)
        {
            Prestamo_E prestamo = null;
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ObtenerPrestamoPorId";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agrega el parámetro necesario
                sqlHelper.Command.Parameters.AddWithValue("@id_prestamo", idPrestamo);

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader != null && reader.Read())
                    {
                        prestamo = new Prestamo_E
                        {
                            IdPrestamo = Convert.ToInt32(reader["id_prestamo"]),
                            FolioPrestamo = reader["folio_prestamo"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            IdUbicacion = reader["id_ubicacion"] != DBNull.Value ? Convert.ToInt32(reader["id_ubicacion"]) : 0,
                            IdEmpleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : 0,
                            CantidadAutorizada = reader["cantidad_autorizada"].ToString(),
                            DescuentoSemanal = reader["descuento_semanal"].ToString(),
                            FechaEntrega = reader["fecha_entrega"].ToString(),
                            FechaInicio = reader["fecha_inicio"].ToString(),
                            FechaFin = reader["fecha_fin"].ToString()
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el préstamo: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }

            if (prestamo == null)
            {
                throw new Exception("No se encontró el préstamo con el ID especificado.");
            }

            return prestamo;
        }

        public int Delete(int id)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "SP_Delete_PRESTAMO";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@id", id);

                // Ejecuta el comando
                return sqlHelper.Command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al intentar eliminar el registro: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }
        }

    }
}
