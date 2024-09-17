using System;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.Google;
using Owin;
using Neo_Genesis_Green_Gold.Models;
using Microsoft.AspNet.Identity.EntityFramework;
using Neo_Genesis_Green_Gold.Constants;
using System.Collections.Generic;

namespace Neo_Genesis_Green_Gold
{
    public partial class Startup
    {
        // Para obtener más información sobre cómo configurar la autenticación, visite https://go.microsoft.com/fwlink/?LinkId=301864
        public void ConfigureAuth(IAppBuilder app)
        {
            // Configure el contexto de base de datos, el administrador de usuarios y el administrador de inicios de sesión para usar una única instancia por solicitud
            app.CreatePerOwinContext(ApplicationDbContext.Create);
            app.CreatePerOwinContext<ApplicationUserManager>(ApplicationUserManager.Create);
            app.CreatePerOwinContext<ApplicationSignInManager>(ApplicationSignInManager.Create);

            // Permitir que la aplicación use una cookie para almacenar información para el usuario que inicia sesión
            // y una cookie para almacenar temporalmente información sobre un usuario que inicia sesión con un proveedor de inicio de sesión de terceros
            // Configurar cookie de inicio de sesión
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString("/Account/Login"),
                Provider = new CookieAuthenticationProvider
                {
                    // Permite a la aplicación validar la marca de seguridad cuando el usuario inicia sesión.
                    // Es una característica de seguridad que se usa cuando se cambia una contraseña o se agrega un inicio de sesión externo a la cuenta.  
                    OnValidateIdentity = SecurityStampValidator.OnValidateIdentity<ApplicationUserManager, ApplicationUser>(
                        validateInterval: TimeSpan.FromMinutes(30),
                        regenerateIdentity: (manager, user) => user.GenerateUserIdentityAsync(manager))
                }
            });            
            app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);

            // Permite que la aplicación almacene temporalmente la información del usuario cuando se verifica el segundo factor en el proceso de autenticación de dos factores.
            app.UseTwoFactorSignInCookie(DefaultAuthenticationTypes.TwoFactorCookie, TimeSpan.FromMinutes(5));

            // Permite que la aplicación recuerde el segundo factor de verificación de inicio de sesión, como el teléfono o correo electrónico.
            // Cuando selecciona esta opción, el segundo paso de la verificación del proceso de inicio de sesión se recordará en el dispositivo desde el que ha iniciado sesión.
            // Es similar a la opción Recordarme al iniciar sesión.
            app.UseTwoFactorRememberBrowserCookie(DefaultAuthenticationTypes.TwoFactorRememberBrowserCookie);

            // Quitar los comentarios de las siguientes líneas para habilitar el inicio de sesión con proveedores de inicio de sesión de terceros
            //app.UseMicrosoftAccountAuthentication(
            //    clientId: "",
            //    clientSecret: "");

            //app.UseTwitterAuthentication(
            //   consumerKey: "",
            //   consumerSecret: "");

            //app.UseFacebookAuthentication(
            //   appId: "",
            //   appSecret: "");

            //app.UseGoogleAuthentication(new GoogleOAuth2AuthenticationOptions()
            //{
            //    ClientId = "",
            //    ClientSecret = ""
            //});
            CreateRolesAndUsers();
        }

        private void CreateRolesAndUsers()
        {
            try
            {
                ApplicationDbContext context = new ApplicationDbContext();
                //db = new LeadMeDbContext();

                var roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));
                var UserManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));

                if (!roleManager.RoleExists(UserRoles.SuperAdmin))
                {
                    var role = new IdentityRole();
                    role.Name = UserRoles.SuperAdmin;
                    roleManager.Create(role);
                }


                if (roleManager.RoleExists(UserRoles.SuperAdmin))
                {
                    string userEmail = "spadmin@nggg.com";
                    string userPassword = "12345Ab$";

                    if (UserManager.FindByEmail(userEmail) == null)
                    {
                        var user = new ApplicationUser { UserName = "spadmin", Email = userEmail };
                        var result = UserManager.Create(user, userPassword);
                        if (result.Succeeded)
                        {
                            var result1 = UserManager.AddToRole(user.Id, UserRoles.SuperAdmin);
                        }
                    }

                    var users = new List<(string email, string password, string role, string userName)>
                        {
                            ("COOR.RH@nggg.com", "C0r.Rh23", "Colaborador", "COOR.RH"),
                            ("TI@nggg.com", "9dm1n01%", "Administrador", "TI"),
                            ("USUARIO3@nggg.com", "User.123", "Colaborador", "USUARIO 3"),
                            ("GER.ADMON@nggg.com", "G3r.Adm0n", "Administrador", "GER.ADMON"),
                            ("GERENCIA@nggg.com", "123tamarin", "Administrador", "GERENCIA")
                        };

                    foreach (var (email, password, role, userName) in users)
                    {
                        if (UserManager.FindByEmail(email) == null)
                        {
                            var user = new ApplicationUser { UserName = userName, Email = email };
                            var result = UserManager.Create(user, password);
                            if (result.Succeeded)
                            {
                                UserManager.AddToRole(user.Id, role);
                            }
                        }
                    }


                }

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}