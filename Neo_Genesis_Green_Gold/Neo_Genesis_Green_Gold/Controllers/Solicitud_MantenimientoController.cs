using BLL;
using Entity;
using Microsoft.AspNet.Identity;
using Neo_Genesis_Green_Gold.ViewModels;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Neo_Genesis_Green_Gold.Controllers
{
    [Authorize]
    public class Solicitud_MantenimientoController : Controller
    {
        private SolicitudMtto_BLL _solicitudMttoBLL;
        private Ubicacion_BLL _ubicacion;
        private AspNetUsers_BLL _aspNetUser;
        private Categoria_BLL _categoria;
        private Empleados_BLL _empleadosBLL;
        private Maquinaria_BLL _maquinaria;
        private Instalacion_BLL _instalacionBll;
        private OrdenMtto_BLL _ordenBll;
        private Evidencias_BLL _evidenciasBll;
        public Solicitud_MantenimientoController()
        {
            _solicitudMttoBLL = new SolicitudMtto_BLL();
            _ubicacion = new Ubicacion_BLL();
            _aspNetUser = new AspNetUsers_BLL();
            _categoria = new Categoria_BLL();
            _empleadosBLL = new Empleados_BLL();
            _maquinaria = new Maquinaria_BLL();
            _instalacionBll = new Instalacion_BLL();
            _ordenBll = new OrdenMtto_BLL();
            _evidenciasBll = new Evidencias_BLL();
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

        public ActionResult CrearFolio()
        {
            try
            {
                SolicitudMtto_E solicitudMantenimiento = new SolicitudMtto_E
                {
                    FechaRegistro = DateTime.Now.ToString("yyyy-MM-dd"),
                    HoraRegistro = DateTime.Now.ToString("HH:mm:ss"),
                    IdUsuario = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId())
                };

                // Llama al BLL para crear la vacación y obtener el ID generado
                int newIdMantenimiento = _solicitudMttoBLL.InsertarSolicitudMtto(solicitudMantenimiento);

                if (newIdMantenimiento > 0) // Verificar si el ID es válido
                {
                    return RedirectToAction("Create", new { id = newIdMantenimiento });
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
       
        public ActionResult Create(int id = 0)
        {
            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());

            SolicitudMttoViewModel solicitud = new SolicitudMttoViewModel();

            solicitud.List_Ubicaciones = _ubicacion.GetAllUbicaciones(0);
            //solicitud.List_Empleados = _empleadosBLL.ObtenerEmpleadosSolicitudMantenimiento();
            solicitud.SolicitudMantenimientoMode = _solicitudMttoBLL.ObtenerSolicitudMttoPorId(id);
            solicitud.List_Categorias = _categoria.ObtenerTodasLasCategorias();
            solicitud.List_ServicioInterno = _empleadosBLL.GetEmpleadosByDepartamento();
            return View(solicitud);
        }

        [HttpGet]
        public JsonResult GetEmpleadosByUbicacion(int idUbicacion)
        {
            try
            {
                var empleados = _empleadosBLL.ObtenerEmpleadosPorUbicacion(idUbicacion);

                var empleadosData = empleados.Select(e => new
                {
                    IdEmpleado = e.IdEmpleado,
                    Nombre = $"{e.Nombre} {e.ApellidoPaterno} {e.ApellidoMaterno}".Trim()
                }).ToList();

                return Json(new { success = true, empleados = empleadosData }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult ObtenerMaquinariaPorUbicacionYCategoria(int idUbicacion, int idCategoria)
        {
            try
            {
                // Llama al BLL para obtener la maquinaria filtrada por ubicación y categoría
                List<Maquinaria_E> listaMaquinarias = _maquinaria.ObtenerMaquinaria(idUbicacion, idCategoria);

                if (listaMaquinarias != null && listaMaquinarias.Count > 0)
                {
                    return Json(new { success = true, data = listaMaquinarias });
                }
                else
                {
                    return Json(new { success = false, message = "No se encontraron maquinarias para los criterios seleccionados." });
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores
                return Json(new { success = false, message = "Error al obtener las maquinarias: " + ex.Message });
            }
        }

        [HttpPost]
        public JsonResult ObtenerInstalacionesPorUbicacion(int idUbicacion)
        {
            try
            {
                // Llama al BLL para obtener las instalaciones filtradas por ubicación
                List<Instalacion_E> listaInstalaciones = _instalacionBll.ObtenerInstalacionesPorUbicacion(idUbicacion);

                if (listaInstalaciones != null && listaInstalaciones.Count > 0)
                {
                    return Json(new { success = true, data = listaInstalaciones });
                }
                else
                {
                    return Json(new { success = false, message = "No se encontraron instalaciones para la ubicación seleccionada." });
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores
                return Json(new { success = false, message = "Error al obtener las instalaciones: " + ex.Message });
            }
        }

        [HttpPost]
        public ActionResult Create(FormCollection collection, HttpPostedFileBase imagen1, HttpPostedFileBase imagen2, HttpPostedFileBase imagen3, HttpPostedFileBase imagen4)
        {
            try
            {
                // Obtener el ID del usuario actual
                int idUsuarioActual = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId());

                // Recoger los datos del formulario
                int idSolicitud = Convert.ToInt32(collection["IdSolicitud"]);
                int? idUbicacion = string.IsNullOrEmpty(collection["IdUbicacion"]) ? null : (int?)Convert.ToInt32(collection["IdUbicacion"]);
                int? idEmpleado = string.IsNullOrEmpty(collection["IdEmpleado"]) ? null : (int?)Convert.ToInt32(collection["IdEmpleado"]);
                int? idMaquinaria = string.IsNullOrEmpty(collection["IdMaquinaria"]) ? null : (int?)Convert.ToInt32(collection["IdMaquinaria"]);
                int? horometro = string.IsNullOrEmpty(collection["Horometro"]) ? null : (int?)Convert.ToInt32(collection["Horometro"]);
                string fechaServicio = collection["FechaServicio"];
                string fechaEntrega = collection["FechaEntrega"];
                string gradoUrgencia = collection["GradoUrgencia"];
                int? idResponsable = string.IsNullOrEmpty(collection["IdResponsable"]) ? null : (int?)Convert.ToInt32(collection["IdResponsable"]);
                float? costoReparacion = string.IsNullOrEmpty(collection["CostoReparacion"]) ? null : (float?)Convert.ToSingle(collection["CostoReparacion"]);
                string tipoServicio = collection["TipoServicio"];
                int? idRespReparacion = string.IsNullOrEmpty(collection["IdRespReparacion"]) ? null : (int?)Convert.ToInt32(collection["IdRespReparacion"]);
                int? idCategoria = string.IsNullOrEmpty(collection["IdCategoria"]) ? null : (int?)Convert.ToInt32(collection["IdCategoria"]);
                int? idInstalacion = string.IsNullOrEmpty(collection["IdInstalacion"]) ? null : (int?)Convert.ToInt32(collection["IdInstalacion"]);
                string proveedorReparacion = collection["ProveedorReparacion"];
                string descripcionProblema = collection["DescripcionProblema"];
                string asignado = collection["asignado"];

                // Guardar imágenes comprimidas y obtener su Base64 comprimido
                string path = Server.MapPath("~/Content/Evidencias/SOLICITUD_MTTO/");
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                // Generar fecha para los nombres de archivo
                string fechaActual = DateTime.Now.ToString("yyyyMMdd_HHmmss");

                string evidencia1Base64 = null, evidencia2Base64 = null, evidencia3Base64 = null, evidencia4Base64 = null;
                string nombreArchivo1 = null, nombreArchivo2 = null, nombreArchivo3 = null, nombreArchivo4 = null;

                if (imagen1 != null && imagen1.ContentLength > 0)
                {
                    nombreArchivo1 = $"SOLICITUD_MTTO_{fechaActual}_Evidencia1{Path.GetExtension(imagen1.FileName)}";
                    string fullPath = Path.Combine(path, nombreArchivo1);
                    evidencia1Base64 = CompressAndSaveImage(imagen1.InputStream, fullPath, 80L);
                }

                if (imagen2 != null && imagen2.ContentLength > 0)
                {
                    nombreArchivo2 = $"SOLICITUD_MTTO_{fechaActual}_Evidencia2{Path.GetExtension(imagen2.FileName)}";
                    string fullPath = Path.Combine(path, nombreArchivo2);
                    evidencia2Base64 = CompressAndSaveImage(imagen2.InputStream, fullPath, 80L);
                }

                if (imagen3 != null && imagen3.ContentLength > 0)
                {
                    nombreArchivo3 = $"SOLICITUD_MTTO_{fechaActual}_Evidencia3{Path.GetExtension(imagen3.FileName)}";
                    string fullPath = Path.Combine(path, nombreArchivo3);
                    evidencia3Base64 = CompressAndSaveImage(imagen3.InputStream, fullPath, 80L);
                }

                if (imagen4 != null && imagen4.ContentLength > 0)
                {
                    nombreArchivo4 = $"SOLICITUD_MTTO_{fechaActual}_Evidencia4{Path.GetExtension(imagen4.FileName)}";
                    string fullPath = Path.Combine(path, nombreArchivo4);
                    evidencia4Base64 = CompressAndSaveImage(imagen4.InputStream, fullPath, 80L);
                }

                // Llamar al método DAL para actualizar la solicitud
                SolicitudMtto_E solicitudActualizada = new SolicitudMtto_E
                {
                    IdSolicitud = idSolicitud,
                    IdUbicacion = idUbicacion,
                    IdEmpleado = idEmpleado,
                    IdMaquinaria = idMaquinaria,
                    Horometro = horometro,
                    FechaServicio = fechaServicio,
                    FechaEntrega = fechaEntrega,
                    GradoUrgencia = gradoUrgencia,
                    IdResponsable = idResponsable,
                    CostoReparacion = costoReparacion,
                    TipoServicio = tipoServicio,
                    IdRespReparacion = idRespReparacion,
                    ProveedorReparacion = proveedorReparacion,
                    DescripcionProblema = descripcionProblema,
                    IdUsuario = idUsuarioActual,
                    Asignado = asignado,
                    IdCategoria = idCategoria,
                    IdInstalacion = idInstalacion
                };

                string result = _solicitudMttoBLL.ActualizarSolicitudMtto(
                    solicitudActualizada,
                     nombreArchivo1,
                     nombreArchivo2,
                     nombreArchivo3,
                     nombreArchivo4
                );

                if (result.Contains("exitosamente"))
                {
                    TempData["SuccessMessage"] = "Solicitud actualizada exitosamente.";
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("", "Error al actualizar la solicitud: " + result);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Ocurrió un error: " + ex.Message);
                return RedirectToAction("Index");
            }
        }

        // Método para comprimir y guardar imágenes, devolviendo su Base64 comprimido
        private string CompressAndSaveImage(Stream inputStream, string outputPath, long quality)
        {
            using (var image = System.Drawing.Image.FromStream(inputStream))
            {
                var encoderParameters = new System.Drawing.Imaging.EncoderParameters(1);
                encoderParameters.Param[0] = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.Quality, quality);
                var jpegCodec = System.Drawing.Imaging.ImageCodecInfo.GetImageDecoders().FirstOrDefault(codec => codec.FormatID == System.Drawing.Imaging.ImageFormat.Jpeg.Guid);

                if (jpegCodec != null)
                {
                    using (var outputStream = new FileStream(outputPath, FileMode.Create))
                    {
                        image.Save(outputStream, jpegCodec, encoderParameters);
                    }
                }

                // Convertir a Base64 comprimido
                using (var ms = new MemoryStream())
                {
                    image.Save(ms, jpegCodec, encoderParameters);
                    return Convert.ToBase64String(ms.ToArray());
                }
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
                _solicitudMttoBLL.EliminarSolicitudMtto(id_registro);

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

        public ActionResult ConfirmDelete_Orden(int id)
        {
            ViewBag.id = id;
            return View(); // Cargar la vista Delete.cshtml
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete_Orden(int id_registro)
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
                _ordenBll.EliminarOrdenMtto(id_registro);

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

        public ActionResult CrearFolio_Orden(int id_Solicitud)
        {
            try
            {
                int newIdOrden = _ordenBll.InsertarOrdenMtto(_aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId()), id_Solicitud);

                if (newIdOrden > 0) // Verificar si el ID es válido
                {
                    return RedirectToAction("Nueva_OrdenMantenimiento", new { id = newIdOrden });
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

        public ActionResult Nueva_OrdenMantenimiento(int id = 0)  
        {            
            if (id == 0)
            {
                return View("Index");
            }
            OrdenMantenimientoViewModel ordenMantenimientoVM = new OrdenMantenimientoViewModel();          
            ordenMantenimientoVM.OrdenMantenimiento = _ordenBll.ObtenerOrdenMttoPorId(id);
            ordenMantenimientoVM.SolicitudMantenimiento = _solicitudMttoBLL.ObtenerSolicitudMttoPorId(ordenMantenimientoVM.OrdenMantenimiento.IdSolicitud);
            ordenMantenimientoVM.Evidencias = _evidenciasBll.GetEvidenciasPorTabla(ordenMantenimientoVM.OrdenMantenimiento.IdSolicitud);
            ordenMantenimientoVM.List_ServicioInterno = _empleadosBLL.GetEmpleadosByDepartamento();
            return View(ordenMantenimientoVM);
        }

        [HttpPost]
        public ActionResult UpdateOrder(FormCollection collection, HttpPostedFileBase imagen1, HttpPostedFileBase imagen2, HttpPostedFileBase imagen3, HttpPostedFileBase imagen4)
        {
            try
            {
                // Obtener el ID del usuario actual
                int idUsuarioActual = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId());

                // Recoger los datos del formulario
                int idOrden = Convert.ToInt32(collection["IdOrden"]);
                string tipoServicio = collection["TipoServicio"];
                int? idEmpleado = string.IsNullOrEmpty(collection["IdEmpleado"]) ? null : (int?)Convert.ToInt32(collection["IdEmpleado"]);
                string atendidoExterno = collection["AtendidoExterno"];
                string diagnosticoFalla = collection["DiagnosticoFalla"];
                string observaciones = collection["Observaciones"];
                string refacciones = collection["Refacciones"];
                string folioAlmacen = collection["FolioAlmacen"];
                string folioCompras = collection["FolioCompras"];
                string fallaCorregida = collection["FallaCorregida"];
                string tiempoInvertido = collection["TiempoInvertido"];

                // Guardar imágenes comprimidas y obtener su Base64 comprimido
                string path = Server.MapPath("~/Content/Evidencias/ORDEN_MTTO/");
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                // Generar fecha para los nombres de archivo
                string fechaActual = DateTime.Now.ToString("yyyyMMdd_HHmmss");

                string evidencia1Base64 = null, evidencia2Base64 = null, evidencia3Base64 = null, evidencia4Base64 = null;
                string nombreArchivo1 = null, nombreArchivo2 = null, nombreArchivo3 = null, nombreArchivo4 = null;

                if (imagen1 != null && imagen1.ContentLength > 0)
                {
                    nombreArchivo1 = $"ORDEN_MTTO_{fechaActual}_Evidencia1{Path.GetExtension(imagen1.FileName)}";
                    string fullPath = Path.Combine(path, nombreArchivo1);
                    evidencia1Base64 = CompressAndSaveImage(imagen1.InputStream, fullPath, 80L);
                }

                if (imagen2 != null && imagen2.ContentLength > 0)
                {
                    nombreArchivo2 = $"ORDEN_MTTO_{fechaActual}_Evidencia2{Path.GetExtension(imagen2.FileName)}";
                    string fullPath = Path.Combine(path, nombreArchivo2);
                    evidencia2Base64 = CompressAndSaveImage(imagen2.InputStream, fullPath, 80L);
                }

                if (imagen3 != null && imagen3.ContentLength > 0)
                {
                    nombreArchivo3 = $"ORDEN_MTTO_{fechaActual}_Evidencia3{Path.GetExtension(imagen3.FileName)}";
                    string fullPath = Path.Combine(path, nombreArchivo3);
                    evidencia3Base64 = CompressAndSaveImage(imagen3.InputStream, fullPath, 80L);
                }

                if (imagen4 != null && imagen4.ContentLength > 0)
                {
                    nombreArchivo4 = $"ORDEN_MTTO_{fechaActual}_Evidencia4{Path.GetExtension(imagen4.FileName)}";
                    string fullPath = Path.Combine(path, nombreArchivo4);
                    evidencia4Base64 = CompressAndSaveImage(imagen4.InputStream, fullPath, 80L);
                }

                // Crear el objeto de orden actualizado
                OrdenMtto_E ordenActualizada = new OrdenMtto_E
                {
                    IdOrden = idOrden,
                    TipoServicio = tipoServicio,
                    AtendidoExterno = atendidoExterno,
                    DiagnosticoFalla = diagnosticoFalla,
                    Observaciones = observaciones,
                    Refacciones = refacciones,
                    FolioAlmacen = folioAlmacen,
                    FolioCompras = folioCompras,
                    FallaCorregida = fallaCorregida,
                    TiempoInvertido = tiempoInvertido,
                    ImgSolucion = nombreArchivo1,
                    ImgSolucion2 = nombreArchivo2,
                    ImgSolucion3 = nombreArchivo3,
                    ImgSolucion4 = nombreArchivo4
                };

                // Llamar al BLL para actualizar la orden
                string result = _ordenBll.ActualizarOrdenMtto(
                    ordenActualizada
                );

                if (result.Contains("exitosamente"))
                {
                    TempData["SuccessMessage"] = "Orden de mantenimiento actualizada exitosamente.";
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("", "Error al actualizar la orden: " + result);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "Ocurrió un error: " + ex.Message);
                return RedirectToAction("Index");
            }
        }

        public ActionResult CrearFolio_Eval_Mtto(int id_Solicitud)
        {
            try
            {
                int IDUsuario = _aspNetUser.GetIdUsuarioByUserId(User.Identity.GetUserId());
                int newIdEval = _solicitudMttoBLL.InsertarCierreOrden(id_Solicitud, IDUsuario);

                if (newIdEval > 0) // Verificar si el ID es válido
                {
                    return RedirectToAction("Eval_Mtto", new { id = newIdEval });
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

        public ActionResult Eval_Mtto(int id = 0)
        {
            if (id == 0)
            {
                return View("Index");
            }

            CierreOrden_E cierreModel = new CierreOrden_E();
            cierreModel = _solicitudMttoBLL.ObtenerCierreOrdenPorId(id);
            return View(cierreModel);
        }

        [HttpPost]
        public ActionResult Eval_Mtto(CierreOrden_E cierreOrden, FormCollection form)
        {
            try
            {
                // Recoger las respuestas del formulario
                cierreOrden.HerramientasTrabajo = form["q1"];
                cierreOrden.TiempoReparacion = form["q1_TIEMPO"];
                cierreOrden.ReparacionRealizada = form["q2"];
                cierreOrden.OtraFalla = form["q3"];
                cierreOrden.EspecificacionFalla = form["q3-details"];
                cierreOrden.AreaReparacion = form["q4"];
                cierreOrden.MedidasSeguridad = form["q5"];
                cierreOrden.AreaLimpia = form["q6"];
                cierreOrden.CalidadTrabajo = form["q7"];
                cierreOrden.EspecificarCalidad = form["q7-details"];
                cierreOrden.SobranteMaterial = form["q8"];
                cierreOrden.EntradaAlmacen = form["q8-folio"];
                cierreOrden.Observaciones = form["observations"];

                // Consumir el método ActualizarCierreOrden del BLL o DAL
                string resultado = _solicitudMttoBLL.ActualizarCierreOrden(cierreOrden);

                // Mostrar mensaje de éxito y redirigir a una vista o la misma página
                TempData["SuccessMessage"] = resultado;
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = "Error al actualizar la información: " + ex.Message;
                return View(cierreOrden);
            }
        }



        public ActionResult ConfirmDelete_Eval(int id)
        {
            ViewBag.id = id;
            return View(); // Cargar la vista Delete.cshtml
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete_Eval(int id_registro)
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
                _solicitudMttoBLL.EliminarCierreOrden(id_registro);

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
