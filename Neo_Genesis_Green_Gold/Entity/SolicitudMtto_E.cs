using System;

namespace Entity
{
    public class SolicitudMtto_E
    {
        public int IdSolicitud { get; set; }
        public string FolioSolicitud { get; set; }
        public string FechaRegistro { get; set; }
        public string HoraRegistro { get; set; }
        public int IdUbicacion { get; set; }
        public int IdEmpleado { get; set; }
        public string NombreEmpleado { get; set; }
        public string ApellidoEmpleado { get; set; }
        public int IdCategoria { get; set; }
        public string CategoriaNombre { get; set; }
        public int IdMaquinaria { get; set; }
        public string NombreMaquinaria { get; set; }
        public string OtroLugar { get; set; }
        public int Horometro { get; set; }
        public string FechaServicio { get; set; }
        public string FechaEntrega { get; set; }
        public string GradoUrgencia { get; set; }
        public int IdResponsable { get; set; }
        public string NombreResponsable { get; set; }
        public string ApellidoResponsable { get; set; }
        public float CostoReparacion { get; set; }
        public string TipoServicio { get; set; }
        public int IdRespReparacion { get; set; }
        public string NombreResponsableReparacion { get; set; }
        public string ProveedorReparacion { get; set; }
        public string DescripcionProblema { get; set; }
        public string ImgEvidencia { get; set; }
        public string ImgEvidencia2 { get; set; }
        public string ImgEvidencia3 { get; set; }
        public string ImgEvidencia4 { get; set; }
        public string Estatus { get; set; }
        public int IdUsuario { get; set; }
    }
}
