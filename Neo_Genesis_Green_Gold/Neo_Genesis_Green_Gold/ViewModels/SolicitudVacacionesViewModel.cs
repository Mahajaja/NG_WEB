using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class SolicitudVacacionesViewModel
    {
        public string Img_empleado_nombre { get; set; }
        public int DiasDisponibles { get; set; }
        public string Ubicacion { get; set; }
        public int DiasTomar {  get; set; }
        public string FechaIncorporacion { get; set; }
        public int DiasRestantes { get; set; }
        public string Folio { get; set; }
        public List<Empleados_E> List_Empleados { get; set; }
        public Vacaciones_E Vacacion { get; set; }
        public List<Ubicacion_E> List_Ubicaciones { get; set; }
        public bool MostrarUbicaciones { get; set; }
    }
}