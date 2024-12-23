using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class OrdenMantenimientoViewModel
    {
        public OrdenMtto_E OrdenMantenimiento { get; set; } = new OrdenMtto_E();

        public SolicitudMtto_E SolicitudMantenimiento { get; set; } = new SolicitudMtto_E();

        public List<Evidencias_E> Evidencias { get; set; } = new List<Evidencias_E>();

        public List<Empleados_E> List_ServicioInterno { get; set; } = new List<Empleados_E>();
    }
}