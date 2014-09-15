using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Microsoft.Owin.Security;
using Application.Security;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace Application.Controllers
{
    [Authorize]
    public class ApplicationController : BaseController
    {
        // GET: Application
        public ActionResult Index()
        {
            return View();
        }
    }
}