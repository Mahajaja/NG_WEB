using System.Collections.Generic;
using DAL;
using Entity;

namespace BLL
{
    public class Evidencias_BLL
    {
        private Evidencias_DAL evidenciasDAL;

        public Evidencias_BLL()
        {
            evidenciasDAL = new Evidencias_DAL();
        }

        // Método para obtener evidencias por ID_Tabla
        public List<Evidencias_E> GetEvidenciasPorTabla(int idTabla)
        {
            return evidenciasDAL.GetEvidenciasPorTabla(idTabla);
        }
    }
}
