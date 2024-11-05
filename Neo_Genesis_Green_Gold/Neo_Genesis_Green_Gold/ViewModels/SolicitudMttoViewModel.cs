using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Entity;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class SolicitudMttoViewModel
    {
        // Campos de la tabla SOLICITUD_MTTO
        public int IdSolicitud { get; set; }

        [Display(Name = "Folio Solicitud")]
        public string FolioSolicitud { get; set; }

        [Display(Name = "Fecha de Registro")]
        [Required]
        public string FechaRegistro { get; set; }

        [Display(Name = "Hora de Registro")]
        [Required]
        public string HoraRegistro { get; set; }

        [Display(Name = "Ubicación")]
        [Required]
        public int IdUbicacion { get; set; }

        [Display(Name = "Empleado que Reporta")]
        [Required]
        public int IdEmpleado { get; set; }

        [Display(Name = "Categoría")]
        public int? IdCategoria { get; set; }

        [Display(Name = "Maquinaria")]
        [Required]
        public int IdMaquinaria { get; set; }

        public string OtroLugar { get; set; }

        public int? Horometro { get; set; }

        [Display(Name = "Fecha del Servicio")]
        public string FechaServicio { get; set; }

        [Display(Name = "Fecha de Entrega")]
        public string FechaEntrega { get; set; }

        [Display(Name = "Grado de Urgencia")]
        public string GradoUrgencia { get; set; }

        [Display(Name = "Responsable de Resolución")]
        public int IdResponsable { get; set; }

        [Display(Name = "Costo de Reparación")]
        public float? CostoReparacion { get; set; }

        [Display(Name = "Tipo de Servicio")]
        public string TipoServicio { get; set; }

        public int? IdRespReparacion { get; set; }

        [Display(Name = "Proveedor de Reparación")]
        public string ProveedorReparacion { get; set; }

        [Display(Name = "Descripción del Problema")]
        [Required]
        public string DescripcionProblema { get; set; }

        // Para las imágenes de evidencia
        public string ImgEvidencia { get; set; }
        public string ImgEvidencia2 { get; set; }
        public string ImgEvidencia3 { get; set; }
        public string ImgEvidencia4 { get; set; }

        [Display(Name = "Estatus")]
        public string Estatus { get; set; }

        public int IdUsuario { get; set; }

        // Listas para Selects en la Vista
        public List<Ubicacion_E> List_Ubicaciones { get; set; } = new List<Ubicacion_E>();
        public List<Empleados_E> List_Empleados { get; set; } = new List<Empleados_E>();
        public List<Maquinaria_E> List_Maquinarias { get; set; } = new List<Maquinaria_E>();
        public List<Empleados_E> List_Responsables { get; set; } = new List<Empleados_E>();
    }
}
