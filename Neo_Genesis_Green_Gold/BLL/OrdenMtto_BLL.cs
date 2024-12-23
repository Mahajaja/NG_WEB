using DAL;
using Entity;

namespace BLL
{
    public class OrdenMtto_BLL
    {
        private OrdenMtto_DAL _ordenMttoDAL;

        public OrdenMtto_BLL()
        {
            _ordenMttoDAL = new OrdenMtto_DAL();
        }

        // Método para insertar una nueva orden de mantenimiento
        public int InsertarOrdenMtto(int idUsuario, int idSolicitud)
        {
            return _ordenMttoDAL.InsertarOrdenMtto(idUsuario, idSolicitud);
        }

        public string EliminarOrdenMtto(int idOrden)
        {
            return _ordenMttoDAL.EliminarOrdenMtto(idOrden);
        }
        // Método para obtener un registro de ORDEN_MTTO por id_orden
        public OrdenMtto_E ObtenerOrdenMttoPorId(int idOrden)
        {
            return _ordenMttoDAL.ObtenerOrdenMttoPorId(idOrden);
        }

        public string ActualizarOrdenMtto(OrdenMtto_E orden)
        {
            return _ordenMttoDAL.ActualizarOrdenMtto(orden);
        }

    }
}
