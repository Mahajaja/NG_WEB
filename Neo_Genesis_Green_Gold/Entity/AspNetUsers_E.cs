using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class AspNetUsers_E
    {
        public string Id { get; set; }  // Campo nvarchar, usualmente utilizado como GUID o identificador único
        public int IdUsuario { get; set; }  // Id del usuario en el sistema
        public int IdEmpleado { get; set; }  // Id del empleado asociado
        public string Email { get; set; }  // Correo electrónico
        public bool EmailConfirmed { get; set; }  // Confirmación de correo electrónico
        public string PasswordHash { get; set; }  // Hash de la contraseña
        public string SecurityStamp { get; set; }  // Valor de seguridad para confirmar autenticidad
        public string PhoneNumber { get; set; }  // Número de teléfono
        public bool PhoneNumberConfirmed { get; set; }  // Confirmación del número de teléfono
        public bool TwoFactorEnabled { get; set; }  // Indica si la autenticación de dos factores está habilitada
        public DateTime? LockoutEndDateUtc { get; set; }  // Fecha y hora en que termina el bloqueo de la cuenta
        public bool LockoutEnabled { get; set; }  // Indica si el bloqueo está habilitado
        public int AccessFailedCount { get; set; }  // Conteo de intentos fallidos de inicio de sesión
        public string UserName { get; set; }  // Nombre de usuario
    }

}
