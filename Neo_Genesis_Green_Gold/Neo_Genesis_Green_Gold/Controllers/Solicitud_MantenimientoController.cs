using BLL;
using Entity;
using Neo_Genesis_Green_Gold.ViewModels;
using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Neo_Genesis_Green_Gold.Controllers
{
    public class Solicitud_MantenimientoController : Controller
    {
        private SolicitudMtto_BLL _solicitudMttoBLL;

        public Solicitud_MantenimientoController()
        {
            _solicitudMttoBLL = new SolicitudMtto_BLL();
        }

        // GET: Solicitud_Mantenimiento
        public ActionResult Index()
        {
            try
            {
                // Llama al método de BLL para obtener todas las solicitudes de mantenimiento
                List<SolicitudMtto_E> listaSolicitudesMtto = _solicitudMttoBLL.ObtenerTodasLasSolicitudesMtto();

                // Pasar la lista a la vista
                return View(listaSolicitudesMtto);
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ViewBag.ErrorMessage = "Hubo un error al cargar las solicitudes de mantenimiento: " + ex.Message;
                return View(new List<SolicitudMtto_E>());
            }
        }

        public ActionResult Create()
        {
            SolicitudMttoViewModel solicitud = new SolicitudMttoViewModel();
            solicitud.List_Empleados = new List<Empleados_E>();
            solicitud.List_Maquinarias = new List<Maquinaria_E>();
            solicitud.List_Responsables = new List<Empleados_E>();
            solicitud.List_Ubicaciones = new List<Ubicacion_E>();
            return View(solicitud);
        }
    }
}
