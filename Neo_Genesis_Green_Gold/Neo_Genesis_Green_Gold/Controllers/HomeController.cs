using BLL;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Neo_Genesis_Green_Gold.Controllers
{
    [Authorize]
    public class HomeController : Controller
    {
        private Menu_UsuarioBLL menuBll = new Menu_UsuarioBLL();
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
                // Obtener los menús desde la lógica de negocio
                var menus = menuBll.GetMenusByUserID(userId);
                ViewBag.Menus = menus;
            }
            catch (Exception ex)
            {
                ViewBag.Error = $"Error al cargar los menús: {ex.Message}";
                return View("Error");
            }

            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}