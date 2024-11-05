using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class PrestamosViewModel
    {
        public Prestamo_E PrestamoModel { get; set; }
        public string Img_empleado_nombre { get; set; }
        public List<Empleados_E> List_Empleados { get; set; }
        public string Ubicacion { get; set; }
    }
}