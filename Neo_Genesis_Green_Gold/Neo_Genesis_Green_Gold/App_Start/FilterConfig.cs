using System.Web;
using System.Web.Mvc;

namespace Neo_Genesis_Green_Gold
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
