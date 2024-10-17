using System;
using System.Collections.Generic;

namespace Entity
{
    public class Incidencia_E
    {
        public int id_incidencia { get; set; }
        public string folio_incidencia { get; set; }
        public string hora_registro { get; set; }
        public string fecha_registro { get; set; }
        public int id_ubicacion { get; set; }
        public int id_empleado { get; set; }
        public string tipo_registro { get; set; }
        public string tipo_incidencia { get; set; }
        public string tiempo_sancion { get; set; }
        public string descuento_dia { get; set; }
        public string dia { get; set; }
        public string fecha_inicio { get; set; }
        public string descripcion { get; set; }
        public string goze { get; set; }
        public string horas { get; set; }
        public int id_usuario { get; set; }

        // Relación con la entidad Empleados_E
        public virtual Empleados_E empleado { get; set; }
    }
}
