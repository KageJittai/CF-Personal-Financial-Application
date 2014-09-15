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
        public Task<IList<DetailedLedgerModel>> Get()
        {
            return Database.GetHouseholdAccounts(CurrentUser.HouseholdId);
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
                return UserManager.FindByIdAsync(User.Identity.GetUserId<int>()).Result;
            }
        }
    }
}