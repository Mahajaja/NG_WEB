using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class CierreOrden_E
    {
        public int IdCierreOrden { get; set; }
        public string FolioOrden { get; set; }
        public string FechaRegistro { get; set; }
        public string HoraRegistro { get; set; }
        public int? IdOrden { get; set; }
        public int? IdUsuario { get; set; }
        public string HerramientasTrabajo { get; set; }
        public string TiempoReparacion { get; set; }
        public string ReparacionRealizada { get; set; }
        public string OtraFalla { get; set; }
        public string EspecificacionFalla { get; set; }
        public string AreaReparacion { get; set; }
        public string MedidasSeguridad { get; set; }
        public string AreaLimpia { get; set; }
        public string CalidadTrabajo { get; set; }
        public string EspecificarCalidad { get; set; }
        public string SobranteMaterial { get; set; }
        public string EntradaAlmacen { get; set; }
        public string Observaciones { get; set; }
        public string Responsable { get; set; }
        public string Folio_orden { get; set; }
        public string tipo_servicio { get; set; }
    }

}
