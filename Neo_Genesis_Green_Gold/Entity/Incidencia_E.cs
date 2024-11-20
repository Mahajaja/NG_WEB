using System;
using System.Collections.Generic;

namespace Entity
{
    public class Incidencia_E
    {
        public int id_incidencia { get; set; } // Este siempre debe tener un valor
        public string folio_incidencia { get; set; } // Nullable por la base de datos
        public string hora_registro { get; set; } // Nullable por la base de datos
        public string fecha_registro { get; set; } // Nullable por la base de datos
        public int? id_ubicacion { get; set; } // Nullable
        public int? id_empleado { get; set; } // Nullable
        public string tipo_registro { get; set; } // Nullable
        public string tipo_incidencia { get; set; } // Nullable
        public string tiempo_sancion { get; set; } // Nullable
        public string descuento_dia { get; set; } // Nullable
        public string dia { get; set; } // Nullable
        public string fecha_inicio { get; set; } // Nullable
        public string descripcion { get; set; } // Nullable
        public string goze { get; set; } // Nullable
        public string horas { get; set; } // Nullable
        public int? id_usuario { get; set; } // Nullable
        public int? ID_Estatus { get; set; } // Nullable
        public string Estatus { get; set; } // Nullable

        // Relación con la entidad Empleados_E
        public virtual Empleados_E empleado { get; set; }
    }
}
