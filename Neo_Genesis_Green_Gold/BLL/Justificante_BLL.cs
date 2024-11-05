using System.Collections.Generic;
using DAL;
using Entity;

namespace BLL
{
    public class Justificante_BLL
    {
        private Justificante_DAL justificanteDAL;

        public Justificante_BLL()
        {
            justificanteDAL = new Justificante_DAL();
        }
        public bool InsertJustificante(Justificante_E justificante)
        {
            return justificanteDAL.InsertJustificante(justificante);
        }
        // Método para obtener todos los justificantes
        public List<Justificante_E> ObtenerTodosLosJustificantes()
        {
            return justificanteDAL.GetAllJustificantes();
        }
    }
}
