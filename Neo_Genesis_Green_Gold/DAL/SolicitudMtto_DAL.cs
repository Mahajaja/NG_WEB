using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class SolicitudMtto_DAL
    {
        private SqlHelper sqlHelper;

        public SolicitudMtto_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        // Método para insertar una nueva solicitud de mantenimiento
        public int InsertarSolicitudMtto(SolicitudMtto_E solicitud)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_InsertarSolicitudMtto";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar los parámetros necesarios
                sqlHelper.Command.Parameters.AddWithValue("@fecha_registro", solicitud.FechaRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@hora_registro", solicitud.HoraRegistro);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", solicitud.IdUsuario);

                // Ejecutar el stored procedure y leer el resultado
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Retornar el ID de la solicitud
                        return Convert.ToInt32(reader["ID_Solicitud"]);
                    }
                }

                throw new Exception("No se recibió respuesta del stored procedure.");
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar la solicitud de mantenimiento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }


        // Método para obtener todas las solicitudes de mantenimiento
        public List<SolicitudMtto_E> GetAllSolicitudesMtto()
        {
            List<SolicitudMtto_E> solicitudes = new List<SolicitudMtto_E>();

            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_ObtenerSolicitudesMtto";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        SolicitudMtto_E solicitud = new SolicitudMtto_E
                        {
                            IdSolicitud = Convert.ToInt32(reader["id_solicitud"]),
                            FolioSolicitud = reader["folio_solicitud"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),

                            IdUbicacion = reader.IsDBNull(reader.GetOrdinal("id_ubicacion")) ? (int?)null : Convert.ToInt32(reader["id_ubicacion"]),
                            IdEmpleado = reader.IsDBNull(reader.GetOrdinal("id_empleado")) ? (int?)null : Convert.ToInt32(reader["id_empleado"]),
                            IdCategoria = reader.IsDBNull(reader.GetOrdinal("id_categoria")) ? (int?)null : Convert.ToInt32(reader["id_categoria"]),
                            IdMaquinaria = reader.IsDBNull(reader.GetOrdinal("id_maquinaria")) ? (int?)null : Convert.ToInt32(reader["id_maquinaria"]),
                            Horometro = reader.IsDBNull(reader.GetOrdinal("horometro")) ? (int?)null : Convert.ToInt32(reader["horometro"]),
                            FechaServicio = reader["fecha_servicio"].ToString(),
                            FechaEntrega = reader["fecha_entrega"].ToString(),
                            GradoUrgencia = reader["grado_urgencia"].ToString(),
                            IdResponsable = reader.IsDBNull(reader.GetOrdinal("id_responsable")) ? (int?)null : Convert.ToInt32(reader["id_responsable"]),
                            CostoReparacion = reader.IsDBNull(reader.GetOrdinal("costo_reparacion")) ? (float?)null : Convert.ToSingle(reader["costo_reparacion"]),
                            TipoServicio = reader["tipo_servicio"].ToString(),
                            IdRespReparacion = reader.IsDBNull(reader.GetOrdinal("id_respReparacion")) ? (int?)null : Convert.ToInt32(reader["id_respReparacion"]),
                            ProveedorReparacion = reader["proveedor_reparacion"].ToString(),
                            DescripcionProblema = reader["descripcion_problema"].ToString(),
                            ImgEvidencia = reader["img_evidencia"].ToString(),
                            ImgEvidencia2 = reader["img_evidencia2"].ToString(),
                            ImgEvidencia3 = reader["img_evidencia3"].ToString(),
                            ImgEvidencia4 = reader["img_evidencia4"].ToString(),
                            Estatus = reader["estatus"].ToString(),
                            IdUsuario = reader.IsDBNull(reader.GetOrdinal("id_usuario")) ? (int?)null : Convert.ToInt32(reader["id_usuario"]),
                            IdInstalacion = reader.IsDBNull(reader.GetOrdinal("id_instalacion")) ? (int?)null : Convert.ToInt32(reader["id_instalacion"]),

                            NombreEmpleado = reader["nombre_empleado"].ToString(),
                            ApellidoEmpleado = reader["apellido_empleado"].ToString(),
                            CategoriaNombre = reader["categoria_nombre"].ToString(),
                            NombreMaquinaria = reader["nombre_maquinaria"].ToString(),
                            NombreResponsable = reader["nombre_responsable"].ToString(),
                            ApellidoResponsable = reader["apellido_responsable"].ToString(),
                            NombreResponsableReparacion = reader["nombre_responsable_reparacion"].ToString(),
                            nombre_referencia = reader["nombre_referencia"].ToString(),
                            NombreUbicacion = reader["NombreUbicacion"].ToString(),
                            no_economico = reader["no_economico"].ToString(),
                            TieneEvaluacion = Convert.ToInt32(reader["TieneEvaluacion"]) == 1

                        };
                        solicitudes.Add(solicitud);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener las solicitudes de mantenimiento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }

            return solicitudes;
        }

        public SolicitudMtto_E ObtenerSolicitudMttoPorId(int idSolicitud)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_ObtenerSolicitudMttoPorId";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar parámetro
                sqlHelper.Command.Parameters.AddWithValue("@id_solicitud", idSolicitud);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return new SolicitudMtto_E
                        {
                            IdSolicitud = Convert.ToInt32(reader["id_solicitud"]),
                            FolioSolicitud = reader["folio_solicitud"].ToString(),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            HoraRegistro = reader["hora_registro"].ToString(),

                            IdUbicacion = reader.IsDBNull(reader.GetOrdinal("id_ubicacion")) ? (int?)null : Convert.ToInt32(reader["id_ubicacion"]),
                            IdEmpleado = reader.IsDBNull(reader.GetOrdinal("id_empleado")) ? (int?)null : Convert.ToInt32(reader["id_empleado"]),
                            IdCategoria = reader.IsDBNull(reader.GetOrdinal("id_categoria")) ? (int?)null : Convert.ToInt32(reader["id_categoria"]),
                            IdMaquinaria = reader.IsDBNull(reader.GetOrdinal("id_maquinaria")) ? (int?)null : Convert.ToInt32(reader["id_maquinaria"]),
                            Horometro = reader.IsDBNull(reader.GetOrdinal("horometro")) ? (int?)null : Convert.ToInt32(reader["horometro"]),
                            FechaServicio = reader["fecha_servicio"].ToString(),
                            FechaEntrega = reader["fecha_entrega"].ToString(),
                            GradoUrgencia = reader["grado_urgencia"].ToString(),
                            IdResponsable = reader.IsDBNull(reader.GetOrdinal("id_responsable")) ? (int?)null : Convert.ToInt32(reader["id_responsable"]),
                            CostoReparacion = reader.IsDBNull(reader.GetOrdinal("costo_reparacion")) ? (float?)null : Convert.ToSingle(reader["costo_reparacion"]),
                            TipoServicio = reader["tipo_servicio"].ToString(),
                            IdRespReparacion = reader.IsDBNull(reader.GetOrdinal("id_respReparacion")) ? (int?)null : Convert.ToInt32(reader["id_respReparacion"]),
                            ProveedorReparacion = reader["proveedor_reparacion"].ToString(),
                            DescripcionProblema = reader["descripcion_problema"].ToString(),
                            ImgEvidencia = reader["img_evidencia"].ToString(),
                            ImgEvidencia2 = reader["img_evidencia2"].ToString(),
                            ImgEvidencia3 = reader["img_evidencia3"].ToString(),
                            ImgEvidencia4 = reader["img_evidencia4"].ToString(),
                            Estatus = reader["estatus"].ToString(),
                            IdUsuario = reader.IsDBNull(reader.GetOrdinal("id_usuario")) ? (int?)null : Convert.ToInt32(reader["id_usuario"]),
                            IdInstalacion = reader.IsDBNull(reader.GetOrdinal("id_instalacion")) ? (int?)null : Convert.ToInt32(reader["id_instalacion"]),

                            NombreEmpleado = reader["nombre_empleado"].ToString(),
                            ApellidoEmpleado = reader["apellido_empleado"].ToString(),
                            CategoriaNombre = reader["categoria_nombre"].ToString(),
                            NombreMaquinaria = reader["nombre_maquinaria"].ToString(),
                            NombreResponsable = reader["nombre_responsable"].ToString(),
                            ApellidoResponsable = reader["apellido_responsable"].ToString(),
                            NombreResponsableReparacion = reader["nombre_responsable_reparacion"].ToString(),
                            nombre_referencia = reader["nombre_referencia"].ToString(),
                            NombreUbicacion = reader["NombreUbicacion"].ToString(),
                            no_economico = reader["no_economico"].ToString(),
                            Asignado = reader["Asignado"].ToString(),
                            instalacionDescripcion = reader["instalacionDescripcion"].ToString()
                        };
                    }
                }

                throw new Exception("No se encontró la solicitud de mantenimiento con el ID especificado.");
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la solicitud de mantenimiento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        // Método para eliminar una solicitud de mantenimiento por id_solicitud
        public string EliminarSolicitudMtto(int idSolicitud)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Delete_SOLICITUD_MTTO";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar parámetro
                sqlHelper.Command.Parameters.AddWithValue("@id_solicitud", idSolicitud);

                // Ejecutar el stored procedure y capturar el mensaje de confirmación
                string mensaje = sqlHelper.Command.ExecuteScalar()?.ToString();
                return mensaje ?? "Registro eliminado correctamente.";
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar la solicitud de mantenimiento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        // Método para actualizar una solicitud de mantenimiento
        public string ActualizarSolicitudMtto(SolicitudMtto_E solicitud, string nombreArchivo1, string nombreArchivo2, string nombreArchivo3, string nombreArchivo4)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_ActualizarSolicitudMtto";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar parámetros al stored procedure
                sqlHelper.Command.Parameters.AddWithValue("@id_solicitud", solicitud.IdSolicitud);
                sqlHelper.Command.Parameters.AddWithValue("@id_ubicacion", solicitud.IdUbicacion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", solicitud.IdEmpleado ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_categoria", solicitud.IdCategoria ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_maquinaria", solicitud.IdMaquinaria ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@horometro", solicitud.Horometro ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_servicio", solicitud.FechaServicio ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_entrega", solicitud.FechaEntrega ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@grado_urgencia", solicitud.GradoUrgencia ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_responsable", solicitud.IdResponsable ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@costo_reparacion", solicitud.CostoReparacion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@tipo_servicio", solicitud.TipoServicio ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_respReparacion", solicitud.IdRespReparacion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@proveedor_reparacion", solicitud.ProveedorReparacion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@descripcion_problema", solicitud.DescripcionProblema ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@asignado", solicitud.Asignado ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@estatus", solicitud.Estatus ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", solicitud.IdUsuario ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@idInstalacion", solicitud.IdInstalacion ?? (object)DBNull.Value);

                // Parámetros para evidencias y nombres de archivo
                //sqlHelper.Command.Parameters.AddWithValue("@Evidencia1", (object)imagen1 ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@NombreArchivo1", (object)nombreArchivo1 ?? DBNull.Value);
                //sqlHelper.Command.Parameters.AddWithValue("@Evidencia2", (object)imagen2 ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@NombreArchivo2", (object)nombreArchivo2 ?? DBNull.Value);
               // sqlHelper.Command.Parameters.AddWithValue("@Evidencia3", (object)imagen3 ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@NombreArchivo3", (object)nombreArchivo3 ?? DBNull.Value);
                //sqlHelper.Command.Parameters.AddWithValue("@Evidencia4", (object)imagen4 ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@NombreArchivo4", (object)nombreArchivo4 ?? DBNull.Value);

                // Ejecutar el procedimiento almacenado y capturar el mensaje
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return reader["Mensaje"].ToString();
                    }
                }

                throw new Exception("No se recibió respuesta del procedimiento almacenado.");
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar la solicitud de mantenimiento: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        // Método para insertar un cierre de orden
        public int InsertarCierreOrden(int idOrden, int idUsuario)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_InsertarCierreOrden";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar los parámetros necesarios
                sqlHelper.Command.Parameters.AddWithValue("@id_solicitud", idOrden);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", idUsuario);

                // Ejecutar el stored procedure y leer el resultado
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Retornar el ID del cierre
                        return Convert.ToInt32(reader["ID_Cierre"]);
                    }
                }

                throw new Exception("No se recibió respuesta del stored procedure.");
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar el cierre de orden: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        // Método para eliminar un cierre de orden por ID
        public string EliminarCierreOrden(int idCierre)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Delete_CIERRE_ORDEN";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar parámetro
                sqlHelper.Command.Parameters.AddWithValue("@id_cierre", idCierre);

                // Ejecutar el stored procedure y capturar el mensaje de confirmación
                string mensaje = sqlHelper.Command.ExecuteScalar()?.ToString();
                return mensaje ?? "Registro eliminado correctamente.";
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar el cierre de orden: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        // Método para obtener los datos de un registro de CIERRE_ORDEN por id_cierreOrden
        public CierreOrden_E ObtenerCierreOrdenPorId(int idCierreOrden)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Get_CIERRE_ORDEN_ById";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar parámetro
                sqlHelper.Command.Parameters.AddWithValue("@id_cierreOrden", idCierreOrden);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Crear un objeto CierreOrden_E y asignar los valores
                        return new CierreOrden_E
                        {
                            IdCierreOrden = Convert.ToInt32(reader["id_cierreOrden"]),
                            FolioOrden = reader["folio_orden"]?.ToString(),
                            FechaRegistro = reader["fecha_registro"]?.ToString(),
                            HoraRegistro = reader["hora_registro"]?.ToString(),
                            IdOrden = reader.IsDBNull(reader.GetOrdinal("id_orden")) ? (int?)null : Convert.ToInt32(reader["id_orden"]),
                            IdUsuario = reader.IsDBNull(reader.GetOrdinal("id_usuario")) ? (int?)null : Convert.ToInt32(reader["id_usuario"]),
                            HerramientasTrabajo = reader["herramientas_trabajo"]?.ToString(),
                            TiempoReparacion = reader["tiempo_reparacion"]?.ToString(),
                            ReparacionRealizada = reader["reparacion_realizada"]?.ToString(),
                            OtraFalla = reader["otra_falla"]?.ToString(),
                            EspecificacionFalla = reader["especificacion_falla"]?.ToString(),
                            AreaReparacion = reader["area_reparacion"]?.ToString(),
                            MedidasSeguridad = reader["medidas_seguridad"]?.ToString(),
                            AreaLimpia = reader["area_limpia"]?.ToString(),
                            CalidadTrabajo = reader["calidad_trabajo"]?.ToString(),
                            EspecificarCalidad = reader["especificar_calidad"]?.ToString(),
                            SobranteMaterial = reader["sobrante_material"]?.ToString(),
                            EntradaAlmacen = reader["entrada_almacen"]?.ToString(),
                            Observaciones = reader["observaciones"]?.ToString(),
                            Responsable = reader["Responsable"]?.ToString(),
                            Folio_orden = reader["Folio_orden"]?.ToString(),
                            tipo_servicio = reader["tipo_servicio"]?.ToString()
                        };
                    }
                }

                throw new Exception("No se encontró un registro con el ID especificado.");
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el registro de cierre de orden: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        // Método para actualizar un registro de CIERRE_ORDEN
        public string ActualizarCierreOrden(CierreOrden_E cierreOrden)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Update_CIERRE_ORDEN";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Parámetro obligatorio
                sqlHelper.Command.Parameters.AddWithValue("@id_cierreOrden", cierreOrden.IdCierreOrden);

                // Parámetros opcionales (se envían como NULL si no tienen valor)
                sqlHelper.Command.Parameters.AddWithValue("@herramientas_trabajo", cierreOrden.HerramientasTrabajo ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@tiempo_reparacion", cierreOrden.TiempoReparacion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@reparacion_realizada", cierreOrden.ReparacionRealizada ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@otra_falla", cierreOrden.OtraFalla ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@especificacion_falla", cierreOrden.EspecificacionFalla ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@area_reparacion", cierreOrden.AreaReparacion ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@medidas_seguridad", cierreOrden.MedidasSeguridad ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@area_limpia", cierreOrden.AreaLimpia ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@calidad_trabajo", cierreOrden.CalidadTrabajo ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@especificar_calidad", cierreOrden.EspecificarCalidad ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@sobrante_material", cierreOrden.SobranteMaterial ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@entrada_almacen", cierreOrden.EntradaAlmacen ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@observaciones", cierreOrden.Observaciones ?? (object)DBNull.Value);

                // Ejecutar el SP y leer el mensaje de confirmación
                string mensaje = sqlHelper.Command.ExecuteScalar()?.ToString();
                return mensaje ?? "Registro actualizado correctamente.";
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar el registro de cierre de orden: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }


    }
}
