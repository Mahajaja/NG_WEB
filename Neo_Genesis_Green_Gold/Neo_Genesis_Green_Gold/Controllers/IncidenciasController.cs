using BLL;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Neo_Genesis_Green_Gold.Controllers
{
    [Authorize]
    public class IncidenciasController : Controller
    {
        Incidencia_BLL _incidencia = new Incidencia_BLL();
        // GET: Incidencias
        public ActionResult Index()
        {
            try
            {
                // Obtener la lista de todas las solicitudes de vacaciones con el formato adecuado
                List<Incidencia_E> listaIncidencias = _incidencia.GetAllIncidencias();

                // Pasar la lista a la vista
                return View(listaIncidencias);
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ViewBag.ErrorMessage = "Hubo un error al cargar las solicitudes de vacaciones.";
                return View(new List<Incidencia_E>());
            }
        }
        // GET: Incidencias/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Incidencias/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Incidencias/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Incidencias/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Incidencias/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Incidencias/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Incidencias/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
