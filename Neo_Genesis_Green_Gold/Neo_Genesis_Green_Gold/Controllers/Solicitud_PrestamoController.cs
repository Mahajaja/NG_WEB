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
                List<Prestamo_E> listaPrestamos = _prestamoBL.GetAllPrestamos();

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

        public ActionResult Create()
        {
            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;

            // Crear el ViewModel y cargar los datos necesarios
            PrestamosViewModel prestamoViewModel = new PrestamosViewModel();
            prestamoViewModel.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Lugar;
            prestamoViewModel.List_Empleados = new List<Empleados_E>();

            // Cargar la lista de empleados y procesar el nombre de la imagen
            var empleados = _empleadobll.GetEmpleadosByUbicacion(idubicacion);
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
            int EncargadoId = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idUbicacion = _empleadobll.GetEmpleadoById(EncargadoId).IdUbicacion;
            int IDUserActual = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId());
            try
            {
                // Obtener los valores de los campos del formulario
                int idEmpleado = Convert.ToInt32(collection["IdEmpleado"]);
                string cantidadSolicitada = collection["CantidadSolicitada"];
                string fechaEntrega = collection["Fechaentrega"];
                string motivoPrestamo = collection["MotivoPrestamo"];

                // Obtener el usuario y la ubicación actual
               
                

                // Llamar al BLL para insertar el préstamo
                bool isInserted = _prestamoBL.InsertarPrestamo(idUbicacion, idEmpleado, cantidadSolicitada, fechaEntrega, motivoPrestamo, IDUserActual);

                if (isInserted)
                {
                    TempData["SuccessMessage"] = "La solicitud de préstamo se ha guardado correctamente.";
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.ErrorMessage = "No se pudo guardar la solicitud de préstamo.";
                    PrestamosViewModel prestamoViewModel = new PrestamosViewModel();
                    prestamoViewModel.Ubicacion = _ubicacionBll.GetUbicacionById(idUbicacion).Lugar;
                    prestamoViewModel.List_Empleados = new List<Empleados_E>();

                    // Cargar la lista de empleados y procesar el nombre de la imagen
                    var empleados = _empleadobll.GetEmpleadosByUbicacion(idUbicacion);
                    foreach (var empleado in empleados)
                    {
                        empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                        prestamoViewModel.List_Empleados.Add(empleado);
                    }

                    return View(prestamoViewModel);
                }
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = "Hubo un error al procesar la solicitud de préstamo: " + ex.Message;
                PrestamosViewModel prestamoViewModel = new PrestamosViewModel();
                prestamoViewModel.Ubicacion = _ubicacionBll.GetUbicacionById(idUbicacion).Lugar;
                prestamoViewModel.List_Empleados = new List<Empleados_E>();

                // Cargar la lista de empleados y procesar el nombre de la imagen
                var empleados = _empleadobll.GetEmpleadosByUbicacion(idUbicacion);
                foreach (var empleado in empleados)
                {
                    empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                    prestamoViewModel.List_Empleados.Add(empleado);
                }

                return View(prestamoViewModel);
            }
        }

    }
}