using System;
using System.Collections.Generic;

namespace Entity
{
    public class Menu_E
    {
        public int ID_Menu { get; set; }
        public string Nombre_Menu { get; set; }
        public int? ID_PadreMenu { get; set; }
        public DateTime Fecha_Inserto { get; set; }
        public string Controlador { get; set; }
        public string Accion { get; set; }
        public string Icono { get; set; }
        // Relación con Menu_Usuario
        public ICollection<Menu_Usuario_E> Menu_Usuarios { get; set; }

        // Constructor
        public Menu_E()
        {
            Menu_Usuarios = new HashSet<Menu_Usuario_E>();
        }
    }
}
