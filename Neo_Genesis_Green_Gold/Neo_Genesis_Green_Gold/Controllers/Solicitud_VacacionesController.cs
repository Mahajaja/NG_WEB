using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using BLL;
using Entity;
using Microsoft.AspNet.Identity;
using Neo_Genesis_Green_Gold.ViewModels;

namespace Neo_Genesis_Green_Gold.Controllers
{
    [Authorize]
    public class Solicitud_VacacionesController : Controller
    {
        private Vacaciones_BLL _vacacionesBll = new Vacaciones_BLL();
        private Ubicacion_BLL _ubicacionBll = new Ubicacion_BLL();
        private Empleados_BLL _empleadobll = new Empleados_BLL();
        private AspNetUsers_BLL _aspNetUser = new AspNetUsers_BLL();
        private DiasInhabiles_BLL _diasinhabiles = new DiasInhabiles_BLL();

        // GET: Solicitud_Vacaciones
        public ActionResult Index()
        {
            try
            {
                // Obtener la lista de todas las solicitudes de vacaciones con el formato adecuado
                List<SolicitudesVacacionesViewModel> listaVacaciones = _vacacionesBll.GetVacacionesConFormato();

                // Pasar la lista a la vista
                return View(listaVacaciones);
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ViewBag.ErrorMessage = "Hubo un error al cargar las solicitudes de vacaciones.";
                return View(new List<SolicitudesVacacionesViewModel>());
            }
        }


