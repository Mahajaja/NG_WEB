using DAL;
using Entity;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class TiposIncidencias_BLL
    {
        private TiposIncidencias_DAL _tiposIncidenciasDal = new TiposIncidencias_DAL();

        // Método para obtener todas las tipos de incidencias
        public List<TiposIncidencias_E> GetAllTiposIncidencias()
        {
            return _tiposIncidenciasDal.GetAllTiposIncidencias();
        }

        // Método para obtener un tipo de incidencia por ID
        public TiposIncidencias_E GetTiposIncidenciaById(int id)
        {
            return _tiposIncidenciasDal.GetTiposIncidenciaById(id);
        }
    }
}
