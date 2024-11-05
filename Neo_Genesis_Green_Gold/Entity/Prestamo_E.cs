using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Prestamo_E
    {
        public int IdPrestamo { get; set; }
        public string FolioPrestamo { get; set; }
        public string HoraRegistro { get; set; }
        public string FechaRegistro { get; set; }
        public int IdUbicacion { get; set; }
        public int IdEmpleado { get; set; }
        public string CantidadAutorizada { get; set; }
        public string DescuentoSemanal { get; set; }
        public string FechaEntrega { get; set; }
        public string FechaInicio { get; set; }
        public string FechaFin { get; set; }
        public string Motivo { get; set; }
        public string Estatus { get; set; }
        public int IdUsuario { get; set; }
        public int IdEstatus { get; set; } // Nueva columna añadida
        public virtual Empleados_E empleado { get; set; }
    }

}
