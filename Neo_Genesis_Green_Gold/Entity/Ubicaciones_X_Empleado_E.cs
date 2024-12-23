using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Ubicaciones_X_Empleado_E
    {
        public int ID_Ubicaciones_X_Empleado { get; set; } // Llave primaria
        public int Id_Ubicacion { get; set; } // Llave foránea de la tabla Ubicacion_E
        public int Id_Empleado { get; set; } // Llave foránea de la tabla Empleados_E

        // Propiedades de navegación
        public virtual Ubicacion_E Ubicacion { get; set; } // Relación con Ubicacion_E
        public virtual Empleados_E Empleado { get; set; } // Relación con Empleados_E
    }

}
