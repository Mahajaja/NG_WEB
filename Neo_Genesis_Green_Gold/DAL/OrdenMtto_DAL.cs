using System;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class OrdenMtto_DAL
    {
        private SqlHelper sqlHelper;

        public OrdenMtto_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para insertar una nueva orden de mantenimiento
        public int InsertarOrdenMtto(int idUsuario, int idSolicitud)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_InsertarOrdenMtto";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar los parámetros necesarios
                //sqlHelper.Command.Parameters.AddWithValue("@id_usuario", idUsuario);
                sqlHelper.Command.Parameters.AddWithValue("@id_solicitud", idSolicitud);

                // Ejecutar el stored procedure y leer el resultado
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Retornar el ID de la orden
                        return Convert.ToInt32(reader["ID_Orden"]);
                    }
                }

                throw new Exception("No se recibió respuesta del stored procedure.");
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar la orden de mantenimiento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }


        // Método para eliminar una orden de mantenimiento por id_orden
        public string EliminarOrdenMtto(int idOrden)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Delete_ORDEN_MTTO";
                sqlHelper.Command.CommandType = System.Data.CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar parámetro
                sqlHelper.Command.Parameters.AddWithValue("@id_orden", idOrden);

                // Ejecutar el stored procedure y capturar el mensaje de confirmación
                string mensaje = sqlHelper.Command.ExecuteScalar()?.ToString();
                return mensaje ?? "Registro eliminado correctamente.";
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar la orden de mantenimiento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        // Método para obtener un registro de ORDEN_MTTO por id_orden
        public OrdenMtto_E ObtenerOrdenMttoPorId(int idOrden)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Get_ORDEN_MTTO";
                sqlHelper.Command.CommandType = System.Data.CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar el parámetro
                sqlHelper.Command.Parameters.AddWithValue("@id_orden", idOrden);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return new OrdenMtto_E
                        {
                            IdOrden = Convert.ToInt32(reader["id_orden"]),
                            IdSolicitud = Convert.ToInt32(reader["id_solicitud"]),
                            FolioOrden = reader["folio_orden"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),
                            TipoServicio = reader["tipo_servicio"].ToString(),
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            AtendidoExterno = reader["atendido_externo"].ToString(),
                            DiagnosticoFalla = reader["diagnostico_falla"].ToString(),
                            Observaciones = reader["observaciones"].ToString(),
                            Refacciones = reader["refacciones"].ToString(),
                            FolioAlmacen = reader["folio_almacen"].ToString(),
                            FolioCompras = reader["folio_compras"].ToString(),
                            FallaCorregida = reader["falla_corregida"].ToString(),
                            TiempoInvertido = reader["tiempo_invertido"].ToString(),
                            ImgSolucion = reader["img_solucion"].ToString(),
                            ImgSolucion2 = reader["img_solucion2"].ToString(),
                            ImgSolucion3 = reader["img_solucion3"].ToString(),
                            ImgSolucion4 = reader["img_solucion4"].ToString()
                        };
                    }
                }

                throw new Exception("No se encontró el registro con el ID especificado.");
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la orden de mantenimiento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        // Método para actualizar una orden de mantenimiento
        public string ActualizarOrdenMtto(OrdenMtto_E orden)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_ActualizarOrdenMtto"; // Nombre del stored procedure
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar los parámetros necesarios
                sqlHelper.Command.Parameters.AddWithValue("@id_orden", orden.IdOrden);
                sqlHelper.Command.Parameters.AddWithValue("@tipo_servicio", (object)orden.TipoServicio ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", (object)orden.IdEmpleado ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@atendido_externo", (object)orden.AtendidoExterno ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@diagnostico_falla", (object)orden.DiagnosticoFalla ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@observaciones", (object)orden.Observaciones ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@refacciones", (object)orden.Refacciones ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@folio_almacen", (object)orden.FolioAlmacen ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@folio_compras", (object)orden.FolioCompras ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@falla_corregida", (object)orden.FallaCorregida ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@tiempo_invertido", (object)orden.TiempoInvertido ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@img_solucion", (object)orden.ImgSolucion ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@img_solucion2", (object)orden.ImgSolucion2 ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@img_solucion3", (object)orden.ImgSolucion3 ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@img_solucion4", (object)orden.ImgSolucion4 ?? DBNull.Value);
                

                // Ejecutar el stored procedure y capturar el mensaje de confirmación
                string mensaje = sqlHelper.Command.ExecuteScalar()?.ToString();
                return mensaje ?? "Orden de mantenimiento actualizada correctamente.";
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar la orden de mantenimiento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }


    }
}
