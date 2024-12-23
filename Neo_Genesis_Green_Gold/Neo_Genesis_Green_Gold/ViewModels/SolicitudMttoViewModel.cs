using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Entity;

namespace Neo_Genesis_Green_Gold.ViewModels
{
    public class SolicitudMttoViewModel
    {
       

        public SolicitudMtto_E SolicitudMantenimientoMode = new SolicitudMtto_E();
        public List<Ubicacion_E> List_Ubicaciones { get; set; } = new List<Ubicacion_E>();
        public List<Empleados_E> List_Empleados { get; set; } = new List<Empleados_E>();
        public List<Maquinaria_E> List_Maquinarias { get; set; } = new List<Maquinaria_E>();
        public List<Empleados_E> List_Responsables { get; set; } = new List<Empleados_E>();
        public List<Empleados_E> List_ServicioInterno { get; set; } = new List<Empleados_E>();
        public List<Categoria_E> List_Categorias { get;set; } = new List<Categoria_E>();
    }
}
