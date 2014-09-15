using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Server.Models;
using Server.Security;

namespace Server.DataModels
{
    public interface IUserDataAccess
    {
        Task CreateUser(User user);
        Task UpdateUser(User user);
        Task DeleteUser(int UserId);
        Task<User> FindUser(int? UserId, string Email);

        Task CreateUserLogin(int UserId, string Provider, string UserKey);
        Task UpdateUserLogin(int UserId, string Provider, string UserKey);
        Task DeleteUserLogin(int UserId, string Provider);
        Task<IList<UserLogin>> GetUserLogins(int UserId);
        Task<User> FindUserByLogin(string Provider, string UserKey);   
    }
}