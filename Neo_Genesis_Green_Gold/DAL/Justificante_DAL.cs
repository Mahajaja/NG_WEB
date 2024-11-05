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

        // Método para insertar un justificante
        public bool InsertJustificante(Justificante_E justificante)
        {
            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_Insertar_Justificante";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Añade los parámetros necesarios para el procedimiento almacenado
                sqlHelper.Command.Parameters.AddWithValue("@id_ubicacion", justificante.IdUbicacion);
                sqlHelper.Command.Parameters.AddWithValue("@id_empleado", justificante.IdEmpleado);
                sqlHelper.Command.Parameters.AddWithValue("@naturaleza_permiso", justificante.NaturalezaPermiso);
                sqlHelper.Command.Parameters.AddWithValue("@especificacion_permiso", justificante.EspecificacionPermiso);
                sqlHelper.Command.Parameters.AddWithValue("@permiso_solicitado", justificante.PermisoSolicitado);
                sqlHelper.Command.Parameters.AddWithValue("@otro_permiso", justificante.OtroPermiso);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_falta", justificante.FechaFalta);
                sqlHelper.Command.Parameters.AddWithValue("@horas_parcial", justificante.HorasParcial);
                sqlHelper.Command.Parameters.AddWithValue("@pago_horas", justificante.PagoHoras);
                sqlHelper.Command.Parameters.AddWithValue("@observacion", justificante.Observacion);
                sqlHelper.Command.Parameters.AddWithValue("@sueldos", justificante.Sueldos);
                sqlHelper.Command.Parameters.AddWithValue("@id_usuario", justificante.IdUsuario);
                sqlHelper.Command.Parameters.AddWithValue("@fecha_fin", justificante.FechaFin);
                sqlHelper.Command.Parameters.AddWithValue("@institucion", justificante.Institucion);
                sqlHelper.Command.Parameters.AddWithValue("@otra_institucion", justificante.OtraInstitucion);

                // Ejecuta el comando
                int rowsAffected = sqlHelper.Command.ExecuteNonQuery();

                // Retorna true si se insertó al menos una fila
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar el justificante: " + ex.Message);
            }
            finally
            {
                sqlHelper.CloseConnection(); // Cierra la conexión
            }
        }

        // Método para obtener todos los justificantes
        public List<Justificante_E> GetAllJustificantes()
        {
            List<Justificante_E> justificantes = new List<Justificante_E>();

            try
            {
                sqlHelper.OpenConnection(); // Abre la conexión

                // Configura el comando para ejecutar el procedimiento almacenado
                sqlHelper.Command.CommandText = "SP_ObtenerJustificantes";
                sqlHelper.Command.CommandType = CommandType.StoredProcedure;
                sqlHelper.Command.Parameters.Clear();

                // Ejecutar y leer los datos
                using (SqlDataReader reader = sqlHelper.Command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Justificante_E justificante = new Justificante_E
                        {
                            IdJustificante = Convert.ToInt32(reader["id_justificante"]),
                            FechaRegistro = reader["fecha_registro"].ToString(),
                            Observacion = reader["observacion"].ToString(),
                            Puesto = reader["Puesto"].ToString(),
                            Estatus = reader["Estatus"].ToString(),
                            Empleado = new Empleados_E
                            {
                                IdEmpleado = Convert.ToInt32(reader["id_empleado"]),
                                Nombre = reader["nombre"].ToString(),
                                ApellidoPaterno = reader["apellido_paterno"].ToString(),
                                ApellidoMaterno = reader["apellido_materno"].ToString(),
                                FechaNacimiento = reader["fecha_nacimiento"].ToString()
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
    }
}
