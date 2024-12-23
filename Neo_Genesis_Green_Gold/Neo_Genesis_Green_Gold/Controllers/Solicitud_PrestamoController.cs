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
    public class Solicitud_PrestamoController : Controller
    {

        private Prestamo_BLL _prestamoBL = new Prestamo_BLL();
        private Empleados_BLL _empleadobll = new Empleados_BLL();
        private AspNetUsers_BLL _aspNetUser = new AspNetUsers_BLL();
        private Ubicacion_BLL _ubicacionBll = new Ubicacion_BLL();

        // GET: Solicitud_Prestamo
        public ActionResult Index()
        {
            try
            {
                // Obtener la lista de todas las solicitudes de vacaciones con el formato adecuado
                List<Prestamo_E> listaPrestamos = _prestamoBL.GetAllPrestamos(_aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId()));

                // Pasar la lista a la vista
                return View(listaPrestamos);
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ViewBag.ErrorMessage = "Hubo un error al cargar las solicitudes de Prestamo.";
                return View(new List<Prestamo_E>());
            }
        }

        public ActionResult CrearFolio()
        {
            try
            {
                Prestamo_E prestamoE = new Prestamo_E
                {
                    FechaRegistro = DateTime.Now.ToString("yyyy-MM-dd"),
                    HoraRegistro = DateTime.Now.ToString("HH:mm:ss"),
                    IdUsuario = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId())
                };

                // Llama al BLL para crear la vacación y obtener el ID generado
                int newIdVacaciones = _prestamoBL.InsertarPrestamo(prestamoE);

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
        public ActionResult Create(int id)
        {
            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;

            // Crear el ViewModel y cargar los datos necesarios
            PrestamosViewModel prestamoViewModel = new PrestamosViewModel();
            prestamoViewModel.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Lugar;
            prestamoViewModel.List_Empleados = new List<Empleados_E>();
            prestamoViewModel.PrestamoModel = new Prestamo_E();
            prestamoViewModel.PrestamoModel = _prestamoBL.GetPrestamoById(id);
            // Cargar la lista de empleados y procesar el nombre de la imagen
            var empleados = _empleadobll.ObtenerMisEmpleadosPorUbicacion(empleadoid);
            foreach (var empleado in empleados)
            {
                empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                prestamoViewModel.List_Empleados.Add(empleado);
            }

            return View(prestamoViewModel);
        }

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            int id_Prestamo = Convert.ToInt32(collection["IdPrestamo"]);
            // Obtener el usuario y la ubicación actual
            int encargadoId = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
           
            int idUserActual = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId());
         
            try
            {
                // Obtener los valores de los campos del formulario
                int idEmpleado = Convert.ToInt32(collection["IdEmpleado"]);
                string cantidadSolicitada = collection["CantidadSolicitada"];
                string fechaEntrega = collection["Fechaentrega"];
                string motivoPrestamo = collection["MotivoPrestamo"];
               
                // Crear una instancia del modelo `Prestamo_E` y asignar los valores
                Prestamo_E prestamoE = new Prestamo_E
                {
                    IdPrestamo = id_Prestamo, // Asumimos que se va a crear un nuevo registro, por lo que el ID es 0 o no existe aún.                   
                    IdEmpleado = idEmpleado,
                    CantidadAutorizada = cantidadSolicitada,
                    FechaEntrega = fechaEntrega,
                    Motivo = motivoPrestamo,
                    IdUsuario = idUserActual
                };

                // Llamar al BLL para insertar/actualizar el préstamo
                bool isUpdated = _prestamoBL.ActualizarPrestamo(prestamoE);

                if (isUpdated)
                {
                    TempData["SuccessMessage"] = "La solicitud de préstamo se ha guardado correctamente.";
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.ErrorMessage = "No se pudo guardar la solicitud de préstamo.";
                    PrestamosViewModel prestamoViewModel = GenerarPrestamoViewModel(id_Prestamo);
                    return View(prestamoViewModel);
                }
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = "Hubo un error al procesar la solicitud de préstamo: " + ex.Message;
                PrestamosViewModel prestamoViewModel = GenerarPrestamoViewModel(id_Prestamo);
                return View(prestamoViewModel);
            }
        }

        // Método auxiliar para generar el modelo de vista `PrestamosViewModel`
        private PrestamosViewModel GenerarPrestamoViewModel(int idUbicacion)
        {
            PrestamosViewModel prestamoViewModel = new PrestamosViewModel
            {
                Ubicacion = _ubicacionBll.GetUbicacionById(idUbicacion).Lugar,
                List_Empleados = new List<Empleados_E>()
            };

            // Cargar la lista de empleados y procesar el nombre de la imagen
            var empleados = _empleadobll.GetEmpleadosByUbicacion(idUbicacion);
            foreach (var empleado in empleados)
            {
                empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                prestamoViewModel.List_Empleados.Add(empleado);
            }

            return prestamoViewModel;
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
                _prestamoBL.Delete(id_registro);

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