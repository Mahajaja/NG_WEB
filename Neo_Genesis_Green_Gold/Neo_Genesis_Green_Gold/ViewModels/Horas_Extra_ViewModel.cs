using Entity;
using System;
using System.Collections.Generic;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class Horas_Extra_ViewModel
    {
        public int ID_HoraExtra {  get; set; }
        public string Img_empleado_nombre { get; set; }
        public List<Empleados_E> List_Empleados { get; set; }
        public string Ubicacion { get; set; }
        public string FechaCompensacion { get; set; }
        public int? HorasExtra { get; set; } // Permitir valores nulos si no se especifican horas
        public string Evidencia1 { get; set; } // Base64 o ruta de la evidencia 1
        public string Evidencia2 { get; set; } // Base64 o ruta de la evidencia 2
        public string Motivo { get; set; }
        public string Observaciones { get; set; } // Campo opcional, puede ser nulo
        public int? IdResponsable { get; set; } // ID del responsable
        public string Folio { get; set; }
        public Horas_Extras_E HorasExtrasModel { get; set; } // Model para los detalles de la hora extra
    }
}
