using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Neo_Genesis_Green_Gold.Startup))]
namespace Neo_Genesis_Green_Gold
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
