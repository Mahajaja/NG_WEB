using DAL;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class Horas_Extra_BLL
    {
        Horas_Extra_DAL _horasextra = new Horas_Extra_DAL();
        public List<Horas_Extras_E> GetAllHorasExtra()
        {
            return _horasextra.GetAllHorasExtra();
        }
        public int InsertHorasExtra(Horas_Extras_E horaExtra, string evidencia1, string evidencia2)
        {
            return _horasextra.InsertHorasExtra(horaExtra, evidencia1, evidencia2);
        }
    }
}
