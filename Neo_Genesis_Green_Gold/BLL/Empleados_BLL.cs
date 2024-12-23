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
        public List<Empleados_E> ObtenerEmpleadosSolicitudMantenimiento(int idUbicacion)
        {
            return _empleadoDal.ObtenerEmpleadosSolicitudMantenimiento(idUbicacion);
        }
        public List<Empleados_E> GetEmpleadosByDepartamento()
        {
            return _empleadoDal.GetEmpleadosByDepartamento();
        }
        public List<Empleados_E> ObtenerEmpleadosPorUbicacion(int idUbicacion)
        {
            return _empleadoDal.ObtenerEmpleadosPorUbicacion(idUbicacion);
        }

        public List<Empleados_E> ObtenerTodosLosEmpleados()
        {
            return _empleadoDal.ObtenerTodosLosEmpleados();
        }

        public List<Empleados_E> ObtenerMisEmpleadosPorUbicacion(int idEmpleado)
        {
            return _empleadoDal.ObtenerMisEmpleadosPorUbicacion(idEmpleado);
        }

    }
}
