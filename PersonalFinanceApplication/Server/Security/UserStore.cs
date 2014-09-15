using Microsoft.AspNet.Identity;
using Server.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Server.DataModels;

namespace Server.Security
{
    public class UserStore :
        IUserStore<User, int>,
        IUserEmailStore<User, int>,
        IUserPasswordStore<User, int>,
        IUserLoginStore<User, int>
    {
        private IUserDataAccess db;

        public UserStore(IUserDataAccess data)
        {
            db = data;
        }

        public Task CreateAsync(User user)
        {
            return db.CreateUser(user);  
        }

        public Task DeleteAsync(User user)
        {
            return db.DeleteUser(user.Id);
        }

        public Task<User> FindByIdAsync(int userId)
        {
            return db.FindUser(userId, null);
        }

        public Task<User> FindByNameAsync(string userName)
        {
            return db.FindUser(null, userName);
        }

        public Task UpdateAsync(User user)
        {
            return db.UpdateUser(user);
        }

        public Task<User> FindByEmailAsync(string email)
        {
            return db.FindUser(null, email);
        }

        public Task<string> GetEmailAsync(User user)
        {
            return Task.FromResult<string>(user.UserName);
        }

        public Task<bool> GetEmailConfirmedAsync(User user)
        {
            // We don't have a confirmed email, so this is always true
            return Task.FromResult<bool>(true);
        }

        public Task SetEmailAsync(User user, string email)
        {
            user.UserName = email;
            return UpdateAsync(user);
        }

        public Task SetEmailConfirmedAsync(User user, bool confirmed)
        {
            // We can't set email confirmed cause we don't have one
            return Task.FromResult(0);
        }

        public Task<string> GetPasswordHashAsync(User user)
        {
            IList<UserLoginInfo> ret = GetLoginsAsync(user).Result;
            return Task<string>.FromResult<string>(ret.FirstOrDefault(l => l.LoginProvider == "local").ProviderKey);
        }

        public Task<bool> HasPasswordAsync(User user)
        {
            IList<UserLoginInfo> ret = GetLoginsAsync(user).Result;
            return Task.FromResult<bool>(ret.FirstOrDefault(l => l.LoginProvider == "local") != null);
        }

        public Task SetPasswordHashAsync(User user, string passwordHash)
        {
            return db.UpdateUserLogin(user.Id, "local", passwordHash);
        }

        public Task AddLoginAsync(User user, UserLoginInfo login)
        {
            return db.CreateUserLogin(user.Id, login.LoginProvider, login.ProviderKey);
        }

        public Task<User> FindAsync(UserLoginInfo login)
        {
            return db.FindUserByLogin(login.LoginProvider, login.ProviderKey);
        }

        public Task<IList<UserLoginInfo>> GetLoginsAsync(User user)
        {
            IList<UserLogin> a = db.GetUserLogins(user.Id).Result;
            List<UserLoginInfo> ret = a.Select(l => new UserLoginInfo(l.Provider, l.UserKey)).ToList();
            return Task.FromResult<IList<UserLoginInfo>>(ret);
        }

        public Task RemoveLoginAsync(User user, UserLoginInfo login)
        {
            return db.DeleteUserLogin(user.Id, login.LoginProvider);
        }

        public void Dispose()
        {
        }
    }
}