using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Categoria_E
    {
        public int Id_Categoria { get; set; }
        public string Nombre_Categoria { get; set; }
        public string Clasificacion { get; set; }
        public string Fecha_Registro { get; set; }
        public string Hora_Registro { get; set; }
        public int Id_Usuario { get; set; }
    }

}
