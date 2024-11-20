using System;

namespace Entity
{
    public class Horas_Extras_E
    {
        public int id_horaExtra { get; set; }  // Siempre se espera que tenga un valor
        public string folio_registro { get; set; }  // No debería ser null, pero manejamos string nulo con valores predeterminados
        public string fecha_registro { get; set; }  // Manejo desde la base de datos
        public string hora_registro { get; set; }
        public int? id_empleado { get; set; }  // Nullable para manejar valores nulos desde DB
        public int? id_responsable { get; set; }  // Responsables de Horas
        public string fecha_compensacion { get; set; }  // Podría ser fecha opcional pero para evitar string nullable manejamos valores predeterminados
        public float? costo_horaExtra { get; set; }  // Valor float nullable
        public float? costo_horaDoble { get; set; }
        public int? horas_porPagar { get; set; }
        public float? costo_horaTriple { get; set; }
        public int? hora_triple { get; set; }
        public float? total_horaDoble { get; set; }
        public float? total_horaTriple { get; set; }
        public float? total_aPagar { get; set; }
        public string motivo_hraExtra { get; set; }
        public string observaciones { get; set; }
        public string img_hraExtra { get; set; }  // En este punto tu archivo de imagen que enlazas para respaldos    
        public int? id_usuario { get; set; }
        public int? ID_Estatus { get; set; }  // Opcional, debe depender de proceso
        public string Estatus { get; set; }
        public virtual Empleados_E empleado { get; set; } //Validación del objeto empleado asociado.
    }
}
