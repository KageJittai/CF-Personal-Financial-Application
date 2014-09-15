using System.Web.Mvc;
using Application.Security;
using Application.Controllers;

namespace Application.Filters
{ 
    class UserInfoAttribute : FilterAttribute, IAuthorizationFilter
    {
        public void OnAuthorization(AuthorizationContext filterContext)
        {
            BaseController context = (BaseController)filterContext.Controller;

            User user = context.CurrentUser;
            if (user != null)
            {
                context.ViewBag.DisplayName = user.FirstName + " " + user.LastName;
            }
            else
            {
                context.ViewBag.DisplayName = "";
            }

        }
    }
}