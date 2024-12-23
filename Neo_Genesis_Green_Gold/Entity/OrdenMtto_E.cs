using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class OrdenMtto_E
    {
        public int IdOrden { get; set; }
        public int IdSolicitud { get; set; }
        public string FolioOrden { get; set; }
        public string FechaRegistro { get; set; }
        public string HoraRegistro { get; set; }
        public string TipoServicio { get; set; }
        public int IdEmpleado { get; set; }
        public string AtendidoExterno { get; set; }
        public string DiagnosticoFalla { get; set; }
        public string Observaciones { get; set; }
        public string Refacciones { get; set; }
        public string FolioAlmacen { get; set; }
        public string FolioCompras { get; set; }
        public string FallaCorregida { get; set; }
        public string TiempoInvertido { get; set; }
        public string ImgSolucion { get; set; }
        public string ImgSolucion2 { get; set; }
        public string ImgSolucion3 { get; set; }
        public string ImgSolucion4 { get; set; }
    }

}
