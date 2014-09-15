using System.Web;
using System.Web.Mvc;
using Application.Filters;

namespace Application
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            filters.Add(new UserInfoAttribute());
        }
    }
}
