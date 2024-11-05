using DAL;
using Entity;
using System.Collections.Generic;

namespace BLL
{
    public class Prestamo_BLL
    {
        private Prestamo_DAL _prestamoDal = new Prestamo_DAL();

        // Método para obtener todos los préstamos
        public List<Prestamo_E> GetAllPrestamos()
        {
            return _prestamoDal.GetAllPrestamos();
        }

        public bool InsertarPrestamo(int idUbicacion, int idEmpleado, string cantidadAutorizada, string fechaEntrega, string motivo, int idUsuario)
        {
            return _prestamoDal.InsertarPrestamo(idUbicacion, idEmpleado, cantidadAutorizada, fechaEntrega, motivo, idUsuario);
        }
    }
}
