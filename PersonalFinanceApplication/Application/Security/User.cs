using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.Identity;
using System.Threading.Tasks;
using System.Security.Claims;

namespace Application.Security
{
    public class User : IUser<int>
    {
        // -1 is signal for invalid user
        public int Id { get; set; }
        public string UserName { get; set; }
        public string PasswordHash;
        public string FirstName;
        public string LastName;
        public int HouseholdId;

        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<User, int> manager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here
            return userIdentity;
        }
    }

    public class UserLogin
    {
        public int UserId;
        public string Provider;
        public string UserKey;
    }

}