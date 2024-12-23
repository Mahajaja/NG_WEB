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
        private Horas_Extra_BLL _horasExtra = new Horas_Extra_BLL();
        private Empleados_BLL _empleadobll = new Empleados_BLL();
        private AspNetUsers_BLL _aspNetUser = new AspNetUsers_BLL();
        private Ubicacion_BLL _ubicacionBll = new Ubicacion_BLL();
   
        // GET: HorasExtra
        public ActionResult Index()
        {
            try
            {
                // Obtener la lista de todas las solicitudes de vacaciones con el formato adecuado
                List<Horas_Extras_E> listaHorasExtra = _horasExtra.GetAllHorasExtra(_aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId()));

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

        public ActionResult CrearFolio()
        {
            try
            {
                Horas_Extras_E horasextraModel = new Horas_Extras_E
                {
                    fecha_registro = DateTime.Now.ToString("yyyy-MM-dd"),
                    hora_registro = DateTime.Now.ToString("HH:mm:ss"),
                    id_usuario = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId())
                };

                // Llama al BLL para crear la vacación y obtener el ID generado
                int newIdHorasExtra = _horasExtra.InsertHorasExtra(horasextraModel);

                if (newIdHorasExtra > 0) // Verificar si el ID es válido
                {
                    return RedirectToAction("Create", new { id = newIdHorasExtra });
                }
                else
                {
                    TempData["ErrorMessage"] = "No se pudo crear el registro de vacaciones.";
                    return RedirectToAction("Error"); // Redirige a una vista de error si falla
                }
            }
            catch (Exception ex)
            {
                // Manejo de excepciones
                TempData["ErrorMessage"] = $"Ocurrió un error: {ex.Message}";
                return RedirectToAction("Error"); // Redirige a una vista de error
            }
        }


        // GET: HorasExtra/Create
        public ActionResult Create(int id)
        {
            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;

            // Crear el ViewModel y cargar los datos necesarios
            Horas_Extra_ViewModel horasExtraVM = new Horas_Extra_ViewModel();
            horasExtraVM.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Lugar;
            horasExtraVM.List_Empleados = new List<Empleados_E>();
            Horas_Extras_E horasextramodel = new Horas_Extras_E();
            horasextramodel = _horasExtra.ObtenerHoraExtraPorId(id);
            horasExtraVM.Folio = horasextramodel.folio_registro;
            horasExtraVM.ID_HoraExtra = horasextramodel.id_horaExtra;
            // Cargar la lista de empleados y procesar el nombre de la imagen
            var empleados = _empleadobll.ObtenerMisEmpleadosPorUbicacion(empleadoid);
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
                int ID_HoraExtra = Convert.ToInt32(collection["ID_HoraExtra"]);
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
                    id_horaExtra = ID_HoraExtra,
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
                bool result = _horasExtra.ActualizarHorasExtraConEvidencias(nuevaHoraExtra, evidencia1Base64, evidencia2Base64);

                if (result == true)
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

        public ActionResult ConfirmDelete(int id)
        {
            ViewBag.id = id;
            return View(); // Cargar la vista Delete.cshtml
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id_registro)
        {
            try
            {
                // Validar el ID
                if (id_registro <= 0)
                {
                    TempData["ErrorMessage"] = "El ID del registro no es válido.";
                    return RedirectToAction("Index");
                }

                // Llama al método de la capa BLL para eliminar el registro
                _horasExtra.Delete(id_registro);

                // Mensaje de éxito
                TempData["SuccessMessage"] = "El registro fue cancelado exitosamente.";
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                // Manejar errores
                TempData["ErrorMessage"] = $"Hubo un error al cancelar el registro: {ex.Message}";
                return RedirectToAction("Index");
            }
        }

    }
}
