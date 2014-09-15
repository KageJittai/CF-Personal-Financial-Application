using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Application.Models;
using Application.Security;

namespace Application.DataModels
{
    public interface IUserDataAccess
    {
        Task CreateUser(User user);
        Task UpdateUser(User user);
        Task DeleteUser(int Id);
        Task<User> FindUser(int? Id, string Email);

        Task CreateUserLogin(int UserId, string Provider, string UserKey);
        Task UpdateUserLogin(int UserId, string Provider, string UserKey);
        Task DeleteUserLogin(int UserId, string Provider);
        Task<IList<UserLogin>> GetUserLogins(int UserId);
        Task<User> FindUserByLogin(string Provider, string UserKey);   
    }
}