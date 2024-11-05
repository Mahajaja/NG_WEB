using DAL;
using Entity;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class Sanciones_BLL
    {
        private Sanciones_DAL _sancionesDal = new Sanciones_DAL();

        // Método para obtener todas las sanciones
        public List<Sanciones_E> GetAllSanciones()
        {
            return _sancionesDal.GetAllSanciones();
        }

        // Método para obtener una sanción por ID
        public Sanciones_E GetSancionById(int id)
        {
            return _sancionesDal.GetSancionById(id);
        }
    }
}
