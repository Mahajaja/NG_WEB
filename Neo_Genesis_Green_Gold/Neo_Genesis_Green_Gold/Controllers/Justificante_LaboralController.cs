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
    public class Justificante_LaboralController : Controller
    {
        private Justificante_BLL _justificante = new Justificante_BLL();
        private Empleados_BLL _empleadobll = new Empleados_BLL();
        private AspNetUsers_BLL _aspNetUser = new AspNetUsers_BLL();
        private Ubicacion_BLL _ubicacionBll = new Ubicacion_BLL();

        // GET: Justificante_Laboral
        public ActionResult Index()
        {
            try
            {
                // Obtener la lista de todas las solicitudes de vacaciones con el formato adecuado
                List<Justificante_E> listaJustificantes = _justificante.ObtenerTodosLosJustificantes();

                // Pasar la lista a la vista
                return View(listaJustificantes);
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ViewBag.ErrorMessage = "Hubo un error al cargar las solicitudes de vacaciones.";
                return View(new List<Justificante_E>());
            }
        }

        public ActionResult Create()
        {
            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;

            // Crear el ViewModel y cargar los datos necesarios
            JustificanteViewModel justificanteVM = new JustificanteViewModel();
            justificanteVM.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Lugar;
            justificanteVM.List_Empleados = new List<Empleados_E>();

            // Cargar la lista de empleados y procesar el nombre de la imagen
            var empleados = _empleadobll.GetEmpleadosByUbicacion(idubicacion);
            foreach (var empleado in empleados)
            {
                empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                justificanteVM.List_Empleados.Add(empleado);
            }

            return View(justificanteVM);
        }

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                int idUsuarioActual = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId());

                // Recoger los datos del formulario
                int idEmpleado = Convert.ToInt32(collection["IdEmpleado"]);
                string naturalezaPermiso = collection["NaturalezaPermiso"];
                string especificacionPermiso = collection["EspesificacionPermiso"];
                string permisoSolicitado = collection["PermisoSolicitado"];
                string otroPermiso = collection["OtroPermiso"];
                string fechaFalta = collection["FechaInicio"];
                string horasParcial = collection["NumeroHoras"];
                string pagoHoras = collection["PagoHoras"];
                string observacion = collection["Observaciones"];
                string sueldos = collection["Sueldos"];
                string institucion = collection["Institucion"];
                string otraInstitucion = collection["OtraInstitucion"];
                string fechaFin = collection["FechaFin"];

                // Crear el objeto Justificante_E
                Justificante_E nuevoJustificante = new Justificante_E
                {
                    IdEmpleado = idEmpleado,
                    NaturalezaPermiso = naturalezaPermiso,
                    EspecificacionPermiso = especificacionPermiso,
                    PermisoSolicitado = permisoSolicitado,
                    OtroPermiso = otroPermiso,
                    FechaFalta = fechaFalta,
                    HorasParcial = horasParcial,
                    PagoHoras = pagoHoras,
                    Observacion = observacion,
                    Sueldos = sueldos,
                    IdUsuario = idUsuarioActual,
                    FechaRegistro = DateTime.Now.ToString("yyyy-MM-dd"),
                    HoraRegistro = DateTime.Now.ToString("HH:mm:ss"),
                    Institucion = institucion,
                    OtraInstitucion = otraInstitucion,
                    FechaFin = fechaFin
                };

                // Llamar a la función para insertar el justificante
                bool result = _justificante.InsertJustificante(nuevoJustificante);

                if (result)
                {
                    TempData["SuccessMessage"] = "Justificante creado exitosamente.";
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("", "Error al insertar el justificante.");
                    return View();
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Ocurrió un error: " + ex.Message);
                return View();
            }
        }


    }
}