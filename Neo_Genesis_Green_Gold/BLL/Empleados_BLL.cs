using DAL;
using Entity;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class Empleados_BLL
    {
        private Empleados_DAL _empleadoDal = new Empleados_DAL();
        public Empleados_E GetEmpleadoById(int idEmpleado)
        {
            return _empleadoDal.GetEmpleadoById(idEmpleado);
        }

        public List<Empleados_E> GetEmpleadosByUbicacion(int idUbicacion)
        {
            return _empleadoDal.GetEmpleadosByUbicacion(idUbicacion);
        }
    }
}
