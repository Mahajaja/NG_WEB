using System;

namespace Entity
{
    public class Menu_Usuario_E
    {
        public int ID_Menu { get; set; }
        public string ID_Usuario { get; set; } // Usualmente es de tipo string o GUID

        // Relación inversa con Menu
        public Menu_E Menu { get; set; }

        // Constructor
        public Menu_Usuario_E() { }
    }
}
