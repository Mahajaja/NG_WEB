using DAL;
using Entity;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class Menu_Usuario_BLL
    {
        Menu_Usuario_DAL menu_usuario = new Menu_Usuario_DAL();

        public List<string> GetMenusByUserID(string userId)
        {
            return menu_usuario.GetMenusByUserID(userId);
        }

        public List<Menu_E> GetSubMenusByParentID(int? idPadre, string ID_Usuario)
        {
            if (idPadre.HasValue)
            {
                return menu_usuario.GetSubMenusByParentID(idPadre.Value, ID_Usuario);
            }
            else
            {
                throw new ArgumentException("idPadre cannot be null.");
            }
        }

        // Nuevo método para obtener menús y submenús por usuario
        public List<Menu_E> GetMenusAndSubMenusBy_UserID(string userId)
        {
            return menu_usuario.GetMenusAndSubMenusBy_UserID(userId);
        }
    }
}
