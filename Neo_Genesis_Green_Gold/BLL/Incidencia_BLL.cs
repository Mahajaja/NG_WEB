using DAL;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class Incidencia_BLL
    {
        Incidencia_DAL _incidencia = new Incidencia_DAL();
        public List<Incidencia_E> GetAllIncidencias(int id)
        {
            return _incidencia.GetAllIncidencias(id);
        }

        public int CrearIncidencia(Incidencia_E incidencia)
        {
            // Validación básica de null
            if (incidencia == null)
            {
                throw new ArgumentNullException(nameof(incidencia), "La incidencia no puede ser nula.");
            }

            // Validación de propiedades obligatorias
            if (string.IsNullOrEmpty(incidencia.fecha_registro))
            {
                throw new ArgumentException("La fecha de registro es obligatoria.", nameof(incidencia.fecha_registro));
            }

            if (string.IsNullOrEmpty(incidencia.hora_registro))
            {
                throw new ArgumentException("La hora de registro es obligatoria.", nameof(incidencia.hora_registro));
            }

            if (incidencia.id_usuario <= 0)
            {
                throw new ArgumentException("El ID del usuario debe ser un valor válido.", nameof(incidencia.id_usuario));
            }

            // Si todas las validaciones pasan, llama a la capa DAL
            return _incidencia.InsertIncidencia(incidencia);
        }

        public Incidencia_E ObtenerIncidenciaPorId(int idIncidencia)
        {
            if (idIncidencia <= 0)
            {
                throw new ArgumentException("El ID de la incidencia debe ser un valor positivo.", nameof(idIncidencia));
            }

            try
            {
                return _incidencia.ObtenerIncidenciaPorId(idIncidencia);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener la incidencia en la capa de negocio: " + ex.Message);
            }
        }

        public bool ActualizarIncidencia(Incidencia_E incidencia)
        {
            if (incidencia == null)
            {
                throw new ArgumentNullException(nameof(incidencia), "La incidencia no puede ser nula.");
            }

            if (incidencia.id_incidencia <= 0)
            {
                throw new ArgumentException("El ID de la incidencia debe ser un valor válido.", nameof(incidencia.id_incidencia));
            }

            if (incidencia.id_usuario <= 0)
            {
                throw new ArgumentException("El ID del usuario debe ser un valor válido.", nameof(incidencia.id_usuario));
            }

            try
            {
                return _incidencia.ActualizarIncidencia(incidencia);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar la incidencia en la capa de negocio: " + ex.Message);
            }
        }

        public int Delete(int id)
        {
            return _incidencia.Delete(id);
        }
    }
}
