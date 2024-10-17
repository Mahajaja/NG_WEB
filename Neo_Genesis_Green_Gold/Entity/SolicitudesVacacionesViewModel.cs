using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Entity
{
    public class SolicitudesVacacionesViewModel
    {
        public int id_vacacion {  get; set; }
        public string Nombre { get; set; }
        public string FechaInicio { get; set; }
        public string FechaIncorporacion { get; set; }
        public int DiasSolicitados { get; set; }
        public string Estatus { get; set; }
        
    }
}