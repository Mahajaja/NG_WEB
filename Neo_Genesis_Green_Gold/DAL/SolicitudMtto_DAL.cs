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
                            IdUbicacion = Convert.ToInt32(reader["id_ubicacion"]),
                            IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                            NombreEmpleado = reader["nombre_empleado"].ToString(),
                            ApellidoEmpleado = reader["apellido_empleado"].ToString(),
                            IdCategoria = Convert.ToInt32(reader["id_categoria"]),
                            CategoriaNombre = reader["categoria_nombre"].ToString(),
                            IdMaquinaria = Convert.ToInt32(reader["id_maquinaria"]),
                            NombreMaquinaria = reader["nombre_maquinaria"].ToString(),
                            OtroLugar = reader["otro_lugar"].ToString(),
                            Horometro = Convert.ToInt32(reader["horometro"]),
                            FechaServicio = reader["fecha_servicio"].ToString(),
                            FechaEntrega = reader["fecha_entrega"].ToString(),
                            GradoUrgencia = reader["grado_urgencia"].ToString(),
                            IdResponsable = Convert.ToInt32(reader["id_responsable"]),
                            NombreResponsable = reader["nombre_responsable"].ToString(),
                            ApellidoResponsable = reader["apellido_responsable"].ToString(),
                            CostoReparacion = Convert.ToSingle(reader["costo_reparacion"]),
                            TipoServicio = reader["tipo_servicio"].ToString(),
                            IdRespReparacion = Convert.ToInt32(reader["id_respReparacion"]),
                            NombreResponsableReparacion = reader["nombre_responsable_reparacion"].ToString(),
                            ProveedorReparacion = reader["proveedor_reparacion"].ToString(),
                            DescripcionProblema = reader["descripcion_problema"].ToString(),
                            ImgEvidencia = reader["img_evidencia"].ToString(),
                            ImgEvidencia2 = reader["img_evidencia2"].ToString(),
                            ImgEvidencia3 = reader["img_evidencia3"].ToString(),
                            ImgEvidencia4 = reader["img_evidencia4"].ToString(),
                            Estatus = reader["estatus"].ToString(),
                            IdUsuario = Convert.ToInt32(reader["id_usuario"])
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
    }
}
