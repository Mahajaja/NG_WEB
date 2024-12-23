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
        public int InsertarJustificante(int idUsuario)
        {
            return justificanteDAL.InsertarJustificante(idUsuario);
        }
        // Método para obtener todos los justificantes
        public List<Justificante_E> ObtenerTodosLosJustificantes(int id)
        {
            return justificanteDAL.GetAllJustificantes(id);
        }
        public bool ActualizarJustificante(Justificante_E justificante)
        {
             return justificanteDAL.ActualizarJustificante(justificante);
        }
        public Justificante_E ObtenerJustificantePorId(int idJustificante)
        { 
            return justificanteDAL.ObtenerJustificantePorId(idJustificante);
        }
        public int Delete(int id)
        {
            return justificanteDAL.Delete(id);
        }
    }
}
