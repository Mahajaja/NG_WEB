using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class MenuViewModel
    {
        public int ID_Menu { get; set; }
        public string Nombre_Menu { get; set; }
        public int? ID_PadreMenu { get; set; }
        public DateTime Fecha_Inserto { get; set; }
        public string Icono { get; set; }
        // Lista de submenús
        public List<MenuViewModel> SubMenus { get; set; }

        public MenuViewModel()
        {
            SubMenus = new List<MenuViewModel>();
        }
    }
}