using System;
using System.Collections.Generic;
using DAL;
using Entity;

namespace BLL
{
    public class Instalacion_BLL
    {
        private readonly Instalacion_DAL _instalacionDAL;

        public Instalacion_BLL()
        {
            _instalacionDAL = new Instalacion_DAL();
        }

        public List<Instalacion_E> ObtenerInstalacionesPorUbicacion(int idUbicacion)
        {
            if (idUbicacion <= 0)
                throw new ArgumentException("El ID de la ubicación debe ser mayor a 0.", nameof(idUbicacion));

            return _instalacionDAL.ObtenerInstalacionesPorUbicacion(idUbicacion);
        }

        public Instalacion_E ObtenerInstalacionPorId(int idInstalacion)
        {
            return _instalacionDAL.ObtenerInstalacionPorId(idInstalacion);
        }
    }
}
