using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;

namespace BLL
{
    public class Menu_UsuarioBLL
    {
        Menu_UsuarioDAL menu_usuario = new Menu_UsuarioDAL();

        public List<string> GetMenusByUserID(string userId)
        {
            return menu_usuario.GetMenusByUserID(userId);
        }
    }
}
