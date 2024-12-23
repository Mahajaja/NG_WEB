using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Usuario_E
    {
        public int Id_Usuario { get; set; }
        public int Id_Empleado { get; set; }
        public string Nom_Usuario { get; set; }
        public string Nom_Usuario_Web { get; set; }
        public string Permiso { get; set; }
        public string Contraseña { get; set; }
        public string Fecha_Registro { get; set; }
        public string Hora_Registro { get; set; }
        public string correo { get; set; }
        public bool ExistsInAspNetUsers { get; set; } // Nueva propiedad
    }
}

