using System.Collections.Generic;
using DAL;
using Entity;

namespace BLL
{
    public class Categoria_BLL
    {
        private Categoria_DAL _categoriaDAL;

        public Categoria_BLL()
        {
            _categoriaDAL = new Categoria_DAL();
        }

        // Método para obtener todas las categorías
        public List<Categoria_E> ObtenerTodasLasCategorias()
        {
            return _categoriaDAL.ObtenerCategorias();
        }
    }
}
