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
    [RoutePrefix("api/Ledger")]
    public class LedgerController : ApiController
    {
        private ApplicationUserManager _userManager;

        public LedgerController()
        {
        }

        public LedgerController(ApplicationUserManager userManager)
        {
            UserManager = userManager;
        }

        // GET api/Ledger
        public IHttpActionResult Get()
        {
            return Ok(Database.GetHouseholdAccounts(CurrentUser.HouseholdId).Result);
        }

        // DELETE api/Ledger
        public async Task<IHttpActionResult> Delete(int? id)
        {
            if (id == null)
                return BadRequest();

            await Database.DeleteAccount(CurrentUser.HouseholdId, id.Value);

            return Ok();
        }

        // PUT api/Ledger
        public IHttpActionResult Put([FromUri]int? id, [FromBody] LedgerModel model)
        {
            if (id == null || model.Name == null || model.Catagory == null)
                return BadRequest();

            if (model.ParentId == -1 || model.ParentId == 0)
                model.ParentId = null;

            Database.UpdateAccount(CurrentUser.HouseholdId, id.Value, model.Name, model.ParentId);

            return Ok();
        }

        // POST api/Ledger
        public IHttpActionResult Post([FromBody] LedgerModel model)
        {
            if (model.Name == null || model.Catagory == null)
                return BadRequest();

            if (model.ParentId == -1 || model.ParentId == 0)
                model.ParentId = null;

            Database.CreateAccount(CurrentUser.HouseholdId, model.Name, model.ParentId, model.Catagory);

            return Ok();            
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

        public ILedgerDataAccess Database
        {
            get
            {
                return HttpContext.Current.GetOwinContext().Get<SqlConnection>().As<ILedgerDataAccess>();
            }
        }

        public User CurrentUser
        {
            get
            {
                //return (User)HttpContext.Current.User;
                return UserManager.FindByIdAsync(User.Identity.GetUserId<int>()).Result;
            }
        }
    }
}