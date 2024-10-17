using BLL;
using Entity;
using Microsoft.AspNet.Identity;
using Neo_Genesis_Green_Gold.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Neo_Genesis_Green_Gold.Controllers
{
    [Authorize]
    public class HorasExtraController : Controller
    {
        Horas_Extra_BLL _horasExtra = new Horas_Extra_BLL();
        private Empleados_BLL _empleadobll = new Empleados_BLL();
        private AspNetUsers_BLL _aspNetUser = new AspNetUsers_BLL();
        private Ubicacion_BLL _ubicacionBll = new Ubicacion_BLL();
   
        // GET: HorasExtra
        public ActionResult Index()
        {
            try
            {
                // Obtener la lista de todas las solicitudes de vacaciones con el formato adecuado
                List<Horas_Extras_E> listaHorasExtra = _horasExtra.GetAllHorasExtra();

                // Pasar la lista a la vista
                return View(listaHorasExtra);
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ViewBag.ErrorMessage = "Hubo un error al cargar las solicitudes de vacaciones.";
                return View(new List<Horas_Extras_E>());
            }
        }

        // GET: HorasExtra/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: HorasExtra/Create
        public ActionResult Create()
        {
            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;

            // Crear el ViewModel y cargar los datos necesarios
            Horas_Extra_ViewModel horasExtraVM = new Horas_Extra_ViewModel();
            horasExtraVM.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Lugar;
            horasExtraVM.List_Empleados = new List<Empleados_E>();

            // Cargar la lista de empleados y procesar el nombre de la imagen
            var empleados = _empleadobll.GetEmpleadosByUbicacion(idubicacion);
            foreach (var empleado in empleados)
            {
                empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                horasExtraVM.List_Empleados.Add(empleado);
            }

            return View(horasExtraVM);
        }

        [HttpPost]
        public ActionResult Create(FormCollection collection, HttpPostedFileBase imagen1, HttpPostedFileBase imagen2)
        {
            try
            {
                int IDUserActual = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId());

                // Recoger los datos del formulario
                int idEmpleado = Convert.ToInt32(collection["IdEmpleado"]);
                int idResponsable = IDUserActual;
                DateTime fechaCompensacion = Convert.ToDateTime(collection["FechaInicio"]);
                int horasPorPagar = Convert.ToInt32(collection["HorasExtra"]);
                string motivoHorasExtra = collection["MotivoCompensacion"];
                string observaciones = collection["Observaciones"];
                int idUsuario = IDUserActual;
                string evidencia1Base64 = collection["Evidencia1"];
                string evidencia2Base64 = collection["Evidencia2"];

                // Crear el objeto Horas_Extras_E
                Horas_Extras_E nuevaHoraExtra = new Horas_Extras_E
                {
                    id_empleado = idEmpleado,
                    id_responsable = idResponsable,
                    fecha_compensacion = fechaCompensacion.ToString("yyyy-MM-dd"),
                    horas_porPagar = horasPorPagar,
                    motivo_hraExtra = motivoHorasExtra,
                    observaciones = observaciones,
                    id_usuario = idUsuario
                };

                // Guardar la primera imagen en la carpeta física
                if (imagen1 != null && imagen1.ContentLength > 0)
                {
                    string path = Server.MapPath("~/Content/Evidencias/Horas_Extra/");
                    string fileName = Guid.NewGuid().ToString() + "_" + imagen1.FileName; // Generar un nombre único para la imagen
                    string fullPath = System.IO.Path.Combine(path, fileName);
                    imagen1.SaveAs(fullPath);  // Guardar la imagen en la carpeta
                }

                // Guardar la segunda imagen en la carpeta física
                if (imagen2 != null && imagen2.ContentLength > 0)
                {
                    string path = Server.MapPath("~/Content/Evidencias/Horas_Extra/");
                    string fileName = Guid.NewGuid().ToString() + "_" + imagen2.FileName; // Generar un nombre único para la imagen
                    string fullPath = System.IO.Path.Combine(path, fileName);
                    imagen2.SaveAs(fullPath);  // Guardar la imagen en la carpeta
                }

                // Llamar a la función para insertar la hora extra y las evidencias en base64
                int result = _horasExtra.InsertHorasExtra(nuevaHoraExtra, evidencia1Base64, evidencia2Base64);

                if (result > 0)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("", "Error al insertar las horas extra.");
                    return View();
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Ocurrió un error: " + ex.Message);
                return View();
            }
        }
    


        // GET: HorasExtra/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: HorasExtra/Edit/5
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

        // GET: HorasExtra/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: HorasExtra/Delete/5
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
