using Entity;
using System;
using System.Collections.Generic;
using DAL;
public class Vacaciones_BLL
{
    private Vacaciones_DAL _vacacionesDal = new Vacaciones_DAL();

    public int CrearVacacion(Vacaciones_E vacacion)
    {
        // Aquí puedes agregar validaciones de negocio antes de insertar en la base de datos
        if (vacacion == null)
        {
            throw new ArgumentNullException(nameof(vacacion), "La vacación no puede ser nula.");
        }

        if (vacacion.DiasVacacion <= 0)
        {
            throw new ArgumentException("Los días de vacación deben ser mayores que cero.");
        }

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

    public int ActualizarVacacion(Vacaciones_E vacacion)
    {
        if (vacacion == null)
        {
            throw new ArgumentNullException(nameof(vacacion), "La vacación no puede ser nula.");
        }

        if (vacacion.IdVacacion <= 0)
        {
            throw new ArgumentException("El ID de la vacación no es válido.");
        }

        if (vacacion.DiasVacacion <= 0)
        {
            throw new ArgumentException("Los días de vacación deben ser mayores que cero.");
        }

        return _vacacionesDal.UpdateVacacion(vacacion);
    }

    public int EliminarVacacion(int idVacacion)
    {
        if (idVacacion <= 0)
        {
            throw new ArgumentException("El ID de vacación no es válido.");
        }

        return _vacacionesDal.DeleteVacacion(idVacacion);
    }
}
