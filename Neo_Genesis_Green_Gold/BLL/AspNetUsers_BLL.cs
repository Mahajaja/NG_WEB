using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class AspNetUsers_BLL
    {
        private AspNetUsers_DAL _usuariosDal = new AspNetUsers_DAL();

        public int GetIdEmpleadoByUserId(string id)
        {
            return _usuariosDal.GetIdEmpleadoByUserId(id);
        }

        public int GetIdUsuarioByUserId(string id)
        {
            return _usuariosDal.GetIdUsuarioByUserId(id);
        }
    }
}
