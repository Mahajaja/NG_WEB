using BLL;
using Entity;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Neo_Genesis_Green_Gold.Constants;
using Neo_Genesis_Green_Gold.Models;
using Neo_Genesis_Green_Gold.ViewModels;
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web.Mvc;

namespace Neo_Genesis_Green_Gold.Controllers
{
    [Authorize]
    public class AdminUsersController : Controller
    {
        private Usuarios_BLL _usuario = new Usuarios_BLL();
        private Empleados_BLL _empleadoBll = new Empleados_BLL();
        private Ubicacion_BLL _ubicacionBll = new Ubicacion_BLL();
        private Ubicaciones_X_Empleado_BLL _ubicacionesEmpleado = new Ubicaciones_X_Empleado_BLL();

        public ActionResult Index()
        {
            return View(_usuario.GetUsuarios());
        }

        public ActionResult ConfirmarUsuario(int id)
        {
            Usuario_E usuarioE = _usuario.GetUsuarioById(id);

            if (usuarioE == null)
            {
                TempData["Error"] = "El usuario no existe.";
                return RedirectToAction("Index");
            }

            return View(usuarioE);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CrearUsuarioASP(int id)
        {
            ApplicationDbContext context = new ApplicationDbContext();
            var userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
            Usuario_E usuarioE = _usuario.GetUsuarioById(id);

            if (usuarioE == null)
            {
                TempData["Error"] = "El usuario no existe.";
                return RedirectToAction("Index");
            }

            string userEmail = usuarioE.correo;
            string userPassword = usuarioE.Contraseña;

            if (userManager.FindByEmail(userEmail) == null)
            {
                // Definir una expresión regular para permitir solo letras y dígitos
                // Elimina caracteres no permitidos, dejando solo letras y números
                string usernameFormat = Regex.Replace(usuarioE.Nom_Usuario.Replace(" ", ""), @"[^a-zA-Z0-9]", "");

                if (!Regex.IsMatch(usernameFormat, @"^[a-zA-Z0-9]+$"))
                {
                    TempData["Error"] = "El nombre de usuario no es válido. Solo puede contener letras o dígitos.";
                    return RedirectToAction("Index");
                } 

                var user = new ApplicationUser { UserName = usernameFormat, Email = userEmail, id_usuario = usuarioE.Id_Usuario };
                var result = userManager.Create(user, userPassword);
                if (result.Succeeded)
                {
                    try
                    {
                        // Asignar roles según el permiso del usuario
                        switch (usuarioE.Permiso.ToLower())
                        {
                            case "administrador":
                                userManager.AddToRole(user.Id, UserRoles.Administrador);
                                break;
                            case "colaborador":
                                userManager.AddToRole(user.Id, UserRoles.Colaborador);
                                break;
                            case "gerente":
                                userManager.AddToRole(user.Id, UserRoles.Gerente);
                                break;
                            case "lector":
                                userManager.AddToRole(user.Id, UserRoles.Lector);
                                break;
                            case "superadmin":
                                userManager.AddToRole(user.Id, UserRoles.SuperAdmin);
                                break;
                            default:
                                throw new Exception("El rol especificado no es válido.");
                        }

                        TempData["Success"] = "Usuario creado con éxito.";
                    }
                    catch (Exception ex)
                    {
                        TempData["Error"] = $"Error al asignar rol: {ex.Message}";
                    }
                }
                else
                {
                    TempData["Error"] = $"Error al crear el usuario: {string.Join(", ", result.Errors)}";
                }
            }
            else
            {
                TempData["Error"] = "El correo electrónico ya está registrado.";
            }

            return RedirectToAction("Index");
        }

        public ActionResult Accesos(int idusuario)
        {
            ViewBag.IdUsuario = idusuario;
            return View(_usuario.GetMenusConEstado(idusuario));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ActualizarAccesos(int idUsuario, int[] selectedMenus)
        {
            try
            {
                // Verifica que se haya enviado al menos un menú
                if (selectedMenus == null)
                {
                    selectedMenus = new int[0]; // Si no hay seleccionados, inicializa un arreglo vacío
                }

                // Llama al método BLL para actualizar los accesos
                _usuario.ActualizarAccesosUsuario(idUsuario, selectedMenus);

                TempData["Success"] = "Accesos actualizados correctamente.";
            }
            catch (Exception ex)
            {
                TempData["Error"] = $"Error al actualizar accesos: {ex.Message}";
            }

            return RedirectToAction("Index");
        }

        public ActionResult Empleados()
        {
            return View(_empleadoBll.ObtenerTodosLosEmpleados());
        }

        public ActionResult UbicacionesEmpleado(int Id = 0)
        {
            if(Id == 0)
            {
                return RedirectToAction("Empleados");
            }
            Ubicaciones_x_Empleado_ViewModel ubicacionEmpleadoVM = new Ubicaciones_x_Empleado_ViewModel();
            ubicacionEmpleadoVM.ListUbicaciones = _ubicacionBll.GetAllUbicaciones(0);
            ubicacionEmpleadoVM.ListUbicacionesEmpleado = _ubicacionesEmpleado.ObtenerUbicacionesPorEmpleado(Id);
            ubicacionEmpleadoVM.id_Empleado = Id;
            return View(ubicacionEmpleadoVM);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ActualizarUbicaciones(int IdEmpleado, List<int> selectedUbicaciones)
        {
            try
            {
                // Eliminar ubicaciones actuales del empleado
                _ubicacionesEmpleado.BorrarUbicacionesPorEmpleado(IdEmpleado);

                // Asignar las nuevas ubicaciones seleccionadas
                if (selectedUbicaciones != null && selectedUbicaciones.Count > 0)
                {
                    foreach (var idUbicacion in selectedUbicaciones)
                    {
                        _ubicacionesEmpleado.InsertarUbicacionXEmpleado(idUbicacion, IdEmpleado);
                    }
                }

                TempData["Mensaje"] = "Ubicaciones actualizadas correctamente.";
            }
            catch (Exception ex)
            {
                TempData["Error"] = $"Ocurrió un error al actualizar las ubicaciones: {ex.Message}";
            }

            return RedirectToAction("Empleados");
        }


    }
}
