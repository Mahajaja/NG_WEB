using System.Collections.Generic;
using DAL;
using Entity;

namespace BLL
{
    public class Ubicaciones_X_Empleado_BLL
    {
        private Ubicaciones_X_Empleado_DAL _ubicacionesXEmpleadoDAL;

        public Ubicaciones_X_Empleado_BLL()
        {
            _ubicacionesXEmpleadoDAL = new Ubicaciones_X_Empleado_DAL();
        }

        // Método para obtener las ubicaciones asignadas a un empleado
        public List<Ubicaciones_X_Empleado_E> ObtenerUbicacionesPorEmpleado(int idEmpleado)
        {
            return _ubicacionesXEmpleadoDAL.ObtenerUbicacionesPorEmpleado(idEmpleado);
        }

        public int InsertarUbicacionXEmpleado(int idUbicacion, int idEmpleado)
        {
            return _ubicacionesXEmpleadoDAL.InsertarUbicacionXEmpleado(idUbicacion, idEmpleado);
        }

        public void BorrarUbicacionesPorEmpleado(int idEmpleado)
        {
            _ubicacionesXEmpleadoDAL.BorrarUbicacionesPorEmpleado(idEmpleado);
        }


    }
}
