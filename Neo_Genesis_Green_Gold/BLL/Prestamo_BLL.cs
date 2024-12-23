using DAL;
using Entity;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class Prestamo_BLL
    {
        private Prestamo_DAL _prestamoDal = new Prestamo_DAL();

        // Método para obtener todos los préstamos
        public List<Prestamo_E> GetAllPrestamos(int id)
        {
            return _prestamoDal.GetAllPrestamos(id);
        }

        public int InsertarPrestamo(Prestamo_E prestamoE)
        {
            return _prestamoDal.InsertPrestamo(prestamoE);
        }

        /// <summary>
        /// Actualiza un préstamo en la base de datos.
        /// </summary>
        /// <param name="prestamoE">Objeto Prestamo_E con la información a actualizar.</param>
        /// <returns>Verdadero si la actualización fue exitosa, falso si no lo fue.</returns>
        public bool ActualizarPrestamo(Prestamo_E prestamoE)
        {
            // Validar los datos antes de enviarlos al DAL
            if (prestamoE == null)
            {
                throw new ArgumentNullException(nameof(prestamoE), "El préstamo no puede ser nulo.");
            }

            if (prestamoE.IdPrestamo <= 0)
            {
                throw new ArgumentException("El ID del préstamo no es válido.");
            }

            // Realizar validaciones adicionales si son necesarias
            if (!string.IsNullOrEmpty(prestamoE.CantidadAutorizada) && !decimal.TryParse(prestamoE.CantidadAutorizada, out _))
            {
                throw new ArgumentException("La cantidad autorizada no es un número válido.");
            }

            if (!string.IsNullOrEmpty(prestamoE.FechaEntrega) && prestamoE.FechaEntrega.Length != 10)
            {
                throw new ArgumentException("La fecha de entrega no tiene el formato correcto (AAAA-MM-DD).");
            }

            // Llamar al método del DAL para realizar la actualización
            try
            {
                return _prestamoDal.ActualizarPrestamo(prestamoE);
            }
            catch (Exception ex)
            {
                throw new Exception("Error en la capa de lógica de negocios al actualizar el préstamo: " + ex.Message);
            }
        }

        public Prestamo_E GetPrestamoById(int idPrestamo)
        {
            return _prestamoDal.GetPrestamoById(idPrestamo);
        }
        public int Delete(int id)
        {
            return _prestamoDal.Delete(id);
        }
    }
}
