namespace Entity
{
    public class Justificante_E
    {
        public int IdJustificante { get; set; }
        public string FechaRegistro { get; set; } // Si la fecha puede ser nula, puedes mantenerlo como string
        public string HoraRegistro { get; set; }
        public string FolioRegistro { get; set; }
        public int? IdUbicacion { get; set; } // Nullable para manejar valores nulos
        public int? IdEmpleado { get; set; } // Nullable para manejar valores nulos
        public string NaturalezaPermiso { get; set; }
        public string EspecificacionPermiso { get; set; }
        public string PermisoSolicitado { get; set; }
        public string OtroPermiso { get; set; }
        public string FechaFalta { get; set; }
        public string HorasParcial { get; set; }
        public string PagoHoras { get; set; }
        public string Observacion { get; set; }
        public string Sueldos { get; set; }
        public int? IdUsuario { get; set; } // Nullable para manejar valores nulos
        public string FechaFin { get; set; }
        public string Institucion { get; set; }
        public string OtraInstitucion { get; set; }
        public string Estatus { get; set; }
        public virtual Empleados_E Empleado { get; set; } // Clase relacionada (opcional)
        public int? IDEstatus { get; set; } // Nullable para manejar valores nulos
        public string Puesto { get; set; }
    }
}
