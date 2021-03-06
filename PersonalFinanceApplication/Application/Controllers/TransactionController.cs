﻿using System;
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
        public TransactionController()
        {
        }
     
        public TransactionController(ApplicationUserManager userManager)
        {
            UserManager = userManager;
        }

        [HttpGet]
        public async Task<IHttpActionResult> Get([FromUri] TransactionSearchModel search)
        {
            search.HouseholdId = CurrentUser.HouseholdId;

            IList<TransactionModel> results = await Database.GetTransactions(search);
            return Ok(results);
        }

        [HttpPost]
        public async Task<IHttpActionResult> Post([FromBody] TransactionModel model)
        {
            model.HouseholdId = CurrentUser.HouseholdId;
            await Database.CreateTransaction(model);
            return Ok();
        }

        [HttpPut]
        public async Task<IHttpActionResult> Put([FromUri] int id, [FromBody] TransactionModel model)
        {
            model.HouseholdId = CurrentUser.HouseholdId;
            model.Id = id;
            await Database.UpdateTransaction(model);
            return Ok();
        }

        [HttpDelete]
        public async Task<IHttpActionResult> Delete([FromUri] int id)
        {
            await Database.DeleteTransaction(CurrentUser.HouseholdId, id);
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
        #endregion
    }
}