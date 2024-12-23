using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class Ubicaciones_x_Empleado_ViewModel
    {
        public int id_Empleado {  get; set; }   
        public List<Ubicacion_E> ListUbicaciones { get; set; } = new List<Ubicacion_E>();
        public List<Ubicaciones_X_Empleado_E> ListUbicacionesEmpleado { get; set; } = new List<Ubicaciones_X_Empleado_E>();
    }
}