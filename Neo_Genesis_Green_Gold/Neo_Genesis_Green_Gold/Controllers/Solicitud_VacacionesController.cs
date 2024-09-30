﻿using System;
using System.Collections.Generic;
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
                // Obtener la lista de todas las solicitudes de vacaciones
                List<Vacaciones_E> listaVacaciones = _vacacionesBll.ObtenerTodasLasVacaciones();

                // Pasar la lista a la vista
                return View(listaVacaciones);
            }
            catch (Exception ex)
            {
                // Manejo de errores (podrías registrar el error y mostrar un mensaje adecuado)
                ViewBag.ErrorMessage = "Hubo un error al cargar las solicitudes de vacaciones.";
                return View(new List<Vacaciones_E>());
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
                // Obtener los días de vacaciones disponibles del empleado
                int diasDisponibles = _empleadobll.GetEmpleadoById(idEmpleado).Vacaciones;
                return Json(new { diasDisponibles = diasDisponibles }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { diasDisponibles = 0, error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult CalcularDiasInhabiles(DateTime inicio, DateTime termino)
        {
            try
            {
                // Obtener el número de días inhábiles entre las fechas
                int diasInhabiles = _diasinhabiles.GetNumeroDiasInhabilesEnRango_weekend(inicio, termino);

                // Calcular días totales
                int diasTotales = (termino - inicio).Days + 1;

                // Calcular fecha de incorporación (siguiente día hábil)
                DateTime fechaIncorporacion = termino.AddDays(1);
                while (_diasinhabiles.EsDiaInhabil(fechaIncorporacion) || fechaIncorporacion.DayOfWeek == DayOfWeek.Sunday)
                {
                    fechaIncorporacion = fechaIncorporacion.AddDays(1);
                }

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


        // GET: Solicitud_Vacaciones/Create
        public ActionResult Create()
        {
            int empleadoid = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());
            int idubicacion = _empleadobll.GetEmpleadoById(empleadoid).IdUbicacion;
            //Cuando entremos aquí debemos de tomar el id_empleado de la tabla AspNet
            SolicitudVacacionesViewModel solicitudViewModel = new SolicitudVacacionesViewModel();
            solicitudViewModel.Ubicacion = _ubicacionBll.GetUbicacionById(idubicacion).Lugar;
            solicitudViewModel.List_Empleados = new List<Empleados_E>();
            solicitudViewModel.List_Empleados = _empleadobll.GetEmpleadosByUbicacion(idubicacion);

            return View(solicitudViewModel);
        }

        // POST: Solicitud_Vacaciones/Create
        // POST: Solicitud_Vacaciones/Create
        [HttpPost]
        public ActionResult Create(Vacaciones_E vacacion)
        {
            try
            {
                // Generar el folio de registro (ejemplo: SV_ + un número autogenerado)
                vacacion.FolioRegistro = "SV_" + new Random().Next(1000, 9999); // O puedes usar un valor autoincremental de la base de datos

                // Asignar la fecha y hora de registro
                vacacion.FechaRegistro = DateTime.Now.ToString("yyyy-MM-dd");
                vacacion.HoraRegistro = DateTime.Now.ToString("HH:mm:ss");

                // Obtener el usuario actual
                vacacion.IdUsuario = _aspNetUser.GetIdEmpleadoByUserId(User.Identity.GetUserId());

                // Llamar a la capa de negocio para insertar la nueva solicitud de vacaciones
                int resultado = _vacacionesBll.CrearVacacion(vacacion);

                if (resultado > 0)
                {
                    // Redirigir al índice si todo es correcto
                    return RedirectToAction("Index");
                }
                else
                {
                    ViewBag.ErrorMessage = "Hubo un error al guardar la solicitud de vacaciones.";
                    return View(vacacion);
                }
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = "Hubo un error: " + ex.Message;
                return View(vacacion);
            }
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
