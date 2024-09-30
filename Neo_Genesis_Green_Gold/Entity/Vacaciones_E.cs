using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Vacaciones_E
    {
        public int IdVacacion { get; set; }
        public string FolioRegistro { get; set; }
        public string FechaRegistro { get; set; }
        public string HoraRegistro { get; set; }
        public int IdUbicacion { get; set; }
        public int IdEmpleado { get; set; }
        public string FechaInicio { get; set; }
        public string FechaFin { get; set; }
        public int DiasVacacion { get; set; }
        public string FechaIncorporacion { get; set; }
        public int DiasRestantes { get; set; }
        public string Observaciones { get; set; }
        public int IdUsuario { get; set; }
    }
}
 