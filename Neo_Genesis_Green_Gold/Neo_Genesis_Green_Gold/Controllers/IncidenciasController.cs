using BLL;
using Entity;
using Microsoft.AspNet.Identity;
using Neo_Genesis_Green_Gold.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;

namespace Neo_Genesis_Green_Gold.Controllers
{
    [Authorize]
    public class IncidenciasController : Controller
    {
        private Incidencia_BLL _incidencia = new Incidencia_BLL();
        private Empleados_BLL _empleadobll = new Empleados_BLL();
        private AspNetUsers_BLL _aspNetUser = new AspNetUsers_BLL();
        private Ubicacion_BLL _ubicacionBll = new Ubicacion_BLL();
        private TiposIncidencias_BLL _tipoIncidencia = new TiposIncidencias_BLL();
        private Sanciones_BLL _sanciones = new Sanciones_BLL();
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

        public ActionResult CrearFolio()
        {
            try
            {
                Incidencia_E incidenciaM = new Incidencia_E
                {
                    fecha_registro = DateTime.Now.ToString("yyyy-MM-dd"),
                    hora_registro = DateTime.Now.ToString("HH:mm:ss"),
                    id_usuario = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId())
                };

                // Llama al BLL para crear la vacación y obtener el ID generado
                int newIncidenciaID = _incidencia.CrearIncidencia(incidenciaM);

                if (newIncidenciaID > 0) // Verificar si el ID es válido
                {
                    return RedirectToAction("Create", new { ID_Incidencia = newIncidenciaID });
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

        // GET: Incidencias/Create
        public ActionResult Create(int ID_Incidencia = 0)
        {
            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;

            IncidenciasViewModel incidenciasVM = new IncidenciasViewModel();
            incidenciasVM.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Lugar;
            incidenciasVM.List_Empleados = new List<Empleados_E>();
            incidenciasVM.List_Incidencias = new List<TiposIncidencias_E>();
            incidenciasVM.List_Sanciones = new List<Sanciones_E>();
            incidenciasVM.IncidenciaModel = new Incidencia_E();
            incidenciasVM.IncidenciaModel = _incidencia.ObtenerIncidenciaPorId(ID_Incidencia);

            // Cargar la lista de empleados y procesar el nombre de la imagen
            var empleados = _empleadobll.GetEmpleadosByUbicacion(idubicacion);
            foreach (var empleado in empleados)
            {
                empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                incidenciasVM.List_Empleados.Add(empleado);
            }
            incidenciasVM.List_Incidencias = _tipoIncidencia.GetAllTiposIncidencias();
            incidenciasVM.List_Sanciones = _sanciones.GetAllSanciones();

            return View(incidenciasVM);
        }

        // POST: Incidencias/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // Crear una nueva instancia de Incidencia_E
                Incidencia_E nuevaIncidencia = new Incidencia_E
                {
                    id_incidencia = Convert.ToInt32(collection["id_incidencia"]),
                    id_empleado = Convert.ToInt32(collection["IdEmpleado"]),
                    tipo_registro = collection["tipoRegistro"],
                    tipo_incidencia = collection["TipoSancion"],
                    tiempo_sancion = collection["Sancion"],
                    descuento_dia = collection["descontarDias"],
                    dia = collection["cuantosDias"],
                    fecha_inicio = collection["FechaInicio"],
                    descripcion = collection["descripcionIncidencia"],
                    goze = collection["goceSueldo"],
                    horas = collection["cuantosDias"], // Suponiendo que las horas coinciden con el número de días
                    id_usuario = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId()) // Obtener el id del usuario autenticado
                };

                // Insertar la nueva incidencia en la base de datos utilizando BLL

                bool isInserted = _incidencia.ActualizarIncidencia(nuevaIncidencia);

                // Verificar si la inserción fue exitosa
                if (isInserted)
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.ErrorMessage = "Hubo un error al intentar guardar la incidencia.";
                    return View();
                }
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = "Ocurrió un error al intentar crear la incidencia: " + ex.Message;
                int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
                int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;

                IncidenciasViewModel incidenciasVM = new IncidenciasViewModel();
                incidenciasVM.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Lugar;
                incidenciasVM.List_Empleados = new List<Empleados_E>();
                incidenciasVM.List_Incidencias = new List<TiposIncidencias_E>();
                incidenciasVM.List_Sanciones = new List<Sanciones_E>();

                // Cargar la lista de empleados y procesar el nombre de la imagen
                var empleados = _empleadobll.GetEmpleadosByUbicacion(idubicacion);
                foreach (var empleado in empleados)
                {
                    empleado.Img_empleado_nombre = System.IO.Path.GetFileName(empleado.Img_empleado_nombre); // Obtener solo el nombre de archivo
                    incidenciasVM.List_Empleados.Add(empleado);
                }
                incidenciasVM.List_Incidencias = _tipoIncidencia.GetAllTiposIncidencias();
                incidenciasVM.List_Sanciones = _sanciones.GetAllSanciones();

                return View(incidenciasVM);
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


