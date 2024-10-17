using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class Horas_Extra_ViewModel
    {
        public string Img_empleado_nombre { get; set; }
        public List<Empleados_E> List_Empleados { get; set; }
        public string Ubicacion { get; set; }
        public string FechaCompensacion {  get; set; }
        public int HorasExtra {  get; set; }
        public string Evidencia1 { get; set; }
        public string Evidencia2 { get; set; }
        public string Motivo {  get; set; }
        public string Observaciones { get; set; }
    }
}