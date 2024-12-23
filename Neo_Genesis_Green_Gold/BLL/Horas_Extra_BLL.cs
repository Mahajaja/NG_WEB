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
        public List<Horas_Extras_E> GetAllHorasExtra(int id)
        {
            return _horasextra.GetAllHorasExtra(id);
        }
        public int InsertHorasExtra(Horas_Extras_E horaExtra)
        {
            return _horasextra.InsertHorasExtra(horaExtra);
        }

        public Horas_Extras_E ObtenerHoraExtraPorId(int idHoraExtra)
        {
            return _horasextra.ObtenerHoraExtraPorId(idHoraExtra);
        }

        public bool ActualizarHorasExtraConEvidencias(Horas_Extras_E horaExtra, string evidencia1, string evidencia2)
        {
            if (horaExtra == null)
            {
                throw new ArgumentNullException(nameof(horaExtra), "El objeto hora extra no puede ser nulo.");
            }

            // Validaciones adicionales
            if (horaExtra.id_horaExtra <= 0)
            {
                throw new ArgumentException("El ID de la hora extra debe ser un valor válido.", nameof(horaExtra.id_horaExtra));
            }

            return _horasextra.ActualizarHorasExtraConEvidencias(horaExtra, evidencia1, evidencia2);
        }

        public int Delete(int id)
        {
            return _horasextra.Delete(id);
        }

    }
}
