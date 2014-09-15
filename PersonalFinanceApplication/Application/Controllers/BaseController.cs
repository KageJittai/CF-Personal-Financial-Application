using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Application.Security;

namespace Application.Controllers
{
    public class BaseController : Controller
    {
        public User CurrentUser
        {
            get
            {
                return UserManager.FindById(User.Identity.GetUserId<int>());
            }
        }

        private ApplicationUserManager _userManager = null;
        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            protected set
            {
                _userManager = value;
            }
        }

        private ApplicationSignInManager _signInManager = null;
        public ApplicationSignInManager SignInManager
        {
            get
            {
                return _signInManager ?? HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
            }
            protected set
            {
                _signInManager = value;
            }        }
    }
}