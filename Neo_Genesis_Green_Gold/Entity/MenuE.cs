using System;
using System.Collections.Generic;

namespace Entity
{
    public class MenuE
    {
        public int ID_Menu { get; set; }
        public string Nombre_Menu { get; set; }
        public int? ID_PadreMenu { get; set; }
        public DateTime Fecha_Inserto { get; set; }

        // Relación con Menu_Usuario
        public ICollection<Menu_UsuarioE> Menu_Usuarios { get; set; }
    }
}
