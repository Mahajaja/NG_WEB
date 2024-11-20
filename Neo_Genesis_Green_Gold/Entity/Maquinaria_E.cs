using System;

namespace Entity
{
    public class Maquinaria_E
    {
        public int IdMaquinaria { get; set; }
        public string NoEconomico { get; set; }
        public string FolioRegistro { get; set; }
        public string HoraRegistro { get; set; }
        public string FechaRegistro { get; set; }
        public string Marca { get; set; }
        public string Modelo { get; set; }
        public string NoMotor { get; set; }
        public string Especificacion { get; set; }
        public int IdCategoriaEstado { get; set; }
        public int IdUbicacion { get; set; }
        public int IdCategoria { get; set; }
        public int IdSubcategoria { get; set; }
        public string ImgMaquinaria { get; set; }
        public string ImgFactura { get; set; }
        public int IdUsuario { get; set; }
    }
}
