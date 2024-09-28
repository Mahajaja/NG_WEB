using System;

namespace Entity
{
    public class Menu_UsuarioE
    {
        public int ID_Menu { get; set; }
        public string ID_Usuario { get; set; } // Usualmente es de tipo string o GUID

        // Relación inversa con Menu
        public MenuE Menu { get; set; }

        // Constructor
        public Menu_UsuarioE() { }
    }
}
