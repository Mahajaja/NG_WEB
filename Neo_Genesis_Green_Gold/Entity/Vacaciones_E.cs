using System;

namespace Entity
{
    public class Vacaciones_E
    {
        public int id_vacacion { get; set; } // Cambiado a minúsculas para coincidir con la base de datos
        public string folio_registro { get; set; }
        public string fecha_registro { get; set; }
        public string hora_registro { get; set; }
        public int? id_ubicacion { get; set; } // Nullable si puede ser null
        public int? id_empleado { get; set; }
        public string fecha_inicio { get; set; }
        public string fecha_fin { get; set; }
        public int? dias_vacacion { get; set; }
        public string fecha_incorporacion { get; set; }
        public int? dias_restantes { get; set; }
        public string observaciones { get; set; }
        public int id_usuario { get; set; }
        public int? ID_Estatus { get; set; } // Nullable si puede ser null
    }
}
