using DAL;
using Entity;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class Menu_UsuarioBLL
    {
        Menu_UsuarioDAL menu_usuario = new Menu_UsuarioDAL();

        public List<string> GetMenusByUserID(string userId)
        {
            return menu_usuario.GetMenusByUserID(userId);
        }

        public List<MenuE> GetSubMenusByParentID(int? idPadre)
        {
            if (idPadre.HasValue)
            {
                return menu_usuario.GetSubMenusByParentID(idPadre.Value);
            }
            else
            {
                throw new ArgumentException("idPadre cannot be null.");
            }
        }

        // Nuevo método para obtener menús y submenús por usuario
        public List<MenuE> GetMenusAndSubMenusBy_UserID(string userId)
        {
            return menu_usuario.GetMenusAndSubMenusBy_UserID(userId);
        }
    }
}
