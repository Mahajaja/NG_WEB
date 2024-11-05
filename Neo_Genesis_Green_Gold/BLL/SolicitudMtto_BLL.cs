using System.Collections.Generic;
using DAL;
using Entity;

namespace BLL
{
    public class SolicitudMtto_BLL
    {
        private SolicitudMtto_DAL _solicitudMttoDAL;

        public SolicitudMtto_BLL()
        {
            _solicitudMttoDAL = new SolicitudMtto_DAL();
        }

        // Método para obtener todas las solicitudes de mantenimiento
        public List<SolicitudMtto_E> ObtenerTodasLasSolicitudesMtto()
        {
            return _solicitudMttoDAL.GetAllSolicitudesMtto();
        }
    }
}
