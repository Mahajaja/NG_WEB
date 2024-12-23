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

        public int InsertarSolicitudMtto(SolicitudMtto_E solicitud)
        {
            return _solicitudMttoDAL.InsertarSolicitudMtto(solicitud);
        }

        // Método para obtener todas las solicitudes de mantenimiento
        public List<SolicitudMtto_E> ObtenerTodasLasSolicitudesMtto()
        {
            return _solicitudMttoDAL.GetAllSolicitudesMtto();
        }

        public SolicitudMtto_E ObtenerSolicitudMttoPorId(int idSolicitud)
        {
            return _solicitudMttoDAL.ObtenerSolicitudMttoPorId(idSolicitud);
        }

        public string EliminarSolicitudMtto(int idSolicitud)
        {
            return _solicitudMttoDAL.EliminarSolicitudMtto(idSolicitud);
        }

        public string ActualizarSolicitudMtto(
    SolicitudMtto_E solicitud,
    string nombreArchivo1,
     string nombreArchivo2,
     string nombreArchivo3,
     string nombreArchivo4)
        {
            return _solicitudMttoDAL.ActualizarSolicitudMtto(
                solicitud,
                nombreArchivo1,
                nombreArchivo2,
                nombreArchivo3,
                 nombreArchivo4
            );
        }

        public int InsertarCierreOrden(int idOrden, int idUsuario)
        {
            return _solicitudMttoDAL.InsertarCierreOrden(idOrden, idUsuario);
        }

        public string EliminarCierreOrden(int idCierre)
        {
            return _solicitudMttoDAL.EliminarCierreOrden(idCierre);
        }

        public CierreOrden_E ObtenerCierreOrdenPorId(int idCierreOrden)
        {
            return _solicitudMttoDAL.ObtenerCierreOrdenPorId(idCierreOrden);
        }

        public string ActualizarCierreOrden(CierreOrden_E cierreOrden)
        {
            return _solicitudMttoDAL.ActualizarCierreOrden(cierreOrden);
        }

    }
}
