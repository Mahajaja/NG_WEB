using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Dias_inhabiles_E
    {
        public int IdDiaInhabil { get; set; }  // ID autoincremental para cada día inhábil
        public DateTime FechaInhabil { get; set; }  // Fecha que se considera inhábil
        public string Descripcion { get; set; }  // Descripción del motivo (opcional)
        public DateTime FechaInserto { get; set; }  // Fecha y hora de inserción del registro
        public int IdUsuario { get; set; }  // ID del usuario que inserta el registro
    }
}
