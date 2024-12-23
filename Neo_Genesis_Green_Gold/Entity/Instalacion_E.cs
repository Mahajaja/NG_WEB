using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Instalacion_E
    {
        public int IdInstalacion { get; set; }
        public string FolioInstalacion { get; set; }
        public string FechaRegistro { get; set; }
        public string HoraRegistro { get; set; }
        public int IdUbicacion { get; set; }
        public int IdAlmacen { get; set; }
        public string Nombre { get; set; }
        public string Uso { get; set; }
        public int IdUsuario { get; set; }
        public string Descripcion { get; set; }
    }
}
