using Server.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;
using Owin;
using Microsoft.Owin;
using Insight.Database;
using Microsoft.AspNet.Identity.Owin;
using System.Threading.Tasks;

namespace Server.Controllers
{
    [RoutePrefix("account")]
    public class AccountController : ApiController
    {
        [HttpGet, Route("test")]
        [ResponseType(typeof(string))]
        public IHttpActionResult MyTest()
        {
            //db = HttpContext.Current.GetOwinContext().Get<SqlConnection>().As<>();
            return Ok();
        }
    }
}
