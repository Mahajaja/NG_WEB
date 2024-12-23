using System;

namespace Entity
{
    public class Evidencias_E
    {
        public int ID_Evidencia { get; set; }
        public int ID_Tabla { get; set; }
        public string Evidencia_Base64 { get; set; }
        public string NombreArchivo { get; set; }
        public int IdUsuario { get; set; }
        public DateTime FechaInserto { get; set; }
        public int ID_TipoEvidencia { get; set; }
    }
}
