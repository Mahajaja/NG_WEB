using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
namespace BLL
{
    public class DiasInhabiles_BLL
    {
        private DiasInhabiles_DAL _dias = new DiasInhabiles_DAL();

        public bool CheckDiaInhabil(DateTime fecha)
        {
            return _dias.CheckDiaInhabil(fecha);
        }

        public bool CheckDiaInhabilEnRango(DateTime fechaInicio, DateTime fechaFin)
        {
            return _dias.CheckDiaInhabilEnRango(fechaInicio, fechaFin);
        }

        public int GetNumeroDiasInhabilesEnRango_weekend(DateTime fechaInicio, DateTime fechaFin)
        {
            return _dias.GetNumeroDiasInhabilesEnRango_weekend(fechaInicio, fechaFin);
        }


        // Método para verificar si una fecha es inhábil
        public bool EsDiaInhabil(DateTime fecha)
        {
            // Verificar si la fecha es domingo
            if (fecha.DayOfWeek == DayOfWeek.Sunday)
            {
                return true;
            }

            // Verificar si la fecha existe en la tabla de días inhábiles
            return _dias.CheckDiaInhabil(fecha);
        }

    }
}
