using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class IncidenciasViewModel
    {
        public List<Empleados_E> List_Empleados { get; set; }
        public List<TiposIncidencias_E> List_Incidencias { get; set; }
        public List<Sanciones_E> List_Sanciones { get; set; }
        public string Img_empleado_nombre { get; set; }
        public string Ubicacion { get; set; }
        public Incidencia_E IncidenciaModel { get; set; }

    }
}