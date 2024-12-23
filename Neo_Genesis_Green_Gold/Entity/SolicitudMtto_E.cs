using System;

namespace Entity
{
    public class SolicitudMtto_E
    {
        public int IdSolicitud { get; set; } // No nullable
        public string FolioSolicitud { get; set; } // No nullable
        public string FechaRegistro { get; set; } // No nullable
        public string HoraRegistro { get; set; } // No nullable

        // Campos que ahora aceptan nulos
        public int? IdUbicacion { get; set; }
        public int? IdEmpleado { get; set; }
        public int? IdCategoria { get; set; }
        public int? IdMaquinaria { get; set; }
        public int? Horometro { get; set; }
        public string FechaServicio { get; set; }
        public string FechaEntrega { get; set; }
        public string GradoUrgencia { get; set; }
        public int? IdResponsable { get; set; }
        public float? CostoReparacion { get; set; }
        public string TipoServicio { get; set; }
        public int? IdRespReparacion { get; set; }
        public string ProveedorReparacion { get; set; }
        public string DescripcionProblema { get; set; }
        public string ImgEvidencia { get; set; }
        public string ImgEvidencia2 { get; set; }
        public string ImgEvidencia3 { get; set; }
        public string ImgEvidencia4 { get; set; }
        public string Estatus { get; set; }
        public int? IdUsuario { get; set; }
        public int? IdInstalacion { get; set; } // Agregado al modelo

        // Campos adicionales
        public string NombreEmpleado { get; set; }
        public string ApellidoEmpleado { get; set; }
        public string CategoriaNombre { get; set; }
        public string NombreMaquinaria { get; set; }
        public string OtroLugar { get; set; }
        public string NombreResponsable { get; set; }
        public string ApellidoResponsable { get; set; }
        public string NombreResponsableReparacion { get; set; }
        public string NombreUbicacion { get; set; }
        public string no_economico { get; set; }
        public string Asignado { get; set; }
        public string nombre_referencia { get; set; }
        public string instalacionDescripcion { get; set; }
        public bool TieneEvaluacion { get; set; }
     
    }
}
