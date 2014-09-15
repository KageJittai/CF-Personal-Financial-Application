using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Application.Models;
using Application.DataModels;

namespace Application.Security
{
    public class UserStore :
        IUserStore<User, int>,
        IUserEmailStore<User, int>,
        IUserPasswordStore<User, int>,
        IUserLoginStore<User, int>,
        IUserLockoutStore<User, int>,
        IUserTwoFactorStore<User, int>
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
            return Task<string>.FromResult<string>(user.PasswordHash);
        }

        public Task<bool> HasPasswordAsync(User user)
        {
             return Task.FromResult<bool>(user.PasswordHash != null);
        }

        public Task SetPasswordHashAsync(User user, string passwordHash)
        {
            user.PasswordHash = passwordHash;
            return Task.FromResult(0);
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

        public Task<int> GetAccessFailedCountAsync(User user)
        {
            return Task.FromResult<int>(0);
        }

        public Task<bool> GetLockoutEnabledAsync(User user)
        {
            return Task.FromResult<bool>(false);
        }

        public Task<DateTimeOffset> GetLockoutEndDateAsync(User user)
        {
            return Task.FromResult<DateTimeOffset>(DateTimeOffset.Now);
        }

        public Task<int> IncrementAccessFailedCountAsync(User user)
        {
            return Task.FromResult<int>(1);
        }

        public Task ResetAccessFailedCountAsync(User user)
        {
            return Task.FromResult(0);
        }

        public Task SetLockoutEnabledAsync(User user, bool enabled)
        {
            return Task.FromResult(0);
        }

        public Task SetLockoutEndDateAsync(User user, DateTimeOffset lockoutEnd)
        {
            return Task.FromResult(0);
        }

        public Task<bool> GetTwoFactorEnabledAsync(User user)
        {
            return Task.FromResult<bool>(false);
        }

        public Task SetTwoFactorEnabledAsync(User user, bool enabled)
        {
            return Task.FromResult(0);
        }

        public void Dispose()
        {
        }
    }
}