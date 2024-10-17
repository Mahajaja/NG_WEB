using DAL;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class Incidencia_BLL
    {
        Incidencia_DAL _incidencia = new Incidencia_DAL();
        public List<Incidencia_E> GetAllIncidencias()
        {
            return _incidencia.GetAllIncidencias();
        }
    }
}
