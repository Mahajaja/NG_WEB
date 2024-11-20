using DAL;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class Ubicacion_BLL
    {
        private Ubicacion_DAL ubicacionDal = new Ubicacion_DAL();
        public Ubicacion_E GetUbicacionById(int idUbicacion)
        {
            return ubicacionDal.GetUbicacionById(idUbicacion);
        }
        public List<Ubicacion_E> GetAllUbicaciones(int id_empleado)
        {
            return ubicacionDal.GetAllUbicaciones(id_empleado);
        }
    }
}
