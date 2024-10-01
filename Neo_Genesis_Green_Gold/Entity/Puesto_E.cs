using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Puesto_E
    {
        public int IdPuesto { get; set; }  // Identificador único del puesto
        public string Nombre { get; set; }  // Nombre del puesto
        public string Descripcion { get; set; }  // Descripción del puesto
        public int IdDepartamento { get; set; }  // Identificador del departamento al que pertenece el puesto
        public int IdUsuario { get; set; }  // Identificador del usuario que creó o modificó el registro
    }
}
