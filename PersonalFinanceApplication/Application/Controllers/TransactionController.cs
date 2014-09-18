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
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System.Threading.Tasks;
using Application.Models;
using Application.DataModels;
using Application.Security;

namespace Application.Controllers
{
    [Authorize]
    public class TransactionController : ApiController
    {
        private ApplicationUserManager _userManager;

        public TransactionController()
        {
        }

        public TransactionController(ApplicationUserManager userManager)
        {
            UserManager = userManager;
        }

        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            protected set
            {
                _userManager = value;
            }
        }

        // GET api/Me
        [HttpGet]
        public async Task<IHttpActionResult> Get(int? id, [FromUri] TransactionSearchModel search)
        {
            if (id == null)
                return BadRequest();

            search.HouseholdId = CurrentUser.HouseholdId;
            search.AccountId = id.Value;

            IList<TransactionModel> results = await Database.GetTransactions(search);
            return Ok(results);
        }

        public ITransactionDataAccess Database
        {
            get
            {
                return HttpContext.Current.GetOwinContext().Get<SqlConnection>().As<ITransactionDataAccess>();
            }
        }

        public User CurrentUser
        {
            get
            {
                return UserManager.FindByIdAsync(User.Identity.GetUserId<int>()).Result;
            }
        }
    }
}