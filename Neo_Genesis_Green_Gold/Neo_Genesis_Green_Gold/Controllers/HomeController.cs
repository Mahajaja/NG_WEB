using BLL;
using Microsoft.AspNet.Identity;
using Neo_Genesis_Green_Gold.Models; // Asegúrate de importar el ViewModel
using Neo_Genesis_Green_Gold.ViewModels;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Linq;
using System.Net;

namespace Neo_Genesis_Green_Gold.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private Menu_Usuario_BLL menuBll = new Menu_Usuario_BLL();

        public ActionResult Index()
        {
            string userId = User.Identity.GetUserId(); // Obtiene el ID del usuario actual
            if (string.IsNullOrEmpty(userId))
            {
                ViewBag.Error = "Error: No se pudo identificar al usuario.";
                return View("Error");
            }

            try
            {
                // Obtener todos los menús y submenús de una sola vez desde la lógica de negocio
                var allMenus = menuBll.GetMenusAndSubMenusBy_UserID(userId);

                // Crear el ViewModel para la vista
                var menuViewModels = allMenus
                    .Where(m => m.ID_PadreMenu == null) // Menús principales
                    .Select(menu => new MenuViewModel
                    {
                        ID_Menu = menu.ID_Menu,
                        Nombre_Menu = menu.Nombre_Menu,
                        ID_PadreMenu = menu.ID_PadreMenu,
                        Fecha_Inserto = menu.Fecha_Inserto,
                        Icono = menu.Icono, // Agregamos el ícono desde la base de datos
                        SubMenus = allMenus
                            .Where(subMenu => subMenu.ID_PadreMenu == menu.ID_Menu)
                            .Select(subMenu => new MenuViewModel
                            {
                                ID_Menu = subMenu.ID_Menu,
                                Nombre_Menu = subMenu.Nombre_Menu,
                                ID_PadreMenu = subMenu.ID_PadreMenu,
                                Fecha_Inserto = subMenu.Fecha_Inserto,
                                Icono = subMenu.Icono // Asegúrate de mapear el ícono de los submenús
                            }).ToList()
                    }).ToList();

                // Enviar el ViewModel a la vista
                return View(menuViewModels);
            }
            catch (Exception ex)
            {
                ViewBag.Error = $"Error al cargar los menús: {ex.Message}";
                return View("Error");
            }
        }

        public ActionResult GetMenusByParent(int? idPadre, string menuTitle)
        {
            if (!idPadre.HasValue)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, "El idPadre es nulo.");
            }

            // Obtener el ID del usuario actual
            string userId = User.Identity.GetUserId();

            if (string.IsNullOrEmpty(userId))
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest, "El ID de usuario es nulo.");
            }

            // Obtener los submenús del tipo Entity.Menu, filtrando por ID_PadreMenu e ID_Usuario
            var entitySubMenus = menuBll.GetSubMenusByParentID(idPadre, userId);

            // Mapear Entity.Menu a MenuViewModel
            var subMenus = entitySubMenus.Select(menu => new Neo_Genesis_Green_Gold.ViewModels.MenuViewModel
            {
                ID_Menu = menu.ID_Menu,
                Nombre_Menu = menu.Nombre_Menu,
                ID_PadreMenu = menu.ID_PadreMenu,
                Fecha_Inserto = menu.Fecha_Inserto,
                Icono = menu.Icono,
                Controlador = menu.Controlador,
                Accion = menu.Accion
            }).ToList();

            // Pasar el nombre del menú principal al ViewBag
            ViewBag.MenuTitle = menuTitle;

            // Devolver la vista parcial con los submenús
            return PartialView("_SubMenu", subMenus);
        }







    }
}
