using System.Collections.Generic;
using DAL;
using Entity;

namespace BLL
{
    public class Maquinaria_BLL
    {
        private Maquinaria_DAL _maquinariaDAL;

        public Maquinaria_BLL()
        {
            _maquinariaDAL = new Maquinaria_DAL();
        }

        // Método para obtener toda la maquinaria
        public List<Maquinaria_E> ObtenerMaquinaria(int? idUbicacion = null, int? idCategoria = null)
        {
            return _maquinariaDAL.ObtenerMaquinaria(idUbicacion, idCategoria);
        }
    }
}
