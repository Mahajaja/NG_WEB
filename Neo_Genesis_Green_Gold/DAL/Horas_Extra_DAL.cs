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

        // Método para obtener todas las horas extras
        public List<Horas_Extras_E> GetAllHorasExtra()
        {
            List<Horas_Extras_E> horasExtras = new List<Horas_Extras_E>();
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ObtenerHorasExtras";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Horas_Extras_E horaExtra = new Horas_Extras_E
                        {
                            id_horaExtra = Convert.ToInt32(reader["id_horaExtra"]),
                            folio_registro = reader["folio_registro"].ToString(),
                            fecha_registro = reader["fecha_registro"].ToString(),
                            hora_registro = reader["hora_registro"].ToString(),
                            id_empleado = Convert.ToInt32(reader["id_empleado"]),
                            id_responsable = Convert.ToInt32(reader["id_responsable"]),
                            fecha_compensacion = reader["fecha_compensacion"].ToString(),
                            costo_horaExtra = Convert.ToSingle(reader["costo_horaExtra"]),
                            costo_horaDoble = Convert.ToSingle(reader["costo_horaDoble"]),
                            horas_porPagar = Convert.ToInt32(reader["horas_porPagar"]),
                            
                            hora_triple = Convert.ToInt32(reader["hora_triple"]),
                            total_horaDoble = Convert.ToSingle(reader["total_horaDoble"]),
                            total_horaTriple = Convert.ToSingle(reader["total_horaTriple"]),
                            total_aPagar = Convert.ToSingle(reader["total_aPagar"]),
                            motivo_hraExtra = reader["motivo_hraExtra"].ToString(),
                            observaciones = reader["observaciones"].ToString(),
                            id_usuario = Convert.ToInt32(reader["id_usuario"]),
                            empleado = new Empleados_E
                            {
                                IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                                Nombre = reader["Nombre"].ToString(),
                                ApellidoPaterno = reader["apellido_paterno"].ToString(),
                                ApellidoMaterno = reader["apellido_materno"].ToString(),
                                FechaNacimiento = reader["fecha_nacimiento"].ToString()
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

        public int InsertHorasExtra(Horas_Extras_E horaExtra, string evidencia1, string evidencia2)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_Insertar_HorasExtra";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añadir los parámetros necesarios para el SP
                sqlHelper.Command.Parameters.AddWithValue("@IDEMPLEADO", horaExtra.id_empleado);
                sqlHelper.Command.Parameters.AddWithValue("@IDRESPONSABLE", horaExtra.id_responsable);
                sqlHelper.Command.Parameters.AddWithValue("@FechaCompensacion", horaExtra.fecha_compensacion);
                sqlHelper.Command.Parameters.AddWithValue("@HorasPorPagar", horaExtra.horas_porPagar);
                sqlHelper.Command.Parameters.AddWithValue("@MotivoHorasExtra", horaExtra.motivo_hraExtra);
                sqlHelper.Command.Parameters.AddWithValue("@Observaciones", horaExtra.observaciones);
                sqlHelper.Command.Parameters.AddWithValue("@IDUSUARIO", horaExtra.id_usuario);
                sqlHelper.Command.Parameters.AddWithValue("@Evidencia1", evidencia1);
                sqlHelper.Command.Parameters.AddWithValue("@Evidencia2", evidencia2);

                // Ejecuta el comando
                return sqlHelper.Command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar las horas extras: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }
        }


    }
}
