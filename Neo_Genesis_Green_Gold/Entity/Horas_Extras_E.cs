using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Horas_Extras_E
    {
        public int id_horaExtra { get; set; }
        public string folio_registro { get; set; }
        public string fecha_registro { get; set; }
        public string hora_registro { get; set; }
        public int id_empleado { get; set; }
        public int id_responsable { get; set; }
        public string fecha_compensacion { get; set; }
        public float costo_horaExtra { get; set; }
        public float costo_horaDoble { get; set; }
        public int horas_porPagar { get; set; }
        public float costo_horaTriple { get; set; }
        public int hora_triple { get; set; }
        public float total_horaDoble { get; set; }
        public float total_horaTriple { get; set; }
        public float total_aPagar { get; set; }
        public string motivo_hraExtra { get; set; }
        public string observaciones { get; set; }
        public string img_hraExtra { get; set; }
        public int id_usuario { get; set; }
        public int ID_Estatus { get; set; }
        public virtual Empleados_E empleado { get; set; }
    }

}
