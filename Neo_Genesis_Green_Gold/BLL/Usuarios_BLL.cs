using DAL;
using Entity;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class Usuarios_BLL
    {
        private Usuarios_DAL _usuarioDal = new Usuarios_DAL();

        // Método para obtener todos los usuarios
        public List<Usuario_E> GetUsuarios()
        {
            return _usuarioDal.GetUsuarios();
        }
        public Usuario_E GetUsuarioById(int idUsuario)
        {
            return _usuarioDal.GetUsuarioById(idUsuario);
        }
        public List<Menu_E> GetMenusConEstado(int idUsuario)
        {
            return _usuarioDal.GetMenusConEstado(idUsuario);
        }
        public void ActualizarAccesosUsuario(int idUsuario, int[] selectedMenus)
        {
            _usuarioDal.ActualizarAccesosUsuario(idUsuario, selectedMenus);
        }

    }
}
