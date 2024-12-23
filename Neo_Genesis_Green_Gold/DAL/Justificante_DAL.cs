using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Entity;

namespace DAL
{
    public class Justificante_DAL
    {
        private SqlHelper sqlHelper;

        public Justificante_DAL()
        {
            sqlHelper = new SqlHelper();
        }

        public int InsertarJustificante(int idUsuario)
        {
            int idJustificante = 0; // Variable para almacenar el ID generado

            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_Insertar_Justificante";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añadir parámetros al comando
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", idUsuario);

                // Parámetro de salida para capturar el ID generado
                SqlParameter outputId = new SqlParameter("@id_justificante", SqlDbType.Int)
                {
                    Direction = ParameterDirection.Output
                };
                sqlHelper.Command.Parameters.Add(outputId);

                // Ejecutar el comando
                sqlHelper.Command.ExecuteNonQuery();

                // Obtener el ID generado
                idJustificante = Convert.ToInt32(outputId.Value);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar el justificante: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }

            return idJustificante; // Retornar el ID generado
        }


        // Método para obtener todos los justificantes
        public List<Justificante_E> GetAllJustificantes(int idEmpleado)
        {
            List<Justificante_E> justificantes = new List<Justificante_E>();

            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ObtenerJustificantes";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agregar el parámetro @id_empleado
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", idEmpleado);

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Justificante_E justificante = new Justificante_E
                        {
                            IdJustificante = reader["id_justificante"] != DBNull.Value ? Convert.ToInt32(reader["id_justificante"]) : 0,
                            FechaRegistro = reader["fecha_registro"]?.ToString(),
                            Observacion = reader["observacion"]?.ToString(),
                            Puesto = reader["Puesto"]?.ToString(),
                            Estatus = reader["Estatus"]?.ToString(),
                            PermisoSolicitado = reader["Permiso_solicitado"]?.ToString(),
                            Empleado = new Empleados_E
                            {
                                Nombre = reader["nombre"]?.ToString(),
                                ApellidoPaterno = reader["apellido_paterno"]?.ToString(),
                                ApellidoMaterno = reader["apellido_materno"]?.ToString(),
                                FechaNacimiento = reader["fecha_nacimiento"]?.ToString()
                            }
                        };
                        justificantes.Add(justificante);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener los justificantes: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }

            return justificantes;
        }


        // Método para actualizar un justificante
        public bool ActualizarJustificante(Justificante_E justificante)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_Actualizar_Justificante";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añadir parámetros al comando
                sqlHelper.Command.Parameters.AddWithValue("@id_justificante", justificante.IdJustificante);
                sqlHelper.Command.Parameters.AddWithValue("@id_ubicacion", justificante.IdUbicacion);
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", justificante.IdEmpleado);
                sqlHelper.Command.Parameters.AddWithValue("@naturaleza_permiso", (object)justificante.NaturalezaPermiso ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@especificacion_permiso", (object)justificante.EspecificacionPermiso ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@permiso_solicitado", (object)justificante.PermisoSolicitado ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@otro_permiso", (object)justificante.OtroPermiso ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_falta", (object)justificante.FechaFalta ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@horas_parcial", (object)justificante.HorasParcial ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@pago_horas", (object)justificante.PagoHoras ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@observacion", (object)justificante.Observacion ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@sueldos", (object)justificante.Sueldos ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", justificante.IdUsuario);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_fin", (object)justificante.FechaFin ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@institucion", (object)justificante.Institucion ?? DBNull.Value);
                sqlHelper.Command.Parameters.AddWithValue("@otra_institucion", (object)justificante.OtraInstitucion ?? DBNull.Value);

                // Ejecutar el comando
                sqlHelper.Command.ExecuteNonQuery();

                return true; // Retorna true si la operación fue exitosa
            }
            catch (Exception ex)
            {
                // Log o manejo del error (opcional)
                Console.WriteLine("Error al actualizar el justificante: " + ex.Message);
                return false; // Retorna false si hubo un error
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }
        }

        public Justificante_E ObtenerJustificantePorId(int idJustificante)
        {
            Justificante_E justificante = null;

            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_Obtener_Justificante";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Agrega el parámetro del procedimiento
                sqlHelper.Command.Parameters.AddWithValue("@id_justificante", idJustificante);

                // Ejecutar el comando y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    if (reader.Read()) // Si existe un registro
                    {
                        justificante = new Justificante_E
                        {
                            IdJustificante = Convert.ToInt32(reader["id_justificante"]),
                            IdUbicacion = reader["id_ubicacion"] != DBNull.Value ? Convert.ToInt32(reader["id_ubicacion"]) : (int?)null,
                            IdEmpleado = reader["id_empleado"] != DBNull.Value ? Convert.ToInt32(reader["id_empleado"]) : (int?)null,
                            NaturalezaPermiso = reader["naturaleza_permiso"] != DBNull.Value ? reader["naturaleza_permiso"].ToString() : null,
                            EspecificacionPermiso = reader["especificacion_permiso"] != DBNull.Value ? reader["especificacion_permiso"].ToString() : null,
                            PermisoSolicitado = reader["permiso_solicitado"] != DBNull.Value ? reader["permiso_solicitado"].ToString() : null,
                            OtroPermiso = reader["otro_permiso"] != DBNull.Value ? reader["otro_permiso"].ToString() : null,
                            FechaFalta = reader["fecha_falta"] != DBNull.Value ? reader["fecha_falta"].ToString() : null,
                            HorasParcial = reader["horas_parcial"] != DBNull.Value ? reader["horas_parcial"].ToString() : null,
                            PagoHoras = reader["pago_horas"] != DBNull.Value ? reader["pago_horas"].ToString() : null,
                            Observacion = reader["observacion"] != DBNull.Value ? reader["observacion"].ToString() : null,
                            Sueldos = reader["sueldos"] != DBNull.Value ? reader["sueldos"].ToString() : null,
                            IdUsuario = reader["id_usuario"] != DBNull.Value ? Convert.ToInt32(reader["id_usuario"]) : (int?)null,
                            FechaFin = reader["fecha_fin"] != DBNull.Value ? reader["fecha_fin"].ToString() : null,
                            Institucion = reader["institucion"] != DBNull.Value ? reader["institucion"].ToString() : null,
                            OtraInstitucion = reader["otra_institucion"] != DBNull.Value ? reader["otra_institucion"].ToString() : null,
                            FolioRegistro = reader["folio_registro"] != DBNull.Value ? reader["folio_registro"].ToString() : null
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el justificante: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }

            return justificante;
        }

        public int Delete(int id)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                sqlHelper.Command.CommandText = "SP_Delete_JUSTIFICANTE";
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