        // GET: Solicitud_Vacaciones/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // Nueva acción para obtener los días disponibles del empleado
        [HttpGet]
        public JsonResult GetDiasDisponibles(int idEmpleado)
        {
            try
            {
                // Llamar al método GetEmpleadoById para obtener los detalles del empleado
                var empleado = _empleadobll.GetEmpleadoById(idEmpleado);

                // Asegurarse de que el objeto empleado no sea null
                if (empleado == null)
                {
                    return Json(new { diasDisponibles = 0, error = "Empleado no encontrado" }, JsonRequestBehavior.AllowGet);
                }

                // Obtener los días de vacaciones disponibles
                int diasDisponibles = empleado.Vacaciones;

                return Json(new { diasDisponibles = diasDisponibles }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                // Manejo de errores: devolver 0 como valor de días disponibles y el mensaje de error
                return Json(new { diasDisponibles = 0, error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        [HttpGet]
        public JsonResult CalcularDiasInhabiles(DateTime inicio, DateTime termino)
        {
            try
            {
                if (inicio == default || termino == default || inicio > termino)
                {
                    throw new Exception("Las fechas proporcionadas no son válidas.");
                }

                // Calcular días inhábiles y totales
                int diasInhabiles = _diasinhabiles.GetNumeroDiasInhabilesEnRango_weekend(inicio, termino);
                int diasTotales = (termino - inicio).Days + 1;

                // Calcular fecha de incorporación (día hábil siguiente)
                DateTime fechaIncorporacion = termino.AddDays(1);
                while (_diasinhabiles.EsDiaInhabil(fechaIncorporacion) || fechaIncorporacion.DayOfWeek == DayOfWeek.Sunday)
                {
                    fechaIncorporacion = fechaIncorporacion.AddDays(1);
                }

                // Retornar el cálculo
                return Json(new
                {
                    diasTotales = diasTotales,
                    diasInhabiles = diasInhabiles,
                    fechaIncorporacion = fechaIncorporacion.ToString("yyyy-MM-dd")
                }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }



        public ActionResult CrearFolio()
        {
            try
            {
                Vacaciones_E vacacion = new Vacaciones_E
                {
                    fecha_registro = DateTime.Now.ToString("yyyy-MM-dd"),
                    hora_registro = DateTime.Now.ToString("HH:mm:ss"),
                    id_usuario = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId())
                };

                // Llama al BLL para crear la vacación y obtener el ID generado
                int newIdVacaciones = _vacacionesBll.CrearVacacion(vacacion);

                if (newIdVacaciones > 0) // Verificar si el ID es válido
                {
                    return RedirectToAction("Create", new { id = newIdVacaciones });
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

        public JsonResult GetEmpleadosByUbicacion(int idUbicacion)
        {
            try
            {
                var empleados = _empleadobll.GetEmpleadosByUbicacion(idUbicacion);
                var empleadosData = empleados.Select(e => new
                {
                    IdEmpleado = e.IdEmpleado,
                    Nombre = $"{e.Nombre} {e.ApellidoPaterno}",
                    ImgEmpleado = e.Img_empleado_nombre
                }).ToList();

                return Json(new { success = true, empleados = empleadosData }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        public ActionResult Create(int id = 0)
        {

            


            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;
            
            // Crear el ViewModel y cargar los datos necesarios
            SolicitudVacacionesViewModel solicitudViewModel = new SolicitudVacacionesViewModel();
            solicitudViewModel.Vacacion = new Vacaciones_E();
            solicitudViewModel.Vacacion = _vacacionesBll.ObtenerVacacionPorId(id);
            solicitudViewModel.Folio = _vacacionesBll.ObtenerVacacionPorId(id).folio_registro;
            solicitudViewModel.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Nombre;
            solicitudViewModel.List_Empleados = new List<Empleados_E>();
            solicitudViewModel.MostrarUbicaciones = true;
            solicitudViewModel.List_Ubicaciones = _ubicacionBll.GetAllUbicaciones(empleadoid); // Mostrar todas las ubicaciones
            solicitudViewModel.List_Empleados = new List<Empleados_E>();
           

            // Cargar la lista de empleados y procesar el nombre de la imagen
            var empleados = _empleadobll.GetEmpleadosByUbicacion(idubicacion);
            foreach (var empleado in empleados)
            {
                empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                solicitudViewModel.List_Empleados.Add(empleado);
            }

            return View(solicitudViewModel);
        }

        [HttpPost]
        public ActionResult Create(Vacaciones_E vacacion)
        {
            try
            {
                // Validar el objeto vacacion
                if (!vacacion.id_ubicacion.HasValue || vacacion.id_ubicacion == 0)
                {
                    ModelState.AddModelError("id_ubicacion", "Debe seleccionar una ubicación válida.");
                    return View(vacacion);
                }

                // Asignar la fecha y hora de registro actualizados
                vacacion.fecha_registro = DateTime.Now.ToString("yyyy-MM-dd");
                vacacion.hora_registro = DateTime.Now.ToString("HH:mm:ss");

                // Verificar si Observaciones es NULL y asignar una cadena vacía
                vacacion.observaciones = vacacion.observaciones ?? string.Empty;

                // Obtener el usuario actual
                vacacion.id_usuario = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId());
                // Llamar a la capa de negocio para actualizar la solicitud de vacaciones
                _vacacionesBll.UpdateVacacion(vacacion); // Método de actualización

                // Redirigir al índice si todo es correcto
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
                int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;

                // Crear el ViewModel y cargar los datos necesarios
                SolicitudVacacionesViewModel solicitudViewModel = new SolicitudVacacionesViewModel();
                solicitudViewModel.Folio = _vacacionesBll.ObtenerVacacionPorId(vacacion.id_vacacion).folio_registro;
                solicitudViewModel.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Nombre;
                solicitudViewModel.List_Empleados = new List<Empleados_E>();

                // Cargar la lista de empleados y procesar el nombre de la imagen
                var empleados = _empleadobll.GetEmpleadosByUbicacion(idubicacion);
                foreach (var empleado in empleados)
                {
                    empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                    solicitudViewModel.List_Empleados.Add(empleado);
                }

                return View(solicitudViewModel);
            }
        }


        public ActionResult HandleCreateError(string message)
        {
            // Manejar la lógica de recuperación de datos para volver a la vista de creación
            ViewBag.ErrorMessage = message;

            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;

            SolicitudVacacionesViewModel solicitudViewModel = new SolicitudVacacionesViewModel();
            solicitudViewModel.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Lugar;
            solicitudViewModel.List_Empleados = _empleadobll.GetEmpleadosByUbicacion(idubicacion);

            return View("Create", solicitudViewModel);
        }



        // GET: Solicitud_Vacaciones/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Solicitud_Vacaciones/Edit/5
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

        // GET: Solicitud_Vacaciones/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Solicitud_Vacaciones/Delete/5
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
