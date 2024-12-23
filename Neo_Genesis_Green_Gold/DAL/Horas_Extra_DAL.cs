using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Horas_Extra_DAL
    {
        private SqlHelper sqlHelper;

        public Horas_Extra_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        public List<Horas_Extras_E> GetAllHorasExtra(int idEmpleado)
        {
            List<Horas_Extras_E> horasExtras = new List<Horas_Extras_E>();

            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ObtenerHorasExtras";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar el parámetro @id_empleado
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", idEmpleado);

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Horas_Extras_E horaExtra = new Horas_Extras_E
                        {
                            id_horaExtra = reader["id_horaExtra"] != DBNull.Value ? Convert.ToInt32(reader["id_horaExtra"]) : 0,
                            folio_registro = reader["folio_registro"]?.ToString(),
                            fecha_registro = reader["fecha_registro"]?.ToString(),
                            hora_registro = reader["hora_registro"]?.ToString(),
                            id_empleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : (int?)null,
                            id_responsable = reader["id_responsable"] != DBNull.Value ? Convert.ToInt32(reader["id_responsable"]) : (int?)null,
                            fecha_compensacion = reader["fecha_compensacion"]?.ToString(),
                            costo_horaExtra = reader["costo_horaExtra"] != DBNull.Value ? Convert.ToSingle(reader["costo_horaExtra"]) : (float?)null,
                            costo_horaDoble = reader["costo_horaDoble"] != DBNull.Value ? Convert.ToSingle(reader["costo_horaDoble"]) : (float?)null,
                            horas_porPagar = reader["horas_porPagar"] != DBNull.Value ? Convert.ToInt32(reader["horas_porPagar"]) : (int?)null,
                            hora_triple = reader["hora_triple"] != DBNull.Value ? Convert.ToInt32(reader["hora_triple"]) : (int?)null,
                            total_horaDoble = reader["total_horaDoble"] != DBNull.Value ? Convert.ToSingle(reader["total_horaDoble"]) : (float?)null,
                            total_horaTriple = reader["total_horaTriple"] != DBNull.Value ? Convert.ToSingle(reader["total_horaTriple"]) : (float?)null,
                            total_aPagar = reader["total_aPagar"] != DBNull.Value ? Convert.ToSingle(reader["total_aPagar"]) : (float?)null,
                            motivo_hraExtra = reader["motivo_hraExtra"]?.ToString(),
                            observaciones = reader["observaciones"]?.ToString(),
                            Estatus = reader["Estatus"]?.ToString(),
                            id_usuario = reader["id_usuario"] != DBNull.Value ? Convert.ToInt32(reader["id_usuario"]) : (int?)null,
                            empleado = new Empleados_E
                            {
                                IdEmpleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : 0,
                                Nombre = reader["nombre"]?.ToString(),
                                ApellidoPaterno = reader["apellido_paterno"]?.ToString(),
                                ApellidoMaterno = reader["apellido_materno"]?.ToString(),
                                FechaNacimiento = reader["fecha_nacimiento"]?.ToString()
                            }
                        };
                        horasExtras.Add(horaExtra);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener las horas extras: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cerrar la conexión
            }

            return horasExtras;
        }


        // Método para insertar horas extra
        public int InsertHorasExtra(Horas_Extras_E horaExtra)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "sp_InsertarHorasExtra";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Solo enviar los parámetros necesarios para este SP
                sqlHelper.Command.Parameters.AddWithValue("@fecha_registro", horaExtra.fecha_registro);
                sqlHelper.Command.Parameters.AddWithValue("@hora_registro", horaExtra.hora_registro);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", horaExtra.id_usuario);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return Convert.ToInt32(reader["ID_HoraExtra"]); // Obtenemos el ID del registro insertado
                    }
                    else
                    {
                        throw new Exception("No se pudo obtener el ID de la hora extra insertada.");
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar las horas extras: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }


        public Horas_Extras_E ObtenerHoraExtraPorId(int idHoraExtra)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_ObtenerHoraExtraPorId";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();
                sqlHelper.Command.Parameters.AddWithValue("@id_horaExtra", idHoraExtra);

                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return new Horas_Extras_E
                        {
                            id_horaExtra = Convert.ToInt32(reader["id_horaExtra"]),
                            folio_registro = reader["folio_registro"]?.ToString(),
                            fecha_registro = reader["fecha_registro"]?.ToString(),
                            hora_registro = reader["hora_registro"]?.ToString(),
                            id_empleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : (int?)null,
                            id_responsable = reader["id_responsable"] != DBNull.Value ? Convert.ToInt32(reader["id_responsable"]) : (int?)null,
                            fecha_compensacion = reader["fecha_compensacion"]?.ToString(),
                            costo_horaExtra = reader["costo_horaExtra"] != DBNull.Value ? Convert.ToSingle(reader["costo_horaExtra"]) : (float?)null,
                            costo_horaDoble = reader["costo_horaDoble"] != DBNull.Value ? Convert.ToSingle(reader["costo_horaDoble"]) : (float?)null,
                            horas_porPagar = reader["horas_porPagar"] != DBNull.Value ? Convert.ToInt32(reader["horas_porPagar"]) : (int?)null,
                            costo_horaTriple = reader["costo_horaTriple"] != DBNull.Value ? Convert.ToSingle(reader["costo_horaTriple"]) : (float?)null,
                            hora_triple = reader["hora_triple"] != DBNull.Value ? Convert.ToInt32(reader["hora_triple"]) : (int?)null,
                            total_horaDoble = reader["total_horaDoble"] != DBNull.Value ? Convert.ToSingle(reader["total_horaDoble"]) : (float?)null,
                            total_horaTriple = reader["total_horaTriple"] != DBNull.Value ? Convert.ToSingle(reader["total_horaTriple"]) : (float?)null,
                            total_aPagar = reader["total_aPagar"] != DBNull.Value ? Convert.ToSingle(reader["total_aPagar"]) : (float?)null,
                            motivo_hraExtra = reader["motivo_hraExtra"]?.ToString(),
                            observaciones = reader["observaciones"]?.ToString(),
                            id_usuario = reader["id_usuario"] != DBNull.Value ? Convert.ToInt32(reader["id_usuario"]) : (int?)null,
                            ID_Estatus = reader["ID_Estatus"] != DBNull.Value ? Convert.ToInt32(reader["ID_Estatus"]) : (int?)null,
                            empleado = new Empleados_E
                            {
                                Nombre = reader["NombreEmpleado"]?.ToString(),
                                ApellidoPaterno = reader["ApellidoPaternoEmpleado"]?.ToString(),
                                ApellidoMaterno = reader["ApellidoMaternoEmpleado"]?.ToString()
                            }
                        };
                    }
                    else
                    {
                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la hora extra: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }

        public bool ActualizarHorasExtraConEvidencias(Horas_Extras_E horaExtra, string evidencia1, string evidencia2)
        {
            try
            {
                sqlHelper.OpenConnection();

                sqlHelper.Command.CommandText = "SP_Actualizar_HorasExtra";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Parámetros
                sqlHelper.Command.Parameters.AddWithValue("@id_horaExtra", horaExtra.id_horaExtra);
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", horaExtra.id_empleado);
                sqlHelper.Command.Parameters.AddWithValue("@id_responsable", horaExtra.id_responsable);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_compensacion", horaExtra.fecha_compensacion);
                sqlHelper.Command.Parameters.AddWithValue("@horas_porPagar", horaExtra.horas_porPagar);
                sqlHelper.Command.Parameters.AddWithValue("@motivo_hraExtra", horaExtra.motivo_hraExtra);
                sqlHelper.Command.Parameters.AddWithValue("@observaciones", horaExtra.observaciones ?? (object)DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", horaExtra.id_usuario);
                sqlHelper.Command.Parameters.AddWithValue("@Evidencia1", (object)evidencia1 ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@Evidencia2", (object)evidencia2 ?? DBNull.Value);

                int rowsAffected = sqlHelper.Command.ExecuteNonQuery();

                return rowsAffected > 0; // Retorna true si se actualizó al menos una fila
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar la hora extra con evidencias: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection();
            }
        }
        public int Delete(int id)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "SP_Delete_HORAS_EXTRAS";
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
