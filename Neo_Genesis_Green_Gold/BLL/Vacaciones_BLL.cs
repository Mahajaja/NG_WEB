using Entity;
using System;
using System.Collections.Generic;
using DAL;
public class Vacaciones_BLL
{
    private Vacaciones_DAL _vacacionesDal = new Vacaciones_DAL();

    public int CrearVacacion(Vacaciones_E vacacion)
    {
        // Validación básica de null
        if (vacacion == null)
        {
            throw new ArgumentNullException(nameof(vacacion), "La vacación no puede ser nula.");
        }

        // Validación de propiedades obligatorias
        if (string.IsNullOrEmpty(vacacion.fecha_registro))
        {
            throw new ArgumentException("La fecha de registro es obligatoria.", nameof(vacacion.fecha_registro));
        }

        if (string.IsNullOrEmpty(vacacion.hora_registro))
        {
            throw new ArgumentException("La hora de registro es obligatoria.", nameof(vacacion.hora_registro));
        }

        if (vacacion.id_usuario <= 0)
        {
            throw new ArgumentException("El ID del usuario debe ser un valor válido.", nameof(vacacion.id_usuario));
        }

        // Si todas las validaciones pasan, llama a la capa DAL
        return _vacacionesDal.InsertVacacion(vacacion);
    }


    public Vacaciones_E ObtenerVacacionPorId(int idVacacion)
    {
        if (idVacacion <= 0)
        {
            throw new ArgumentException("El ID de vacación no es válido.");
        }

        var vacacion = _vacacionesDal.GetVacacionById(idVacacion);
        if (vacacion == null)
        {
            throw new KeyNotFoundException("La vacación no se encontró.");
        }

        return vacacion;
    }

    public List<Vacaciones_E> ObtenerTodasLasVacaciones()
    {
        // En este método podrías agregar lógica adicional para filtrar o procesar la información si es necesario
        return _vacacionesDal.GetAllVacaciones();
    }

    // Método para actualizar una vacación desde la capa BLL
    public void UpdateVacacion(Vacaciones_E vacacion)
    {
        if (vacacion == null)
        {
            throw new ArgumentNullException(nameof(vacacion), "La vacación no puede ser nula.");
        }

        if (vacacion.id_vacacion <= 0)
        {
            throw new ArgumentException("El ID de la vacación debe ser mayor a 0.", nameof(vacacion.id_vacacion));
        }

        try
        {
            int filasAfectadas = _vacacionesDal.UpdateVacacion(vacacion);

            if (filasAfectadas == 0)
            {
                throw new Exception("No se encontró el registro para actualizar.");
            }
        }
        catch (Exception ex)
        {
            throw new Exception("Error al actualizar la vacación en la capa BLL: " + ex.Message);
        }
    }

    //public int EliminarVacacion(int idVacacion)
    //{
    //    if (idVacacion <= 0)
    //    {
    //        throw new ArgumentException("El ID de vacación no es válido.");
    //    }

    //    return _vacacionesDal.DeleteVacacion(idVacacion);
    //}
    public List<SolicitudesVacacionesViewModel> GetVacacionesConFormato()
    { return _vacacionesDal.GetVacacionesConFormato(); }
}
