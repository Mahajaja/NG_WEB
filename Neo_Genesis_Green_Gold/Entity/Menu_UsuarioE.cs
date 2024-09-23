using System;

namespace Entity
{
    public class Menu_UsuarioE
    {
        public int ID_Menu_Usuario { get; set; }

        // Llave foránea a Menu
        public int ID_Menu { get; set; }
        public MenuE Menu { get; set; }

        // Llave foránea a AspNetUsers (Identidad)
        public string ID_Usuario { get; set; }
         
        // Relación con IdentityUser (si está en el mismo contexto)
        // public IdentityUserE Usuario { get; set; }
    }
}
