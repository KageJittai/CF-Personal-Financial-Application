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
    public class BudgetController : ApiController
    {
        [HttpGet]
        public async Task<IHttpActionResult> Get()
        {
            return Ok(await Database.GetBudget(CurrentUser.HouseholdId));
        }

        [HttpPost]
        public async Task<IHttpActionResult> Post([FromBody] BudgetModel model)
        {
            model.HouseholdId = CurrentUser.HouseholdId;
            await Database.CreateBudget(model);

            return Ok();
        }

        [HttpPut]
        public async Task<IHttpActionResult> Put([FromUri] int? id, [FromBody] BudgetModel model)
        {
            if (id == null)
                return BadRequest();

            model.HouseholdId = CurrentUser.HouseholdId;
            await Database.CreateBudget(model);

            return Ok();
        }

        [HttpDelete]
        public async Task<IHttpActionResult> Put([FromUri] int? id)
        {
            if (id == null)
                return BadRequest();

            await Database.DeleteBudget(CurrentUser.HouseholdId, id.Value);

            return Ok();
        }


        #region Helper
        private ApplicationUserManager _userManager;
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

        public IBudgetDataAccess Database
        {
            get
            {
                return HttpContext.Current.GetOwinContext().Get<SqlConnection>().As<IBudgetDataAccess>();
            }
        }

        public User CurrentUser
        {
            get
            {
                return UserManager.FindByIdAsync(User.Identity.GetUserId<int>()).Result;
            }
        }
        #endregion
    }
}
